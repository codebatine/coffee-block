// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

library ChainSelectors {
    uint256 public constant SELECTOR1 = 14767482510784806043;
    uint256 public constant SELECTOR2 = 13264668187771770619;
    uint256 public constant SELECTOR3 = 16015286601757825753;
    uint256 public constant SELECTOR4 = 3478487238524512106;
    uint256 public constant SELECTOR5 = 10344971235874465080;
    uint256 public constant SELECTOR6 = 5224473277236331295;
    uint256 public constant SELECTOR7 = 16281711391670634445;

    function getSelectors() public pure returns (uint256[] memory) {
        uint256[] memory selectors = new uint256[](7);
        selectors[0] = SELECTOR1;
        selectors[1] = SELECTOR2;
        selectors[2] = SELECTOR3;
        selectors[3] = SELECTOR4;
        selectors[4] = SELECTOR5;
        selectors[5] = SELECTOR6;
        selectors[6] = SELECTOR7;
        return selectors;
    }
}
