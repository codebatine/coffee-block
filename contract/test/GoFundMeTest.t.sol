// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {goFundMe} from "../src/goFundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";
import {Constants} from "../src/constants/Constants.c.sol";

contract FundMeTest is Test {
    goFundMe fundMe;

    function setUp() external {
        console.log("Deploying FundMe contract...");
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();

        address signer = vm.addr(0x1a11ce);
    }

    function testOwnerIsMsgSender() public view {
        console.log("FundMe i_owner", fundMe.i_owner());
        console.log("msg.sender", msg.sender);
        bool test;
        if (fundMe.i_owner() != address(this)) {
            test = false;
        } else {
            test = true;
        }
        console.log("test", test);
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public view {
        uint256 version = fundMe.getVersion();
        console.log("Price Feed Version", version);
        assertEq(version, 4);
    }

    function testFund() public {
        uint256 ethAmount = 1 ether;
        fundMe.fund{value: ethAmount}();
        uint256 amountFunded = fundMe.addressToAmountFunded(msg.sender);
        assertEq(amountFunded, ethAmount);
    }
}
