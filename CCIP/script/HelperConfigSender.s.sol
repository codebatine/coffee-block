// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {ChainIDTestnet, RouterTestnet, USDCAddressTestnet, LINKAddressTestnet} from "../src/constants/Constants.c.sol";

contract HelperConfigSender is Script {
    NetworkConfig public networkConfig;

    struct NetworkConfig {
        address router;
        address usdcAddress;
        address linkAddress;
    }

    constructor() {
        if (block.chainid == ChainIDTestnet.AVALANCHE) {
            networkConfig = getAvalancheConfig();
        } else if (block.chainid == ChainIDTestnet.POLYGON) {
            networkConfig = getPolygonConfig();
        } else if (block.chainid == ChainIDTestnet.ETHEREUM) {
            networkConfig = getSepoliaConfig();
        } else if (block.chainid == ChainIDTestnet.OPTIMISM) {
            networkConfig = getOtimismConfig();
        } else if (block.chainid == ChainIDTestnet.BASE) {
            networkConfig = getBaseSepoliaConfig();
        } else if (block.chainid == ChainIDTestnet.ARBITRUM) {
            networkConfig = getArbitrumSepoliaConfig();
        }
    }

    function getAvalancheConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory avalanceConfig = NetworkConfig({
            router: RouterTestnet.AVALANCHE,
            usdcAddress: USDCAddressTestnet.AVALANCHE,
            linkAddress: LINKAddressTestnet.AVALANCHE
        });
        return avalanceConfig;
    }

    function getPolygonConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory polygonConfig = NetworkConfig({
            router: RouterTestnet.POLYGON,
            usdcAddress: USDCAddressTestnet.POLYGON,
            linkAddress: LINKAddressTestnet.POLYGON
        });
        return polygonConfig;
    }

    function getSepoliaConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            router: RouterTestnet.ETHEREUM,
            usdcAddress: USDCAddressTestnet.ETHEREUM,
            linkAddress: LINKAddressTestnet.ETHEREUM
        });
        return sepoliaConfig;
    }

    function getOtimismConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory optimismConfig = NetworkConfig({
            router: RouterTestnet.OPTIMISM,
            usdcAddress: USDCAddressTestnet.OPTIMISM,
            linkAddress: LINKAddressTestnet.OPTIMISM
        });
        return optimismConfig;
    }

    function getBaseSepoliaConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory baseSepoliaConfig = NetworkConfig({
            router: RouterTestnet.BASE,
            usdcAddress: USDCAddressTestnet.BASE,
            linkAddress: LINKAddressTestnet.BASE
        });
        return baseSepoliaConfig;
    }

    function getArbitrumSepoliaConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        NetworkConfig memory arbitrumSepoliaConfig = NetworkConfig({
            router: RouterTestnet.ARBITRUM,
            usdcAddress: USDCAddressTestnet.ARBITRUM,
            linkAddress: LINKAddressTestnet.ARBITRUM
        });
        return arbitrumSepoliaConfig;
    }
}
