import {
  fetchApplicationContract,
  getProjctOwner,
} from "../../services/blockchainServices";

export const Step1 = ({ connected, connectWallet, address }) => {
  return (
    <>
      <h2>1. Connect wallet to sign up</h2>
      <div className="button-control">
        <button onClick={connectWallet} className={`application-button ${connected}`}>
          {connected === "false" ? "Connect Wallet" : "Wallet Connected"}
        </button>
        <button
          onClick={async () => {
            await getProjctOwner();
          }}
          className="application-button"
        >
          Get Owner
        </button>
      </div>
      <p>Copy the address below 👇</p>
      <br />
      <span>{address}</span>
    </>
  );
};