import axios from "axios"
import { useEffect, useState } from "react"
import { useParams } from "react-router-dom"
import { funderSend, requestAccount } from "../services/blockchainServices";

export const Details = () => {

  const [startFunding, setstartFunding] = useState(false)
  const [fundingStep2, setFundingStep2] = useState(false)
  const [connected, setConnected] = useState(false)
  const [wallet, setWallet] = useState(null)
  const [application, setApplication] = useState(null)
  const [fundingForm, setFundingForm] = useState({amount: 0, chainId: "000"})

  const { id } = useParams();

  useEffect(() => {
    const getApplications = async () => {
      try {
        const response = await axios.get(`http://localhost:3001/api/v1/applications/application/${id}`)
        console.log(response.data);
        setApplication(response.data)
        
      } catch (error) {
        console.error('There was an error getting the application!', error);
      }
    }

    getApplications();

  }, [])

  const handleClick = (e) => {
    e.preventDefault();
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
      const reponse = await funderSend(fundingForm.amount, application.project)
      
      console.log("!funderSend complete", reponse);
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
            <button className="application-button" onClick={fundingStep2 ? connectWallet : handleClick}>{fundingStep2 ? "Connect Wallet" : "Next step in funding." }</button>
          </div>
          {fundingStep2 && connected && 
          <div>
            <div>
              Wallet {wallet} is connected.
            </div>
            <div>
              <span>Transfer {fundingForm.amount} USDC to ABCDEF.<br/></span>
              <span>Transfer 2 LINK to GHIJKL.<br/></span>
              <span>Wait for transaction to finish before the last step...<br/></span>
            </div>
            <div className="button-control">
            <button className="submit-button" onClick={handleSubmit}>Submit</button>
          </div>
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
