// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Receiver} from "../src/Receiver.sol";
import {CCIPReceiverHelperConfig} from "./CCIPReceiverHelperConfig.s.sol";

contract DeployReceiver is Script {
    function run() external returns (Receiver) {
        CCIPReceiverHelperConfig helperConfig = new CCIPReceiverHelperConfig();
        address router = helperConfig.activeNetworkConfig();
        vm.startBroadcast();
        Receiver receiver = new Receiver(router);
        vm.stopBroadcast();
        return receiver;
    }
}
