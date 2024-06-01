// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {ControllerGoFundMe} from "../../src/ControllerGoFundMe.sol";
import {ERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/utils/SafeERC20.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";
import {GoFundMe} from "../../src/UsdcGoFundMe.sol";

interface Icontroller {
    function createNewProject() external;

    function crossChainDonation(uint256 _index, uint256 _amount) external;

    function getProjectList() external view returns (GoFundMe[] memory);

    function getProject(uint256 _index) external view returns (GoFundMe);
}

contract FirstContract {
    ControllerGoFundMe deployer;
    ERC20 public usdc;

    function sendToController(
        address controller,
        uint64 _index,
        uint256 _amount
    ) public {
        Icontroller(controller).crossChainDonation(_index, _amount);
    }
}

contract CrossChainDonationTest is Test {
    using SafeERC20 for ERC20;

    ControllerGoFundMe deployer;
    FirstContract firstContract;
    GoFundMe firstProject;
    ERC20 public usdc;

    address alice =
        vm.addr(
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );

    function setUp() public {
        vm.deal(address(this), 10 ether);
        vm.deal(alice, 10 ether);

        firstContract = new FirstContract();
        deployer = new ControllerGoFundMe(alice);
        console.log("firstContract", address(firstContract));

        deployer.createNewProject();
        firstProject = deployer.getProject(0);
        address usdcToken = address(firstProject.getUsdAddress());
        usdc = ERC20(usdcToken);

        console.log("firstProject", address(firstProject));
        console.log("deployer", address(deployer));
        console.log("usdcToken", usdcToken);
        console.log("usdc", address(usdc));

        vm.prank(alice);
        usdc.transfer(address(firstContract), 80 * 1e6);
        usdc.safeApprove(address(deployer), type(uint256).max);
        usdc.safeTransferFrom(
            address(firstContract),
            address(deployer),
            40 * 1e6
        );
        uint256 firstContractBalance = usdc.balanceOf(address(firstContract));
        console.log("firstContractBalance", firstContractBalance);

        firstContract.sendToController(address(deployer), 0, 10);
    }

    function testCrossChainDonation() public {
        uint256 amountFunded = firstProject.getTotalBalance();
        assertEq(amountFunded, 100 * 1e6);
    }
}
