// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

interface IGoFundMe {
    function fund(uint256 _amount) external;

    function fundFromContract(address _from, uint256 _amount) external;
}
