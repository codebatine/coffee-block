// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

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
        }
    }

    function getAvalancheConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory avalanceConfig = NetworkConfig({
            router: RouterTestnet.AVALANCE,
            usdcAddress: USDCAddressTestnet.AVALANCHE
        });
        return avalanceConfig;
    }
}
