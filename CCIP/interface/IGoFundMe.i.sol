// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

interface IGoFundMe {
    function fundFromContract(address beneficiary, uint256 _amount) external;
}
