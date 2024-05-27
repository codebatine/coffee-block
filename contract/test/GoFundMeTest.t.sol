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
    address public usdcTokenAddress;
    address aliceWithUsdc =
        vm.addr(
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );
    address BobWithProject = vm.addr(0x1a11ce);

    uint256 public goal = 6;
    string public FirstProjectName = "First Project";

    function setUp() external {
        console.log("Deploying GoFundMe contract...");
        DeployFundMe deployFundme = new DeployFundMe();
        vm.prank(aliceWithUsdc);
        fundMe = deployFundme.run(aliceWithUsdc);
        vm.prank(aliceWithUsdc);
        fundMe.SetNameAndGoal(FirstProjectName, goal);
        usdcTokenAddress = fundMe.getUsdAddress();
        usdcToken = IERC20(usdcTokenAddress);
        console.log("alice", aliceWithUsdc);

        uint256 aliceBalance = usdcToken.balanceOf(aliceWithUsdc);
        console.log("aliceBalance", aliceBalance);

        vm.deal(aliceWithUsdc, 1 ether);
    }

    function testUsdcAddress() public {
        assertEq(fundMe.getUsdAddress(), usdcTokenAddress);
    }

    function testfundaProject() public {
        uint256 usdcAmount = 6;

        vm.prank(aliceWithUsdc);
        usdcToken.approve(address(fundMe), usdcAmount * Constants.USD_DECIMALS);
        vm.prank(aliceWithUsdc);
        fundMe.fund(usdcAmount);
        uint256 amountFunded = fundMe.getTotalBalance();
        console.log("amountFunded", amountFunded);
        assertEq(amountFunded, usdcAmount * Constants.USD_DECIMALS);
    }

    function testBobIsOwner() public {
        assertEq(fundMe.i_owner(), address(aliceWithUsdc));
    }

    function testWithdraw() public {
        uint256 usdcAmount = 6;
        vm.prank(aliceWithUsdc);
        usdcToken.approve(address(fundMe), usdcAmount * Constants.USD_DECIMALS);
        vm.prank(aliceWithUsdc);
        fundMe.fund(usdcAmount);
        uint256 amountFunded = fundMe.getTotalBalance();
        assertEq(amountFunded, usdcAmount * Constants.USD_DECIMALS);
        vm.prank(aliceWithUsdc);
        fundMe.withdraw();
        uint256 amountFundedAfterWithdraw = fundMe.getTotalBalance();
        assertEq(amountFundedAfterWithdraw, 0);
    }
}
