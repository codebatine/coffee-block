// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
//import {DeployerGoFundMe} from "../../src/InterfaceGoFundMe.sol";
import {ControllerGoFundMe} from "../../src/ControllerGoFundMe.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {GoFundMe} from "../../src/UsdcGoFundMe.sol";

contract InterfaceGoFundMeTest is Test {
    GoFundMe firstProject;
    GoFundMe[] projectList;
    ControllerGoFundMe deployer;
    address alice =
        vm.addr(
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );
    IERC20 usdcToken;
    address public usdcTokenAddress;

    function setUp() public {
        //vm.deal(alice, 10 ether);
        //vm.prank(alice);
        deployer = new ControllerGoFundMe();
        deployer.createNewProject(100, "Please give mee moonies");
        firstProject = deployer.getProject(0);
        usdcTokenAddress = firstProject.getUsdAddress();
        usdcToken = IERC20(usdcTokenAddress);
    }

    function testUsdcAddress() public {
        console.log("usdcTokenAddress Interface", usdcTokenAddress);
        assertEq(firstProject.getUsdAddress(), usdcTokenAddress);
    }

    function testToSeeCreatedNewProject() public {
        projectList = deployer.getProjectList();

        assertEq(projectList.length, 1);
    }

    function testToCreateMultipleProjects() public {
        deployer.createNewProject(100, "Please give mee moonies");
        projectList = deployer.getProjectList();

        assertEq(projectList.length, 2);
    }

    function testToFundProject() public {
        uint256 usdcAmount = 100 * 10 ** 6;

        vm.prank(alice);
        usdcToken.approve(address(firstProject), usdcAmount);
        vm.prank(alice);
        firstProject.fund(usdcAmount);
        uint256 amountFunded = firstProject.getTotalBalance();
        assertEq(amountFunded, usdcAmount);
    }

    function testAliceIsOwnerOfNewProject() public {
        vm.deal(alice, 10 ether);
        deployer.createNewProject(100, "Alice Project");
        GoFundMe aliceProject = deployer.getProject(0);
        address(aliceProject);
        address owner = aliceProject.getOwner();
        assertEq(owner, alice);
    }
}
