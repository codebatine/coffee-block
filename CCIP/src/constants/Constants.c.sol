// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

library ChainIDTestnet {
    uint8 public constant BSC = 97;
    uint32 public constant AVALANCHE = 43113;
    uint32 public constant ARBITRUM = 421614;
    uint32 public constant BASE = 84532;
    uint32 public constant POLYGON = 80002;
    uint64 public constant OPTIMISM = 11155420;
    uint64 public constant ETHEREUM = 11155111;
}

library RouterTestnet {
    address public constant AVALANCHE =
        0xF694E193200268f9a4868e4Aa017A0118C9a8177;
    address public constant ETHEREUM =
        0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59;
    address public constant OPTIMISM =
        0x114A20A10b43D4115e5aeef7345a1A71d2a60C57;
    address public constant ARBITRUM =
        0x2a9C5afB0d0e4BAb2BCdaE109EC4b0c4Be15a165;
    address public constant POLYGON =
        0x9C32fCB86BF0f4a1A8921a9Fe46de3198bb884B2;
    address public constant BASE = 0xD3b06cEbF099CE7DA4AcCf578aaebFDBd6e88a93;
}

library USDCAddressTestnet {
    address public constant AVALANCHE =
        0x5425890298aed601595a70AB815c96711a31Bc65;
    address public constant ETHEREUM =
        0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;
    address public constant POLYGON =
        0x41E94Eb019C0762f9Bfcf9Fb1E58725BfB0e7582;
    address public constant OPTIMISM =
        0x5fd84259d66Cd46123540766Be93DFE6D43130D7;
    address public constant BASE = 0x036CbD53842c5426634e7929541eC2318f3dCF7e;
    address public constant ARBITRUM =
        0x75faf114eafb1BDbe2F0316DF893fd58CE46AA4d;
}

library LINKAddressTestnet {
    address public constant AVALANCHE =
        0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
    address public constant ETHEREUM =
        0x779877A7B0D9E8603169DdbD7836e478b4624789;
    address public constant POLYGON =
        0x0Fd9e8d3aF1aaee056EB9e802c3A762a667b1904;
    address public constant OPTIMISM =
        0xE4aB69C077896252FAFBD49EFD26B5D171A32410;
    address public constant BASE = 0xE4aB69C077896252FAFBD49EFD26B5D171A32410;
    address public constant ARBITRUM =
        0xb1D4538B4571d411F07960EF2838Ce337FE1E80E;
}

library ChainSelectors {
    uint256 public constant SELECTOR1 = 14767482510784806043;
    uint256 public constant SELECTOR2 = 16015286601757825753;
    uint256 public constant SELECTOR3 = 3478487238524512106;
    uint256 public constant SELECTOR4 = 10344971235874465080;
    uint256 public constant SELECTOR5 = 5224473277236331295;
    uint256 public constant SELECTOR6 = 16281711391670634445;

    function getSelectors() public pure returns (uint256[] memory) {
        uint256[] memory selectors = new uint256[](7);
        selectors[0] = SELECTOR1;
        selectors[1] = SELECTOR2;
        selectors[2] = SELECTOR3;
        selectors[3] = SELECTOR4;
        selectors[4] = SELECTOR5;
        selectors[5] = SELECTOR6;
        return selectors;
    }

    function verifyChainSelector(
        uint256 _selector
    ) external pure returns (bool) {
        uint256[] memory selectors = getSelectors();
        for (uint256 i = 0; i < selectors.length; i++) {
            if (selectors[i] == _selector) {
                return true;
            }
        }
        return false;
    }
}
