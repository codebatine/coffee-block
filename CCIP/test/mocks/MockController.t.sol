// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {MockGoFundMe} from "./MockGoFundMe.t.sol";

contract MockControllerGoFundMe {
    MockGoFundMe fundMe;
    MockGoFundMe[] public goFundMeProjects;

    address private _owner;
    uint256 public projectCount = 0;

    event ProjectCreated(address indexed _owner, MockGoFundMe _project);

    function createNewProject(address _usdcTokenAddress) public {
        _owner = msg.sender;
        fundMe = new MockGoFundMe(_usdcTokenAddress, _owner);
        projectCount++;
        goFundMeProjects.push(fundMe);
        emit ProjectCreated(msg.sender, fundMe);
    }

    function crossChainDonation(uint256 _index, uint256 _amount) public {
        MockGoFundMe project = getProject(_index);
        project.fundFromContract(_amount);
    }

    function getProjectList() public view returns (MockGoFundMe[] memory) {
        return goFundMeProjects;
    }

    function getProject(uint256 _index) public view returns (MockGoFundMe) {
        return goFundMeProjects[_index];
    }
}
