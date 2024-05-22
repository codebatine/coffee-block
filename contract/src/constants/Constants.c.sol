// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

library Constants {
    uint8 public constant ETH_USD_DECIMALS = 8;
    int256 public constant INITIAL_ETH_USD_PRICE = 2000e8;
    uint256 public constant MINIMUM_USD = 5 * 10 ** 6;
}

library ConstUsdctokenAddress {
    address public constant SEPOLIA =
        0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;
    address public constant ETHEREUM =
        0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
}

library ConstChainId {
    uint32 public constant SEPOLIA = 11155111;
    uint8 public constant ETHEREUM = 1;
}
