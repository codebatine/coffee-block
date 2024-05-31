// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {Receiver} from "../src/Reciever.sol";
import {HelperConfigReciever} from "./HelperConfigReciever.s.sol";

contract DeployReciever is Script {
    //    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    function run() external returns (Receiver) {
        HelperConfigReciever helperConfigReciever = new HelperConfigReciever();
        (address router, address usdcAddress) = (
            helperConfigReciever.networkConfig()
        );

        // vm.startBroadcast();
        Receiver reciever = new Receiver(router, usdcAddress);
        // vm.stopBroadcast();
        return reciever;
    }

    constructor() {
        run();
    }
}
