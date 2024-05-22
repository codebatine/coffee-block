import React from 'react'
import { useState } from "react"
import Application from "../../models/Application"
import axios from 'axios';

export const Step2 = ({setContractStatus}) => {

  const [contractInput, setContractInput] = useState("")

  const handleSetContractInfo = (e) => {
    const { name, value} = e.target
    setContractInput(prev => ({...prev, [name]: value}))
  }

  
  const handleSubmit = async (e) => {
    e.preventDefault();
    console.log(contractInput);
    try {
      
      setContractStatus("Created")
    } catch (error) {

    }
  }

  return (
    <form onSubmit={handleSubmit}>
        <h2>2. Create contract loan application</h2>
      <div className="form-control">
        <label htmlFor="applyform-company-name">Company name</label>
        <input type="text" id="applyform-company-name" name="company" onChange={handleSetContractInfo}></input>
      </div>
      <div className="form-control">
        <label htmlFor="applyform-amount">Loan amount</label>
        <input type="text" id="applyform-amount" name="amount" onChange={handleSetContractInfo}></input>
      </div>
      <div className="form-control">
        <label htmlFor="applyform-business-area">Deadline</label>
        <input type="text" id="applyform-business-area" name="area" onChange={handleSetContractInfo}></input>
      </div>
      <div className="button-control">
        <button>Submit</button>
      </div>
    </form>
  )
}