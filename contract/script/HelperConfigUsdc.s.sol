// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Constants, ConstChainId, ConstUsdctokenAddress} from "../src/constants/Constants.c.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract HelperConfigUsdc is Script {
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address usdcTokenAddress;
    }

    constructor() {
        if (block.chainid == ConstChainId.SEPOLIA) {
            activeNetworkConfig = getSepoliaUsdcConfig();
        } else if (block.chainid == ConstChainId.ETHEREUM) {
            activeNetworkConfig = getMainnetUsdcConfig();
        } else {
            activeNetworkConfig = getAnvilUsdcConfig();
        }
    }

    function getSepoliaUsdcConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            usdcTokenAddress: ConstUsdctokenAddress.SEPOLIA
        });
        return sepoliaConfig;
    }

    function getMainnetUsdcConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory ethConfig = NetworkConfig({
            usdcTokenAddress: ConstUsdctokenAddress.ETHEREUM
        });
        return ethConfig;
    }

    function getAnvilUsdcConfig() public returns (NetworkConfig memory) {
        ERC20Mock USDC = new ERC20Mock();

        NetworkConfig memory anvilConfig = NetworkConfig({
            usdcTokenAddress: address(USDC)
        });
        return anvilConfig;
    }
}
