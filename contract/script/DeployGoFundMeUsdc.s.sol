// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {GoFundMe} from "../src/UsdcGoFundMe.sol";
import {HelperConfigUsdc} from "./HelperConfigUsdc.s.sol";

contract DeployFundMe is Script {
    uint256 public constant DECIMALS_USDC = 10 ** 6;

    function run(
        uint256 goal,
        string memory _projectName
    ) public returns (GoFundMe) {
        HelperConfigUsdc helperConfig = new HelperConfigUsdc();

        vm.startBroadcast();
        address usdcTokenAddress = helperConfig.activeNetworkConfig();

        GoFundMe fundMe = new GoFundMe(goal, _projectName, usdcTokenAddress);

        vm.stopBroadcast();
        return fundMe;
    }
}
