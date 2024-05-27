// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {ConstChainId, ConstCCIPRouter, ConstLinkTokenAddress} from "../src/constants/Constants.l.sol";

contract CCIPSenderHelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address router;
        address link;
    }

    // Constructor initializes the contract with the router address and the link address.
    constructor() {
        if (block.chainid == ConstChainId.SEPOLIA) {
            activeNetworkConfig = getSepoliaConfig();
        } else if (block.chainid == ConstChainId.AVALANCE_FUJI) {
            activeNetworkConfig = getAvalancheFujiConfig();
        }
    }

    function getSepoliaConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            router: ConstCCIPRouter.SEPOLIA,
            link: ConstLinkTokenAddress.SEPOLIA
        });
        return sepoliaConfig;
    }

    function getAvalancheFujiConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        NetworkConfig memory avalancheFujiConfig = NetworkConfig({
            router: ConstCCIPRouter.AVALANCE_FUJI,
            link: ConstLinkTokenAddress.AVALANCE_FUJI
        });
        return avalancheFujiConfig;
    }
}
