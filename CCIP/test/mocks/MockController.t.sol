// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {MockGoFundMe} from "./MockGoFundMe.t.sol";
import {ERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/utils/SafeERC20.sol";

contract MockControllerGoFundMe {
    using SafeERC20 for ERC20;

    MockGoFundMe fundMe;
    MockGoFundMe[] public goFundMeProjects;
    ERC20 public usdc;

    address private _owner;
    uint256 public projectCount = 0;

    event ProjectCreated(address indexed _owner, MockGoFundMe _project);

    function createNewProject(address _usdcTokenAddress) public {
        _owner = msg.sender;
        fundMe = new MockGoFundMe(_usdcTokenAddress, _owner);
        projectCount++;
        usdc = ERC20(_usdcTokenAddress);
        usdc.safeApprove(address(fundMe), type(uint256).max);
        goFundMeProjects.push(fundMe);
        emit ProjectCreated(msg.sender, fundMe);
    }

    function getProjectList() public view returns (MockGoFundMe[] memory) {
        return goFundMeProjects;
    }

    function getProject(uint256 _index) public view returns (MockGoFundMe) {
        return goFundMeProjects[_index];
    }
}
