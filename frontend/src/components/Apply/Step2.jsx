import React from 'react'
import { useState } from "react"
import Application from "../../models/Application"
import axios from 'axios';
import { createApplicationContract, createContract, getTransactionDetails } from '../../services/blockchainServices';

export const Step2 = ({setContractStatus}) => {

  const [contractInput, setContractInput] = useState("")

  const handleSetContractInfo = (e) => {
    const { name, value} = e.target
    setContractInput(prev => ({...prev, [name]: value}))
  }

  const handleClick = async (e) => {
    e.preventDefault();
    try {
      const contract = await createContract();
      
    } catch (error) {
      
    }
  }


  const handleSubmit = async (e) => {
    e.preventDefault();
    console.log(contractInput);
    try {
      const applicationContract = await createApplicationContract(contractInput)
      
      databaseInput(contractInput, applicationContract)
    } catch (error) {
      console.log(error);
    }
  }

  const databaseInput = async (contractInput, applicationContract) => {

    const {company, amount} = contractInput
    const data = new Application();
    data.company = company;
    data.amount = amount;
    data.index = "0";
    data.owner = applicationContract.from;

    const txData = getTransactionDetails(applicationContract.hash)

    console.log("txData", txData);

    try {
      const response = await axios.post('http://localhost:3001/api/v1/applications/submit', data);
      console.log(response.data);
      setContractStatus("Created")
    } catch (error) {
      console.error('There was an error submitting the form!', error);
    }
  }
  // const handleFetch = async (e) => {
  //   e.preventDefault();
  //   try {
  //     const address = await getAddress();
  //     console.log(address);
  //     // const fetchedApplicationContract = await fetchApplicationContract(address)
  //     const fetchedApplicationContract = await fetchApplicationContract()
  //     setFetchStatus("fetched")
  //     setFetchData(fetchedApplicationContract);
  //   } catch (error) {
  //     console.log(error);
  //   }
  // }

  return (
    <>
        <h2>2.1 Create contract</h2>
      <div className="button-control">
        <button onClick={handleClick}>Create</button>
      </div>
    <form onSubmit={handleSubmit}>
        <h2>2.2 Specify contract details</h2>
      <div className="form-control">
        <label htmlFor="applyform-company-name">Company name</label>
        <input type="text" id="applyform-company-name" name="company" onChange={handleSetContractInfo}></input>
      </div>
      <div className="form-control">
        <label htmlFor="applyform-amount">Loan amount</label>
        <input type="text" id="applyform-amount" name="amount" onChange={handleSetContractInfo}></input>
      </div>
      <div className="button-control">
        <button>Submit</button>
      </div>
    </form>
    </>
  )
}