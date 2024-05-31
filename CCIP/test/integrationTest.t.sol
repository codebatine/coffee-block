// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {Receiver} from "../src/Reciever.sol";
import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {IControllerGoFundMe} from "../interface/IControllerGoFundMe.i.sol";
import {IGoFundMe} from "../interface/IGoFundMe.i.sol";
import {IERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/IERC20.sol";
import {Sender} from "../src/Sender.sol";
import {MockERC20} from "forge-std/mocks/MockERC20.sol";
import {MockGoFundMe} from "./mocks/MockGoFundMe.t.sol";

contract RecieverTest is Test {
    Sender public sender;
    Receiver public receiver;
    MockGoFundMe public R_goFundMe;
    IControllerGoFundMe public controller;
    IGoFundMe public goFundMe;

    IERC20 public Susdc;
    IERC20 public Slink;
    IERC20 public Rusdc;

    IRouterClient private i_SRouter;
    IRouterClient private i_RRouter;

    MockERC20 public SusdcToken;
    MockERC20 public SlinkToken;
    MockERC20 public RusdcToken;

    address ReceiverRouter = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59; // SEPOLIA router
    //address SUSDC = 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f;
    //address RUSDC = 0x1a9C8182C09F50C8318d769245beA52c32BE35BC;
    address i_controller = 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955;
    address SenderRouter = 0x9C32fCB86BF0f4a1A8921a9Fe46de3198bb884B2; //Polygon router

    uint64 public constant ChainSelector_POLY = 16281711391670634445;
    uint64 public constant ChainSelector_SEPOLIA = 16015286601757825753;

    uint256 public gasLimit = 3000000;

    address Alice = vm.addr(0x1);

    function setUp() public {
        vm.deal(Alice, 1 ether);

        // SENDER
        SusdcToken = new MockERC20();
        SusdcToken._mint(Alice, 1000 * 1e6);
        SlinkToken = new MockERC20();
        SlinkToken._mint(Alice, 1000 * 1e18);
        Susdc = IERC20(address(SusdcToken));
        Slink = IERC20(address(SlinkToken));
        i_SRouter = IRouterClient(SenderRouter);
        // RECEIVER
        RusdcToken = new MockERC20();
        Rusdc = IERC20(address(RusdcToken));
        i_RRouter = IRouterClient(ReceiverRouter);
        vm.startPrank(Alice);
        sender = new Sender(address(i_SRouter), address(Slink), address(Susdc));
        receiver = new Receiver(address(i_RRouter), address(Rusdc));
        vm.stopPrank();

        RusdcToken._mint(address(receiver), 1000 * 1e6);
        // Project
        R_goFundMe = new MockGoFundMe(address(Rusdc));

        controller = IControllerGoFundMe(i_controller);
        vm.startPrank(Alice);
        Slink.transfer(address(sender), 4 * 1e18);
        Susdc.transfer(address(sender), 20 * 1e6);
        // SetUP Sender
        sender.setGasLimitAndRecieverForDestinationChain(
            ChainSelector_SEPOLIA,
            gasLimit,
            address(receiver)
        );
        vm.stopPrank();

        // setUp receiver
        vm.startPrank(Alice);
        receiver.setProjectContract(address(R_goFundMe));
        receiver.setSenderForSourceChain(ChainSelector_POLY, address(sender));
        vm.stopPrank();

        vm.deal(address(receiver), 1 ether);

        console.log("Sender: ", address(sender));
        console.log("Receiver: ", address(receiver));
        console.log("i_SRouter: ", address(i_SRouter));
        console.log("i_RRouter: ", address(i_RRouter));
        console.log("Alice: ", Alice);
    }

    function test_setSenderForSourceChain() public {
        vm.prank(Alice);
        receiver.setSenderForSourceChain(ChainSelector_POLY, address(sender));
        assertEq(receiver.s_senders(ChainSelector_POLY), address(sender));
    }

    function test_AliceHasBalanceOnPolygon() public {
        uint256 adjustedBalanceUsdc = 1000 * 1e6 - 20 * 1e6;
        uint256 adjustedBalanceLink = 1000 * 1e18 - 4 * 1e18;

        assertEq(Slink.balanceOf(Alice), adjustedBalanceLink);
        assertEq(Susdc.balanceOf(Alice), adjustedBalanceUsdc);
    }

    function test_AliceHasZeroUsdcBalanceonSEPOLIA() public {
        assertEq(Rusdc.balanceOf(Alice), 0);
    }

    function testSendMessagePayLink() public {
        Client.EVMTokenAmount[]
            memory tokenAmounts = new Client.EVMTokenAmount[](1);
        tokenAmounts[0] = Client.EVMTokenAmount({
            token: address(Rusdc),
            amount: 20
        });
        // Create an EVM2AnyMessage struct in memory with necessary information for sending a cross-chain message
        Client.EVM2AnyMessage memory evm2AnyMessage = Client.EVM2AnyMessage({
            receiver: abi.encode(receiver), // ABI-encoded receiver address
            data: abi.encodeWithSelector(
                IGoFundMe.fundFromContract.selector,
                //address(R_goFundMe),
                20
            ), // Encode the function selector and the arguments of the stake function
            tokenAmounts: tokenAmounts, // The amount and type of token being transferred
            extraArgs: Client._argsToBytes(
                // Additional arguments, setting gas limit
                Client.EVMExtraArgsV1({gasLimit: gasLimit})
            ),
            // Set the feeToken to a feeTokenAddress, indicating specific asset will be used for fees
            feeToken: address(Slink)
        });

        Client.Any2EVMMessage memory dataPackage = Client.Any2EVMMessage({
            messageId: bytes32(0),
            sourceChainSelector: ChainSelector_POLY,
            sender: abi.encode(address(sender)),
            data: abi.encode(evm2AnyMessage),
            destTokenAmounts: tokenAmounts
        });

        // sender.sendMessagePayLINK(ChainSelector_POLY, Alice, 5 * 1e6);
        vm.prank(0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59);
        receiver.ccipReceive(dataPackage);

        assertEq(Rusdc.balanceOf(address(R_goFundMe)), 20 * 1e6);
    }
}
