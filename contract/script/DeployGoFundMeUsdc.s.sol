// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {GoFundMe} from "../src/UsdcGoFundMe.sol";
import {HelperConfigUsdc} from "./HelperConfigUsdc.s.sol";

contract DeployFundMe is Script {
    function run(address _owner) public returns (GoFundMe) {
        HelperConfigUsdc helperConfig = new HelperConfigUsdc();

        //  vm.startBroadcast();
        address usdcTokenAddress = helperConfig.activeNetworkConfig();

        GoFundMe fundMe = new GoFundMe(usdcTokenAddress, _owner);

        // vm.stopBroadcast();
        return fundMe;
    }
}
