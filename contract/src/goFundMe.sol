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

contract goFundMe {
    address public owner;
    uint256 public goal;
    uint256 public deadline;
    uint256 public balance;
    mapping(address => uint256) public contributions;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        // implement a function to send data/message to the goFundMe contract owner.
    }

    function withdraw() public onlyOwner {}

    function refund() public {}

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}
