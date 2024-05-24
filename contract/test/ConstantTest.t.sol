// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {Constants, ConstChainId} from "../src/constants/Constants.c.sol";

contract TestConstants is Test {
    uint256 constant minimumUSD = 5 * 10 ** 6;

    function testMinimumDollarIsFive() external pure {
        assertEq(Constants.MINIMUM_USD, minimumUSD);
    }

    function testEthUsdDecimals() external pure {
        assertEq(Constants.ETH_USD_DECIMALS, 8);
    }

    function testEthMainnetChainId() external pure {
        assertEq(ConstChainId.ETHEREUM, 1);
    }

    function testSepoliaChainId() external pure {
        assertEq(ConstChainId.SEPOLIA, 11155111);
    }
}
