import React, { useEffect } from 'react'
import { useState } from "react"
import Application from "../../models/Application"
import axios from 'axios';
import { fetchApplicationContract, getAddress } from '../../services/blockchainServices';
import { dataLength } from 'ethers';

export const Step3 = ({setInfoStatus}) => {

  const [form, setForm] = useState(new Application())
  const [fetchStatus, setFetchStatus] = useState("Not fetched")
  const [applications, setApplications] = useState("")
  const [selectedId, setSelectedId] = useState("")


  const handleSetForm = (e) => {
    const { name, value } = e.target
    const id = e.target.selectedOptions[0].getAttribute("data-id")
    setForm(prevForm => ({...prevForm, [name]: value}))
    if(e.target.name === "company"){
      setSelectedId(id)
    }
  }

  useEffect(() => {
    if(!selectedId) {return} else{
    const application = applications.find((c) => {console.log(c.id, selectedId); return c.id === selectedId})
    setForm(prevForm => ({...prevForm, amount: application.amount}))
  }
  }, [form.company])

  const handleFetch = async (e) => {
  e.preventDefault();
    try {
    const response = await axios.get("http://localhost:3001/api/v1/applications/", "utf-8");
    const address = await getAddress();
    const startedApplications = response.data.filter((c) => { return c.owner.trim().toLowerCase() === address.trim().toLowerCase()});
    setApplications(startedApplications)
    setFetchStatus("fetched")
    } catch {
      throw ("error")
    }
  }

  // const handleFetch = async (e) => {
  //   e.preventDefault();
  //   try {
  //     // const address = await getAddress();
  //     // console.log(address);
  //     // // const fetchedApplicationContract = await fetchApplicationContract(address)
  //     // const fetchedApplicationContract = await fetchApplicationContract()
  //     setFetchStatus("fetched")
  //     // setFetchData(fetchedApplicationContract);
  //     contractData("fetchedApplicationContract");
  //   } catch (error) {
  //     console.log(error);
  //   }
  // }

  // const contractData = (data) => {
  //   setContractAddress(data.address || "null")
  //   setProjectName(data.name || "null")
  // }

  const handleSubmit = async (e) => {
    e.preventDefault();
    form.lastUpdate = Date.now();
    form.published = "no";
      
    try {
      const response = await axios.put(`http://localhost:3001/api/v1/applications/change/${contractAddress}`, form);
      console.log(response.data);
      setInfoStatus("Submitted")
    } catch (error) {
      console.error('There was an error submitting the form!', error);
    }
  }

  return (
    <>
      <h2>3. Provide info about your business</h2>
          <div className="button-control">
        <button onClick={handleFetch}>Retrieve your contract</button>
      </div>
    {fetchStatus === "fetched" &&
    <form onSubmit={handleSubmit}>

      <div className="form-control">
        <label htmlFor="applyform-company-name">Company name</label>
        <select id="applyform-company-name" name="company" onChange={handleSetForm}>
          <option defaultValue>Choose company</option>
          {applications.map((application) => <option key={application.id} data-id={application.id}>{application.company}</option>)}
        </select>
        {/* <input type="text" id="applyform-company-name" name="company" onChange={handleSetForm}></input> */}
      </div>

      <div className="form-control">
        <label htmlFor="applyform-amount">Loan amount</label>
        <input type="text" id="applyform-amount" name="amount" readOnly value={form.amount || "loading"}></input>
      </div>
      <div className="form-control">
        <label htmlFor="applyform-business-area">Business area</label>
        <input type="text" id="applyform-business-area" name="area" onChange={handleSetForm}></input>
      </div>
      <div className="form-control">
        <label htmlFor="applyform-reason">Reason for loan application</label>
        <input type="text" id="applyform-reason" name="reason" onChange={handleSetForm}></input>
      </div>
      <div className="form-control">
        <label htmlFor="applyform-time-period">Time period for loan</label>
        <input type="text" id="applyform-time-period" name="time" onChange={handleSetForm}></input>
      </div>
      
      <h3>Contact info</h3>
      <div className="form-control">
        <label htmlFor="applyform-name">Name</label>
        <input type="text" id="applyform-name" name="name" onChange={handleSetForm}></input>
      </div>
      <div className="form-control">
        <label htmlFor="applyform-email">E-mail</label>
        <input type="text" id="applyform-email" name="email" onChange={handleSetForm}></input>
      </div>
      <div className="button-control">
        <button>Submit</button>
      </div>
    </form>
    }
    </>
  )
}
