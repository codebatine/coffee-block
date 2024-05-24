// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {GoFundMe} from "../src/UsdcGoFundMe.sol";
import {HelperConfigUsdc} from "./HelperConfigUsdc.s.sol";

contract DeployFundMe is Script {
    uint256 public constant GOAL = 6;
    uint256 public constant DECIMALS_USDC = 10 ** 6;

    uint256 public constant ACTUAL_GOAL = GOAL * DECIMALS_USDC;

    function run() external returns (GoFundMe) {
        HelperConfigUsdc helperConfig = new HelperConfigUsdc();
        address usdcTokenAddress = helperConfig.activeNetworkConfig();

        vm.startBroadcast();

        GoFundMe fundMe = new GoFundMe(
            ACTUAL_GOAL,
            "Buy me a computer",
            usdcTokenAddress
        );

        vm.stopBroadcast();
        return fundMe;
    }
}
