To deploy on a local chain:

```
forge script script/DeployGoFundMeUsdc.s.sol:DeployFundMe --rpc-url $ANVIL_RPC_URL  --private-key $ANVIL_KEY  --broadcast --sig "run(uint256,string)" 6 "test"
```
