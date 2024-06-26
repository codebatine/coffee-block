import img1 from '../content/img/coffee-10.jpg';
import { Step1 } from "../components/Apply/Step1"
import { Step2 } from "../components/Apply/Step2"
import { Step3 } from "../components/Apply/Step3"

import { useState } from "react"
import { requestAccount, walletChecker } from "../services/blockchainServices"

import { useNavigate } from 'react-router-dom';

export const Apply = () => {

  const navigate = useNavigate();

  const [step, setStep] = useState("step0");

  const [connected, setConnected] = useState(false);
  const [address, setAddress] = useState("");
  const [contractStatus, setContractStatus] = useState("Not created")
  const [infoStatus, setInfoStatus] = useState("Not submitted")
  const [projectId, setProjectId] = useState("")

  const connectWallet = async () => {
    const response = await requestAccount();
    if(response) {
      setConnected(true)
      setAddress(response)
      // loadReadContract(CONTRTACT_ADDRESS)
      // loadWriteContract(CONTRTACT_ADDRESS)
    }
  }

  const handleNavigate = () => {
    navigate(`/coffeeblock/details/${projectId}`);
  }

  return (
    <div className="application-wrapper">
      {step === "step0" &&  (
      <div className="step0">
        <br/>
          <h2>Apply For Funding</h2>
          <img className="responsive-img" src={img1} alt="Coffee." />
          <br/>
          <p>1. Connect your wallet to log in.</p>
          <p>2. Create a contract for your application.</p>
          <p>3. Input your business details.</p>
          <br/>
          <button className="application-button" onClick={()=> setStep("step3")}>Go to step 3</button>

        <div className="button-control">
          <button className="application-button" onClick={()=> {setStep("step1"); walletChecker();}}>Start application process</button>
        </div>

        </div>
        )} 
      {step === "step1" && (
      <div className="step1">
        <Step1 connected={connected} connectWallet={connectWallet} address={address}/>
        {address && 
        <div className="button-control">
        <button className="application-button" onClick={()=> setStep("step2")}>Go to step 2</button>
        </div>
                }
      </div>
      )}
      {step === "step2" && (
      <div className="step2">
        <Step2 setContractStatus={setContractStatus} contractStatus={contractStatus}/>
        {contractStatus === "Created" &&
        <div className="button-control">
          <button className="application-button" onClick={()=> setStep("step3")}>Go to step 3</button>
        </div>
        }
      </div>
      )}
      {step === "step3" && (
      <div className="step3">
        <Step3 setInfoStatus={setInfoStatus} infoStatus={infoStatus} setProjectId={setProjectId}/>
        {infoStatus === "Submitted" &&
        <div className="button-control">
        <button className="application-button" onClick={handleNavigate}>View your application</button>
        </div>
      }
      </div>
      )}
    </div>
  )
}