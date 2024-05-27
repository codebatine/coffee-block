// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

library ConstChainId {
    uint32 public constant SEPOLIA = 11155111;
    uint32 public constant ETH_MAINNET = 1;
    uint32 public constant AVALANCE_FUJI = 43113;
    uint32 public constant AVALANCE_MAINNET = 43114;
}

library ConstCCIPRouter {
    address public constant AVALANCE_FUJI =
        0xF694E193200268f9a4868e4Aa017A0118C9a8177;
    address public constant SEPOLIA =
        0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59;
}

library ConstCCIPChainSelector {
    uint64 public constant SEPOLIA = 16015286601757825753;
    uint64 public constant AVALANCE = 14767482510784806043;
}

library ConstLinkTokenAddress {
    address public constant SEPOLIA =
        0x779877A7B0D9E8603169DdbD7836e478b4624789;
    address public constant AVALANCE_FUJI =
        0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
}
