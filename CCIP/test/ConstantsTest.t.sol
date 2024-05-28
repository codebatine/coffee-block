// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";

import {ChainSelectors} from "../src/constants/Constants.c.sol";

contract ConstantsTest is Test {
    function setUp() external pure {}

    function testSelectors() external pure {
        uint256[] memory selectors = ChainSelectors.getSelectors();
        assertEq(selectors[0], 14767482510784806043);
        assertEq(selectors[1], 13264668187771770619);
        assertEq(selectors[2], 16015286601757825753);
        assertEq(selectors[3], 3478487238524512106);
        assertEq(selectors[4], 10344971235874465080);
        assertEq(selectors[5], 5224473277236331295);
        assertEq(selectors[6], 16281711391670634445);
    }

    function testForLoop() external {
        uint256[] memory selectors = ChainSelectors.getSelectors();
        for (uint256 i = 0; i < selectors.length; i++) {
            console.logUint(selectors[i]);
        }
    }
}
