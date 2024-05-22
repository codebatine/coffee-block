import { Step3 } from "../components/Apply/Step3"


export const Apply = () => {


  

  return (
    <div className="application-wrapper">
      <div className="step1">
        <h2>1. Connect wallet to sign up</h2>
      </div>
      <div className="step2">
        <h2>2. Create contract loan application</h2>
      </div>
      <div className="step3">
        <Step3 />
      </div>
    </div>
  )
}
