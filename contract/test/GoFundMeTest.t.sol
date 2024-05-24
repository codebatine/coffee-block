// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {GoFundMe} from "../src/UsdcGoFundMe.sol";
import {DeployFundMe} from "../script/DeployGoFundMeUsdc.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Constants} from "../src/constants/Constants.c.sol";

error CorrectError();

contract GoFundMeTest is Test {
    GoFundMe fundMe;
    IERC20 usdcToken;
    // DeployFundMe DeployerFundMe;
    address public usdcTokenAddress;
    address aliceWithUsdc =
        vm.addr(
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );

    function setUp() external {
        console.log("Deploying GoFundMe contract...");
        DeployFundMe deployFundme = new DeployFundMe();
        fundMe = deployFundme.run();
        usdcTokenAddress = fundMe.getUsdAddress();
        usdcToken = IERC20(usdcTokenAddress);
        console.log("alice", aliceWithUsdc);

        uint256 aliceBalance = usdcToken.balanceOf(aliceWithUsdc);
        console.log("aliceBalance", aliceBalance);
    }

    function testUsdcAddress() public {
        assertEq(fundMe.getUsdAddress(), usdcTokenAddress);
    }

    function testfundaProject() public {
        uint256 usdcAmount = 6 * 10 ** 6;

        vm.prank(aliceWithUsdc);
        usdcToken.approve(address(fundMe), usdcAmount);
        vm.prank(aliceWithUsdc);
        fundMe.fund(usdcAmount);
        uint256 amountFunded = fundMe.getTotalBalance();
        assertEq(amountFunded, usdcAmount);
    }
}

//contract FundMeTest is Test {
//goFundMe fundMe;
//
//function setUp() external {
//console.log("Deploying FundMe contract...");
////fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
//DeployFundMe deployFundMe = new DeployFundMe();
//fundMe = deployFundMe.run();
//
////        address signer = vm.addr(0x1a11ce);
//}
//
//function testOwnerIsMsgSender() public view {
//console.log("FundMe i_owner", fundMe.i_owner());
//console.log("msg.sender", msg.sender);
//bool test;
//if (fundMe.i_owner() != address(this)) {
//test = false;
//} else {
//test = true;
//}
//console.log("test", test);
//assertEq(fundMe.i_owner(), msg.sender);
//}
//
//function testPriceFeedVersionIsAccurate() public view {
//uint256 version = fundMe.getVersion();
//console.log("Price Feed Version", version);
//assertEq(version, 4);
//}
//
//function testFund() public {
//uint256 ethAmount = 1 ether;
//fundMe.fund{value: ethAmount}();
//uint256 amountFunded = fundMe.addressToAmountFunded(msg.sender);
//assertEq(amountFunded, ethAmount);
//}
//}
