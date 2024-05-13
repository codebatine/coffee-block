// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

library Constants {
    uint8 public constant ETH_USD_DECIMALS = 8;
    int256 public constant INITIAL_ETH_USD_PRICE = 2000e8;
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;

    uint32 public constant SEPOLIA_CHAIN_ID = 11155111;
    uint8 public constant MAINNET_CHAIN_ID = 1;
    uint8 public constant ANVIL_CHAIN_ID = 2;
}
