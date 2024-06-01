// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {ERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/utils/SafeERC20.sol";
import {MockControllerGoFundMe} from "./MockController.t.sol";
import {IControllerGoFundMe} from "../../interface/IControllerGoFundMe.i.sol";
import {IGoFundMe} from "../../interface/IGoFundMe.i.sol";
import {MockGoFundMe} from "./MockGoFundMe.t.sol";

contract MockFirstContract {
    using SafeERC20 for ERC20;

    ERC20 public usdc;
    IGoFundMe public goFundMe;
    IControllerGoFundMe public controller;
    MockGoFundMe public project;

    constructor(address _usdcTokenAddress, address _controller) {
        usdc = ERC20(_usdcTokenAddress);
        controller = IControllerGoFundMe(_controller);
        usdc.safeApprove(address(controller), type(uint256).max);
    }

    function callControllerCrossChainDonation(
        uint256 _index
    ) public returns (address) {
        address project = controller.getProject(_index);
        return project;
    }
}
