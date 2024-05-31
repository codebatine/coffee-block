// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {Receiver} from "../src/Reciever.sol";
import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {IControllerGoFundMe} from "../interface/IControllerGoFundMe.i.sol";
import {IGoFundMe} from "../interface/IGoFundMe.i.sol";
import {IERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/IERC20.sol";
import {Sender} from "../src/Sender.sol";
import {MockERC20} from "forge-std/mocks/MockERC20.sol";

contract DummyController {
    function getProject(uint256 index) external view returns (address) {
        return address(0);
    }

    function createProject() external returns (address) {
        return address(0);
    }
}

contract RecieverTest is Test {
    Sender public sender;
    Receiver public receiver;
    IControllerGoFundMe public controller;
    IGoFundMe public goFundMe;

    IERC20 public Susdc;
    IERC20 public Slink;
    IERC20 public Rusdc;

    IRouterClient private i_SRouter;
    IRouterClient private i_RRouter;

    MockERC20 public SusdcToken;
    MockERC20 public SlinkToken;
    MockERC20 public RusdcToken;

    address router = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59; // SEPOLIA router
    //address SUSDC = 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f;
    //address RUSDC = 0x1a9C8182C09F50C8318d769245beA52c32BE35BC;
    address i_controller = 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955;
    address RecRouter = 0x9C32fCB86BF0f4a1A8921a9Fe46de3198bb884B2; //Polygon router

    uint64 public constant ChainSelector_POLY = 16281711391670634445;
    uint64 public constant ChainSelector_SEPOLIA = 16015286601757825753;

    address Alice = vm.addr(0x1);

    function setUp() public {
        vm.deal(Alice, 1 ether);
        // SENDER
        SusdcToken = new MockERC20();
        SusdcToken._mint(Alice, 1000 * 1e6);
        SlinkToken = new MockERC20();
        SlinkToken._mint(Alice, 1000 * 1e18);
        Susdc = IERC20(address(SusdcToken));
        Slink = IERC20(address(SlinkToken));
        i_SRouter = IRouterClient(router);
        // RECEIVER
        RusdcToken = new MockERC20();
        Rusdc = IERC20(address(RusdcToken));
        i_RRouter = IRouterClient(RecRouter);
        vm.startPrank(Alice);
        sender = new Sender(address(i_SRouter), address(Slink), address(Susdc));
        receiver = new Receiver(address(i_RRouter), address(Rusdc));
        vm.stopPrank();

        controller = IControllerGoFundMe(i_controller);
        // address project = controller.createProject();
        // goFundMe = IGoFundMe(address(project));
        vm.startPrank(Alice);
        Slink.transfer(address(sender), 3 * 1e18);
        Susdc.transfer(address(sender), 5 * 1e6);
        // SetUP Sender
        sender.setGasLimitAndRecieverForDestinationChain(
            ChainSelector_POLY,
            3000000,
            address(receiver)
        );
        vm.stopPrank();

        // setUp receiver
        vm.startPrank(Alice);
        receiver.setSenderForSourceChain(
            ChainSelector_SEPOLIA,
            address(sender)
        );
        vm.stopPrank();
    }

    function test_setSenderForSourceChain() public {
        vm.prank(Alice);
        receiver.setSenderForSourceChain(ChainSelector_POLY, address(sender));
        assertEq(receiver.s_senders(ChainSelector_POLY), address(sender));
    }

    function testSendMessagePayLink() public {
        Client.EVMTokenAmount[]
            memory tokenAmounts = new Client.EVMTokenAmount[](1);
        tokenAmounts[0] = Client.EVMTokenAmount({
            token: address(Susdc),
            amount: 5 * 1e6
        });

        Client.EVM2AnyMessage memory dataPackage = Client.EVM2AnyMessage({
            receiver: abi.encode(address(receiver)),
            data: abi.encodeWithSelector(
                IControllerGoFundMe.getProject.selector,
                address(controller),
                1,
                5
            ),
            tokenAmounts: tokenAmounts,
            extraArgs: Client._argsToBytes(
                Client.EVMExtraArgsV1({gasLimit: 3000000})
            ),
            feeToken: address(Slink)
        });

        vm.startPrank(Alice);
        sender.sendMessagePayLINK(ChainSelector_POLY, Alice, 5 * 1e6);
        //        receiver.ccipReceive(dataPackage);
    }
}
