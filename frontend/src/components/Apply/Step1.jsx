export const Step1 = ({connected, connectWallet, address}) => {

  return (
    <>
      <h2>1. Connect wallet to sign up</h2>
      <div className="button-control">
        <button onClick={connectWallet} className={connected}>{connected === "false" ? "Connect" : "Connected" }</button>
      </div>
      <span>{address}</span>
    </>
  )
}