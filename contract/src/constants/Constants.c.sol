// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

library Constants {
    uint8 public constant ETH_USD_DECIMALS = 8;
    int256 public constant INITIAL_ETH_USD_PRICE = 2000e8;
    uint256 public constant MINIMUM_USD = 5 * 1e6;
    uint256 public constant USD_DECIMALS = 1e6;
}

library ConstUsdctokenAddress {
    address public constant SEPOLIA =
        0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;
    address public constant AVALANCHE_FUJI =
        0x5425890298aed601595a70AB815c96711a31Bc65;
    address public constant POLYGON =
        0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359;
    address public constant ETHEREUM =
        0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public constant POLYGON_AMOY =
        0x41E94Eb019C0762f9Bfcf9Fb1E58725BfB0e7582;
}

library ConstChainId {
    uint32 public constant SEPOLIA = 11155111;
    uint8 public constant ETHEREUM = 1;
    uint32 public constant AVALANCHEFUJI = 43113;
    uint32 public constant POLYGON = 137;
    uint32 public constant POLYGON_AMOY = 80002;
}
