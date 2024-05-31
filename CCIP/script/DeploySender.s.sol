// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {Sender} from "../src/Sender.sol";
import {HelperConfigSender} from "./HelperConfigSender.s.sol";

contract DeployReciever is Script {
    function run() public returns (Sender) {
        HelperConfigSender helperConfigReciever = new HelperConfigSender();
        (address router, address usdcAddress, address linkAdderss) = (
            helperConfigReciever.networkConfig()
        );

        vm.startBroadcast();
        Sender sender = new Sender(router, linkAdderss, usdcAddress);
        vm.stopBroadcast();
        return sender;
    }
}
