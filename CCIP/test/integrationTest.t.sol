// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {Receiver} from "../src/Reciever.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {IControllerGoFundMe} from "../interface/IControllerGoFundMe.i.sol";
import {IGoFundMe} from "../interface/IGoFundMe.i.sol";
import {IERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/IERC20.sol";

contract DummyController {
    function getProject(uint256 index) external view returns (address) {
        return address(0);
    }

    function createProject() external returns (address) {
        return address(0);
    }
}

contract RecieverTest is Test {
    Receiver public receiver;

    address router = 0x976EA74026E726554dB657fA54763abd0C3a0aa9;
    address usdcToken = 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f;
    address i_controller = 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955;
    IGoFundMe public goFundMe;

    function setUp() public {
        IERC20 usdc = IERC20(usdcToken);
        IControllerGoFundMe controller = IControllerGoFundMe(
            address(new DummyController())
        );
        goFundMe = IGoFundMe(controller.createProject());

        vm.mockCall(
            address(controller),
            abi.encodeWithSelector(controller.createProject.selector),
            abi.encode(address(goFundMe))
        );

        receiver = new Receiver(router, usdcToken, i_controller);
    }

    function test_ccipReceive() public {
        Client.EVMTokenAmount[]
            memory tokenAmounts = new Client.EVMTokenAmount[](1);
        tokenAmounts[0] = Client.EVMTokenAmount({
            token: address(usdcToken),
            amount: 1000 * 10 ** 6
        });

        Client.Any2EVMMessage memory dummyMessage = Client.Any2EVMMessage({
            messageId: keccak256(abi.encodePacked("testMessageId")),
            sourceChainSelector: 1,
            sender: abi.encode(address(this)),
            data: abi.encode(1),
            destTokenAmounts: tokenAmounts
        });

        dummyMessage.destTokenAmounts[0] = Client.EVMTokenAmount({
            token: address(usdcToken),
            amount: 1000 * 10 ** 6
        });

        // Expect the fund function to be called on the goFundMe contract
        vm.expectCall(
            address(goFundMe),
            abi.encodeWithSelector(goFundMe.fund.selector, 1000 * 10 ** 6)
        );

        // Call the ccipReceive function
        receiver.ccipReceive(dummyMessage);
    }
}
