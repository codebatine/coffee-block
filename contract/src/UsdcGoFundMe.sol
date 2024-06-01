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

pragma solidity ^0.8.18;

import {Constants} from "./constants/Constants.c.sol";
import {SafeERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/utils/SafeERC20.sol";
import {ERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/ERC20.sol";

contract GoFundMe {
    using SafeERC20 for ERC20;

    error NotOwner();
    error NotEnoughFunds();
    error InvalidUsdcsToken();

    ERC20 public usdc;
    string public projectName;
    uint256 public goalInUsd;
    uint256 public totalBalance; // The total amount of funds that have been raised.
    address[] public funders; // Creates a list of funderns that the frontend can use together with m_donations to display the funders and the amount they donated.
    address public immutable i_owner;
    address public usdcTokenAddress;
    bool private hasBeenSet = false;
    bool private ProjectIsComplete = false;

    mapping(address => uint256) public m_donations; // A mapping of the donations that have been made by the funders.

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }

    constructor(address _usdcTokenAddress, address _owner) {
        i_owner = _owner;
        if (_usdcTokenAddress == address(0)) revert InvalidUsdcsToken();
        usdc = ERC20(_usdcTokenAddress); // IERC20(0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238);
        usdcTokenAddress = _usdcTokenAddress;
    }

    event FundReceived(address indexed funder, uint256 amount);
    event FundsWithdrawn(address indexed owner, uint256 amount);

    function SetNameAndGoal(
        string memory _projectName,
        uint256 _goalInUsd
    ) public onlyOwner {
        require(!hasBeenSet, "Name and goal has already been set");
        projectName = _projectName;
        goalInUsd = _goalInUsd * Constants.USD_DECIMALS;
        hasBeenSet = true;
    }

    function fund(uint256 _amount) public {
        require(!ProjectIsComplete, "Project is already complete");
        uint256 amountInDecimals = _amount * Constants.USD_DECIMALS;

        require(
            usdc.transferFrom(msg.sender, address(this), amountInDecimals),
            "Transfer failed"
        );

        m_donations[msg.sender] += amountInDecimals;
        totalBalance += amountInDecimals;
        funders.push(msg.sender);

        emit FundReceived(msg.sender, amountInDecimals);
    }

    function fundFromContract(uint256 _amount) external {
        uint256 amountInDecimals = _amount * Constants.USD_DECIMALS;
        //        usdc.transferFrom(_from, address(this), amountInDecimals);
        usdc.safeTransferFrom(msg.sender, address(this), amountInDecimals);
        m_donations[msg.sender] += amountInDecimals;
        totalBalance += amountInDecimals;
        funders.push(msg.sender);
        emit FundReceived(msg.sender, amountInDecimals);
    }

    function withdraw() public onlyOwner {
        require(totalBalance >= goalInUsd, "Goal not reached");

        uint256 amount = usdc.balanceOf(address(this));
        usdc.transfer(i_owner, amount);
        totalBalance = 0;
        ProjectIsComplete = true;
        emit FundsWithdrawn(i_owner, amount);
    }

    function getSignerUSDCBalance() public view returns (uint256) {
        return usdc.balanceOf(msg.sender);
    }

    function getSignerUSDCAllowance() public view returns (uint256) {
        return usdc.allowance(msg.sender, address(this));
    }

    function getUsdAddress() public view returns (address) {
        return usdcTokenAddress;
    }

    function getFunder(uint256 i) public view returns (address) {
        return funders[i];
    }

    function getTotalBalance() public view returns (uint256) {
        return totalBalance;
    }

    function getOwner() public view returns (address) {
        return i_owner;
    }
}
