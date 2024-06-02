import { useEffect, useState } from "react";
import {
  detectChain,
  fetchApplicationContract,
  getProjctOwner,
} from "../../services/blockchainServices";

export const Step1 = ({ connected, connectWallet, address }) => {

  const [chainId, setChainId] = useState("")

  useEffect(() => {
    if(!connected){
      return;
    }
    const runChainCheck = async () => {
      try {
        const chain = await detectChain();
        console.log(chain);
        setChainId(chain)
        
      } catch (error) {
        console.log(error);
      }
    }
    runChainCheck();
  }, [connected])

  return (
    <>
      <h2>1. Connect wallet to sign up</h2>
      <div className="button-control">
        <button onClick={connectWallet} className={`application-button ${connected}`}>
          {!connected ? "Connect Wallet" : "Wallet Connected"}
        </button>
        {/* <button
          onClick={async () => {
            await getProjctOwner();
          }}
          className="application-button"
        >
          Get Owner
        </button> */}
      </div>
      {connected && <div>You are connected with: {address},</div> }
      {connected && <div>on chain: {chainId}.</div> }
      <br />
      
    </>
  );
};