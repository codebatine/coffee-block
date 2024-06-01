// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

interface IControllerGoFundMe {
    function getProjectList() external view returns (address[] memory);

    function getProject(uint256 _index) external view returns (address);

    function crossChainDonation(uint256 _index, uint256 _amount) external;

    function createNewProject(
        address _usdcTokenAddress
    ) external returns (address);
}
