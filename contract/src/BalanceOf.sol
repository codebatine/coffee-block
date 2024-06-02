// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {ERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/ERC20.sol";

contract BalanceOfContractUsdc {
    function balanceOf(
        address _token,
        address _owner
    ) public view returns (uint256) {
        return ERC20(_token).balanceOf(_owner);
    }
}
