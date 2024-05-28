// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {GoFundMe} from "./UsdcGoFundMe.sol";
import {DeployFundMe} from "../script/DeployGoFundMeUsdc.s.sol";

contract ControllerGoFundMe {
    GoFundMe fundMe;
    GoFundMe[] public goFundMeProjects;
    uint256 projectCount;

    event ProjectCreated(address indexed _owner, GoFundMe _project);

    function createNewProject() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run(msg.sender);
        goFundMeProjects.push(fundMe);
        projectCount++;

        emit ProjectCreated(msg.sender, fundMe);
    }

    function getProjectList() public view returns (GoFundMe[] memory) {
        return goFundMeProjects;
    }

    function getProject(uint256 _index) public view returns (GoFundMe) {
        return goFundMeProjects[_index];
    }
}
