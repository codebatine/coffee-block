// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {OwnerIsCreator} from "@chainlink/contracts-ccip/src/v0.8/shared/access/OwnerIsCreator.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import {IERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/utils/SafeERC20.sol";
import {EnumerableMap} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/utils/structs/EnumerableMap.sol";
import {ChainSelectors} from "./constants/Constants.c.sol";
import {IControllerGoFundMe} from "../interface/IControllerGoFundMe.i.sol";
import {IGoFundMe} from "../interface/IGoFundMe.i.sol";

contract Receiver is CCIPReceiver, OwnerIsCreator {
    using SafeERC20 for IERC20;
    using EnumerableMap for EnumerableMap.Bytes32ToUintMap;

    error NoProjectAddressFound();
    error FailedToFundProject();
    error InvalidUsdcToken(); // Used when the usdc token address is 0
    error InvalidController(); // Used when the controller address is 0
    error InvalidSourceChain(); // Used when the source chain is 0
    error InvalidSenderAddress(); // Used when the sender address is 0
    error NoSenderOnSourceChain(uint64 sourceChainSelector); // Used when there is no sender for a given source chain
    error WrongSenderForSourceChain(uint64 sourceChainSelector); // Used when the sender contract is not the correct one
    error OnlySelf(); // Used when a function is called outside of the contract itself
    error WrongReceivedToken(address usdcToken, address receivedToken); // Used if the received token is different than usdc token
    error CallToStakerFailed(); // Used when the call to the stake function of the staker contract is not succesful
    error NoReturnDataExpected(); // Used if the call to the stake function of the staker contract returns data. This is not expected
    error MessageNotFailed(bytes32 messageId); // Used if you try to retry a message that has no failed

    // Event emitted when a message is received from another chain.
    event MessageReceived(
        bytes32 indexed messageId, // The unique ID of the CCIP message.
        uint64 indexed sourceChainSelector, // The chain selector of the source chain.
        address indexed sender, // The address of the sender from the source chain.
        bytes data, // The data that was received.
        address token, // The token address that was transferred.
        uint256 tokenAmount // The token amount that was transferred.
    );

    event MessageFailed(bytes32 indexed messageId, bytes reason);
    event MessageRecovered(bytes32 indexed messageId);

    enum ErrorCode {
        RESOLVED,
        FAILED
    }

    struct FailedMessage {
        bytes32 messageId;
        ErrorCode errorCode;
    }

    IERC20 private immutable i_usdcToken;
    IControllerGoFundMe private immutable i_controller;
    IGoFundMe private _gofundme;

    mapping(uint64 => address) public s_senders;
    mapping(bytes32 => Client.Any2EVMMessage) public s_messageContents;

    EnumerableMap.Bytes32ToUintMap internal s_failedMessages;

    modifier validateSourceChain(uint64 _sourceChainSelector) {
        if (_sourceChainSelector == 0) revert InvalidSourceChain();
        if (!ChainSelectors.verifyChainSelector(_sourceChainSelector))
            revert InvalidSourceChain();
        _;
    }

    modifier onlySelf() {
        if (msg.sender != address(this)) revert OnlySelf();
        _;
    }

    constructor(
        address _router,
        address _usdcToken,
        address _controller
    ) CCIPReceiver(_router) {
        if (_usdcToken == address(0)) revert InvalidUsdcToken();
        if (_controller == address(0)) revert InvalidController();
        i_usdcToken = IERC20(_usdcToken);
        i_controller = IControllerGoFundMe(_controller);
        i_usdcToken.safeApprove(address(i_controller), type(uint256).max);
    }

    function setSenderForSourceChain(
        uint64 _sourceChainSelector,
        address _sender
    ) external onlyOwner validateSourceChain(_sourceChainSelector) {
        if (_sender == address(0)) revert InvalidSenderAddress();
        s_senders[_sourceChainSelector] = _sender;
    }

    function deleteSenderForSourceChain(
        uint64 _sourceChainSelector
    ) external onlyOwner validateSourceChain(_sourceChainSelector) {
        if (s_senders[_sourceChainSelector] == address(0))
            revert NoSenderOnSourceChain(_sourceChainSelector);
        delete s_senders[_sourceChainSelector];
    }

    function ccipReceive(
        Client.Any2EVMMessage calldata any2EvmMessage
    ) external override onlyRouter {
        // validate the sender contract
        if (
            abi.decode(any2EvmMessage.sender, (address)) !=
            s_senders[any2EvmMessage.sourceChainSelector]
        ) revert WrongSenderForSourceChain(any2EvmMessage.sourceChainSelector);
        /* solhint-disable no-empty-blocks */
        try this.processMessage(any2EvmMessage) {
            // Intentionally empty in this example; no action needed if processMessage succeeds
        } catch (bytes memory err) {
            // Could set different error codes based on the caught error. Each could be
            // handled differently.
            s_failedMessages.set(
                any2EvmMessage.messageId,
                uint256(ErrorCode.FAILED)
            );
            s_messageContents[any2EvmMessage.messageId] = any2EvmMessage;
            // Don't revert so CCIP doesn't revert. Emit event instead.
            // The message can be retried later without having to do manual execution of CCIP.
            emit MessageFailed(any2EvmMessage.messageId, err);
            return;
        }
    }

    /// @notice Serves as the entry point for this contract to process incoming messages.
    /// @param any2EvmMessage Received CCIP message.
    /// @dev Transfers specified token amounts to the owner of this contract. This function
    function processMessage(
        Client.Any2EVMMessage calldata any2EvmMessage
    ) external onlySelf {
        _ccipReceive(any2EvmMessage); // process the message - may revert
    }

    function _ccipReceive(
        Client.Any2EVMMessage memory any2EvmMessage
    ) internal override {
        if (any2EvmMessage.destTokenAmounts[0].token != address(i_usdcToken))
            revert WrongReceivedToken(
                address(i_usdcToken),
                any2EvmMessage.destTokenAmounts[0].token
            );

        (
            bytes4 selector,
            address beneficiary,
            uint256 index,
            uint256 amount
        ) = abi.decode(
                any2EvmMessage.data,
                (bytes4, address, uint256, uint256)
            );

        //        uint256 projectIndex = abi.decode(any2EvmMessage.data, (uint256));
        address goFundMeAddress = i_controller.getProject(index);
        if (goFundMeAddress == address(0)) revert NoProjectAddressFound();
        processFund(goFundMeAddress, beneficiary, amount);

        emit MessageReceived(
            any2EvmMessage.messageId,
            any2EvmMessage.sourceChainSelector, // fetch the source chain identifier (aka selector)
            abi.decode(any2EvmMessage.sender, (address)), // abi-decoding of the sender address,
            any2EvmMessage.data, // received data
            any2EvmMessage.destTokenAmounts[0].token,
            any2EvmMessage.destTokenAmounts[0].amount
        );
    }

    function processFund(
        address goFundMeAddress,
        address from,
        uint256 amount
    ) internal {
        _gofundme = IGoFundMe(goFundMeAddress);

        try _gofundme.fundFromContract(from, amount) {
            // success
        } catch {
            revert FailedToFundProject();
        }
    }

    function retryFailedMessage(
        bytes32 messageId,
        address beneficiary
    ) external onlyOwner {
        if (s_failedMessages.get(messageId) != uint256(ErrorCode.FAILED))
            revert MessageNotFailed(messageId);

        s_failedMessages.set(messageId, uint256(ErrorCode.RESOLVED));

        Client.Any2EVMMessage memory message = s_messageContents[messageId];

        IERC20(message.destTokenAmounts[0].token).safeTransfer(
            beneficiary,
            message.destTokenAmounts[0].amount
        );

        emit MessageRecovered(messageId);
    }

    function getFailedMessages(
        uint256 offset,
        uint256 limit
    ) external view returns (FailedMessage[] memory) {
        uint256 length = s_failedMessages.length();

        uint256 returnLength = (offset + limit > length)
            ? length - offset
            : limit;
        FailedMessage[] memory failedMessages = new FailedMessage[](
            returnLength
        );

        for (uint256 i = 0; i < returnLength; i++) {
            (bytes32 messageId, uint256 errorCode) = s_failedMessages.at(
                offset + i
            );
            failedMessages[i] = FailedMessage(messageId, ErrorCode(errorCode));
        }
        return failedMessages;
    }
}
