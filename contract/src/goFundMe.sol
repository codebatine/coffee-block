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

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";
import {Constants} from "./constants/Constants.c.sol";

error NotOwner();

contract goFundMe {
    address public owner;
    uint256 public goal;
    uint256 public deadline;
    uint256 public balance;
    mapping(address => uint256) public contributions;

    using PriceConverter for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    address public immutable i_owner;
    AggregatorV3Interface private s_priceFeed;

    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(s_priceFeed) >= Constants.MINIMUM_USD,
            "You need to spend more ETH!"
        );
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}
