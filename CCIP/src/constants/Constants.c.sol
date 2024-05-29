// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

library ChainIDMainnet {
    uint8 public constant ETHEREUM = 1;
    uint8 public constant BSC = 56;
    uint8 public constant POLYGON = 137;
    uint8 public constant OPTIMISM = 10;
    uint32 public constant AVALANCHE = 43114;
    uint32 public constant ARBITRUM = 42161;
    uint32 public constant BASE = 8453;
}

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
        0xF4c7E640EdA248ef95972845a62bdC74237805dB;
    address public constant ETHEREUM =
        0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D;
    address public constant OPTIMISM =
        0x3206695CaE29952f4b0c22a169725a865bc8Ce0f;
    address public constant ARBITRUM =
        0x141fa059441E0ca23ce184B6A78bafD2A517DdE8;
    address public constant POLYGON =
        0x849c5ED5a80F5B408Dd4969b78c2C8fdf0565Bfe;
    address public constant BASE = 0x881e3A65B4d4a04dD529061dd0071cf975F58bCD;
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

library USDCAddressMainnet {
    address public constant AVALANCHE =
        0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E;
    address public constant ETHEREUM =
        0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public constant POLYGON =
        0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359;
    address public constant OPTIMISM =
        0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85;
    address public constant BASE = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913;
    address public constant ARBITRUM =
        0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
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
