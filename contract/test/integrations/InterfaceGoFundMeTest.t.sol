// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployerGoFundMe} from "../../src/InterfaceGoFundMe.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract InterfaceGoFundMeTest is Test {
    address alice =
        vm.addr(
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );

    function setUp() public {
        vm.deal(alice, 10 ether);
        vm.prank(alice);
        DeployerGoFundMe deployer = new DeployerGoFundMe();
        deployer.createNewProject(
            100,
            "Please give mee moonies",
            _linkTokenAddress
        );
    }
}
