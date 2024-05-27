// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {ConstChainId, ConstCCIPRouter, ConstLinkTokenAddress} from "../src/constants/Constants.l.sol";

contract CCIPReceiverHelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address router;
    }

    constructor() {
        if (block.chainid == ConstChainId.SEPOLIA) {
            activeNetworkConfig = getSepoliaConfig();
        } else if (block.chainid == ConstChainId.AVALANCE_FUJI) {
            activeNetworkConfig = getAvalancheFujiConfig();
        }
    }

    function getSepoliaConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            router: ConstCCIPRouter.SEPOLIA
        });
        return sepoliaConfig;
    }

    function getAvalancheFujiConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        NetworkConfig memory avalancheFujiConfig = NetworkConfig({
            router: ConstCCIPRouter.AVALANCE_FUJI
        });
        return avalancheFujiConfig;
    }
}
