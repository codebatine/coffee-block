// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Sender} from "../src/Sender.sol";
import {CCIPSenderHelperConfig} from "./CCIPSenderHelperConfig.s.sol";

contract DeploySender is Script {
    function run() external returns (Sender) {
        CCIPSenderHelperConfig helperConfig = new CCIPSenderHelperConfig();
        (address router, address link) = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        Sender sender = new Sender(router, link);
        vm.stopBroadcast();
        return sender;
    }
}
