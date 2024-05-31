// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {ChainIDTestnet, RouterTestnet, USDCAddressTestnet} from "../src/constants/Constants.c.sol";

contract HelperConfig is Script {
    NetworkConfig public networkConfig;

    struct NetworkConfig {
        address router;
        address usdcAddress;
    }

    constructor() {
        if (block.chainid == ChainIDTestnet.AVALANCHE) {
            networkConfig = getAvalancheConfig();
        } else if (block.chainid == ChainIDTestnet.POLYGON) {
            networkConfig = getPolygonConfig();
        }
    }

    function getAvalancheConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory avalanceConfig = NetworkConfig({
            router: RouterTestnet.AVALANCHE,
            usdcAddress: USDCAddressTestnet.AVALANCHE
        });
        return avalanceConfig;
    }

    function getPolygonConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory polygonConfig = NetworkConfig({
            router: RouterTestnet.POLYGON,
            usdcAddress: USDCAddressTestnet.POLYGON
        });
        return polygonConfig;
    }
}
