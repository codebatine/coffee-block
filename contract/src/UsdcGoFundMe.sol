// SPDX-License-Identifier: MIT

/*
 * This contract is a goFundMe contract that allows user to donate to a cause.
 * The cotract has an owner, a goal, a deadline, a balance and a mapping of contributions.
 * This contract will be initialized from a other contract that will be the owner of this contract.
 * The owner will be able to set the goal and deadline of the campaign.
 * The owner will be able to withdraw the funds after the deadline has passed and the goal has been reached.
 * The owner will be able to refund the contributors if the deadline has passed and the goal has not been reached.
 * The contributors will be able to contribute to the campaign. and will have the ability to fund from a
 * different blockchain thrue CCIP (Cross-Chain Interoperability Protocol) from chainlink.
 * The contributors will be able to withdraw their funds if the deadline has passed and the goal has not been reached.
 *
 * This cotract will also use Chainlink pricefeed to get the price of the token that will be used to fund the campaign.
 */

pragma solidity ^0.8.25;

import {Constants} from "./constants/Constants.c.sol";
import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

error NotOwner();

contract GoFundMe {
    IERC20 public usdc;
    string public projectName;
    uint256 public goalInUsd;
    uint256 public totalBalance;
    address[] public funders;
    address public immutable i_owner;
    address public usdcTokenAddress;

    mapping(address => uint256) public m_donations;

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    constructor() {
        i_owner = msg.sender;
        goalInUsd = 6 * 10 ** 6;
        projectName = "Help me to buy a new computer";
        usdc = IERC20(0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238);
    }

    event FundReceived(address indexed funder, uint256 amount);
    event FundsWithdrawn(address indexed owner, uint256 amount);

    function fund(uint256 _amount) public payable {
        require(
            _amount >= Constants.MINIMUM_USD,
            "you need to send more than 5 USD"
        );

        require(
            usdc.transferFrom(msg.sender, address(this), _amount),
            "Donation failed"
        );

        m_donations[msg.sender] += _amount;
        totalBalance += _amount;
        funders.push(msg.sender);

        emit FundReceived(msg.sender, _amount);
    }

    function withdraw() public onlyOwner {
        require(totalBalance >= goalInUsd, "Goal not reached");

        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            m_donations[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }
}
