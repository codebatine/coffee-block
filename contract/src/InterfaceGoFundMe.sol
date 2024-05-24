// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {GoFundMe} from "./UsdcGoFundMe.sol";

contract DeployerGoFundMe {
    GoFundMe[] public goFundMeProjects;
    uint256 projectCount;

    constructor() {
        //createNewProject(100, "First test project", 0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function createNewProject(
        uint256 _goalInUsd,
        string memory _projectName,
        address _linkTokenAddress
    ) public {
        GoFundMe goFundMe = new GoFundMe(
            _goalInUsd,
            _projectName,
            _linkTokenAddress
        );

        goFundMeProjects.push(goFundMe);
        projectCount++;
    }

    function getProjectList() public view returns (GoFundMe[] memory) {
        return goFundMeProjects;
    }

    function getProject(uint256 _index) public view returns (GoFundMe) {
        return goFundMeProjects[_index];
    }
}
