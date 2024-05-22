// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {GoFundMe} from "../src/UsdcGoFundMe.sol";
import {HelperConfigUsdc} from "./HelperConfigUsdc.s.sol";

contract DeployFundMe is Script {
    function run() external returns (GoFundMe) {
        HelperConfigUsdc helperConfig = new HelperConfigUsdc();
        address usdcTokenAddress = helperConfig.activeNetworkConfig();

        vm.startBroadcast();

        GoFundMe fundMe = new GoFundMe(usdcTokenAddress);

        vm.stopBroadcast();
        return fundMe;
    }
}
