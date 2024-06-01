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
        } else if (block.chainid == ConstChainId.POLYGON) {
            activeNetworkConfig = getPolygonUsdcConfig();
        } else if (block.chainid == ConstChainId.AVALANCHEFUJI) {
            activeNetworkConfig = getAvalancheFujiConfig();
        } else if (block.chainid == ConstChainId.POLYGON_AMOY) {
            activeNetworkConfig = getPolygonTestUsdcConfig();
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

    function getPolygonUsdcConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory polygonConfig = NetworkConfig({
            usdcTokenAddress: ConstUsdctokenAddress.POLYGON
        });
        return polygonConfig;
    }

    function getAvalancheFujiConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        NetworkConfig memory avalancheConfig = NetworkConfig({
            usdcTokenAddress: ConstUsdctokenAddress.AVALANCHE_FUJI
        });
        return avalancheConfig;
    }

    function getPolygonTestUsdcConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        NetworkConfig memory polygonAmoyConfig = NetworkConfig({
            usdcTokenAddress: ConstUsdctokenAddress.POLYGON_AMOY
        });
        return polygonAmoyConfig;
    }

    function getAnvilUsdcConfig() public returns (NetworkConfig memory) {
        ERC20Mock USDC = new ERC20Mock();
        USDC.mint(
            0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
            100 * Constants.USD_DECIMALS
        );

        NetworkConfig memory anvilConfig = NetworkConfig({
            usdcTokenAddress: address(USDC)
        });
        return anvilConfig;
    }
}
