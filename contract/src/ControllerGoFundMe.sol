// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {GoFundMe} from "./UsdcGoFundMe.sol";
import {DeployFundMe} from "../script/DeployGoFundMeUsdc.s.sol";
import {ERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/utils/SafeERC20.sol";

contract ControllerGoFundMe {
    using SafeERC20 for ERC20;

    GoFundMe fundMe;
    GoFundMe[] public goFundMeProjects;

    ERC20 public usdc;

    uint256 public projectCount = 0;

    event ProjectCreated(address indexed _owner, GoFundMe _project);

    constructor(address _usdcTokenAddress) {
        usdc = ERC20(_usdcTokenAddress);
    }

    function createNewProject() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run(msg.sender);
        goFundMeProjects.push(fundMe);
        projectCount++;

        usdc.safeApprove(address(fundMe), type(uint256).max);
        emit ProjectCreated(msg.sender, fundMe);
    }

    function crossChainDonation(uint256 _index, uint256 _amount) public {
        GoFundMe project = getProject(_index);
        usdc.safeTransferFrom(msg.sender, address(project), _amount);
        project.fundFromContract(_amount);
    }

    function getProjectList() public view returns (GoFundMe[] memory) {
        return goFundMeProjects;
    }

    function getProject(uint256 _index) public view returns (GoFundMe) {
        require(_index < projectCount, "Index out of bounds");
        return goFundMeProjects[_index];
    }
}
