import axios from "axios"
import { useEffect, useState } from "react"
import { useParams } from "react-router-dom"
import { fetchFunding, funderSend, requestAccount } from "../services/blockchainServices";
import { SENDER_CONTRACT } from "../services/config";

export const Details = () => {

  const [showFunding, setShowFunding] = useState(false)
  const [fundingAmount, setFundingAmount] = useState(null)
  const [startFunding, setstartFunding] = useState(false)
  const [fundingStep2, setFundingStep2] = useState(false)
  const [lastStep, setLastStep] = useState(false)
  const [connected, setConnected] = useState(false)
  const [wallet, setWallet] = useState(null)
  const [application, setApplication] = useState(null)
  const [fundingForm, setFundingForm] = useState({amount: 0, chainId: "000"})
  const [sepoliaTx, setsepoliaTx] = useState(null)
  const [chainlinkTx, setChainlinkTx] = useState(null)

  const { id } = useParams();

  useEffect(() => {
    const getApplications = async () => {
      try {
        const response = await axios.get(`http://localhost:3001/api/v1/applications/application/${id}`)
        setApplication(response.data)
      } catch (error) {
        console.error('There was an error getting the application!', error);
      }
    }

    getApplications();

  }, [])

  const viewFunding = async () => {
    if(showFunding === false){
      try {
        // const funding = await fetchFunding(application.project)
        // console.log(funding);
        setFundingAmount(`https://www.oklink.com/amoy/address/${application.project}`)
      } catch (error) {
        
      }
    }
    setShowFunding(prevState => !prevState)
  }

  const handleClick = (e) => {
    e.preventDefault();
    if(fundingStep2 === true) {
      setLastStep(true)
      return;
    }
    if(startFunding === true){
      setFundingStep2(true)
      return;
    }    
    setstartFunding(true);
  }

  const handleChange = (e) => {
    const {name, value} = e.target
    setFundingForm(prevForm => ({...prevForm, [name]: value}))
  }

  const handleSubmit = async (e) => {
    e.preventDefault();
    console.log("!submit pressed");
    try {
      const reponse = await funderSend(fundingForm.amount, application.index)
      
      console.log("!funderSend complete", reponse);
      setsepoliaTx(reponse.hash)
      setChainlinkTx(reponse.to)

    } catch (error) {
      console.log(error);
    }
  }

  const connectWallet = async () => {
    const response = await requestAccount();
    setConnected(true);
    setWallet(response)
  }

  return (
    <>
      <div className="main-content-x">
        <div className="grid-container">
          {application !== null &&         
          <div className="grid-item-x">
            <h2>Company: {application.company || 'N/A'}</h2>
            <h2>Area: {application.area || 'N/A'}</h2>
            <p>Reason: {application.reason || 'N/A'}</p>
            <p>Amount: {application.amount || 'N/A'}</p>
            <p>Time: {application.time || 'N/A'}</p>
            <p>Details last updated: {new Date(application.lastUpdate).toLocaleDateString("en-US") || 'N/A'}</p>
          <div className="img-container-x"><img src={application.image.src} alt="Coffee cup" /></div>
            <div className="button-control">
              <button className="application-button" onClick={viewFunding}>{showFunding ? "Hide funding progress" : "View funding progress" }</button>
            </div>
            {showFunding && <div>Project funding is available here: <a href={fundingAmount} target="_blank">Project contract address</a></div>}
          
        <div className="button-control">
            <button onClick={handleClick} className={startFunding ? "application-button-disabled" : "application-button"} disabled={startFunding}>
              Fund this project!
            </button>
            </div>
        </div>
        }
        </div>
        {startFunding &&
        <div className="funding-wrapper">
        <section className="funding-form-wrapper">
        <form onSubmit={handleSubmit}>
          <div>Enter the amount you want to fund the project with.</div>
          <div className="form-control">
            <label htmlFor="fund-form-amount">Fund amount</label>
            <input type="text" id="fund-form-amount" name="amount" className={fundingStep2 ? "funding-amount-read" : "funding-amount-write"} readOnly={fundingStep2} value={fundingForm.amount} onChange={handleChange}></input>
          </div>
        </form>
          <div className="button-control">
            <button className={connected ? "application-button-disabled" : "application-button"} onClick={fundingStep2 ? connectWallet : handleClick}>{fundingStep2 ? "Connect Wallet" : "Next step in funding." }</button>
          </div>
          {fundingStep2 && connected && 
          <div>
            <div>
              Wallet {wallet} is connected.
            </div>
            <div>
              <span>Transfer {fundingForm.amount} USDC to {SENDER_CONTRACT.eth_sepholia}.<br/></span>
              <span>Transfer 2 LINK to {SENDER_CONTRACT.eth_sepholia}.<br/></span>
              <span>Wait for both of the transactions to finish before doing the last step.<br/></span>
            </div>
            <div className="button-control">
            <button className={lastStep ? "application-button-disabled" : "application-button"} onClick={handleClick}>{lastStep ? "Continue to the last step.": "Press when the transactions are finished."}</button>
          </div>
            <div className="button-control">
            <button className={!lastStep ? "application-button-disabled" : "application-button"} onClick={handleSubmit} disabled={!lastStep}>Last step</button>
          </div>
          {chainlinkTx && 
          <div>
            <div><a href={`https://sepolia.etherscan.io/address/${sepoliaTx}`} target="_blank">Follow Sepolia transaction</a></div>
              <div><a href={`https://ccip.chain.link/address/${chainlinkTx}`} target="_blank">Follow Chainlink transaction</a></div>
            </div>}
          </div>}
        </section>
        {/* {fundingStep2 && (
  <div className="button-control">
    <button onClick={connectWallet} className="application-button">
    Connect Wallet
    </button>
  </div>)
  } */}
      </div>
      }
      </div>
    </>
  )
}
