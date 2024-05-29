import React, { useEffect } from 'react'
import { useState } from "react"
import Application from "../../models/Application"
import axios from 'axios';
import { getAddress } from '../../services/blockchainServices';

export const Step3 = ({infoStatus, setInfoStatus, setProjectId}) => {

  const [form, setForm] = useState(new Application())
  const [fetchStatus, setFetchStatus] = useState("Not fetched")
  const [applications, setApplications] = useState([])
  const [application, setApplication] = useState({})
  const [selectedId, setSelectedId] = useState("")



  const handleFetch = async (e) => {
    e.preventDefault();
      try {
      const response = await axios.get("http://localhost:3001/api/v1/applications/", "utf-8");
      const address = await getAddress();
      const startedApplications = response.data.filter((c) => { return c.owner.trim().toLowerCase() === address.trim().toLowerCase()});
      setApplications(startedApplications)
      console.log("!!!", startedApplications);
      setFetchStatus("fetched")
      } catch {
        console.error("Error fetching applications:", error);
      }
    }

  const handleChangeContract = async (e) => {
    console.log(e.target.value);
    const id = e.target.selectedOptions[0].getAttribute("data-id")
    console.log(id);
    if(e.target.name === "company"){
      setSelectedId(id)
    }
  }

  const handleSetForm = (e) => {
    const { name, value } = e.target
    setForm(prevForm => ({...prevForm, [name]: value}))
  }

  useEffect(() => {
    if(!selectedId) {return} else{
    const application = applications.find((c) => {return c.id === selectedId})
    setApplication(application);
  }
  }, [selectedId])

  const handleSubmit = async (e) => {
    e.preventDefault();
    form.company = application.company;
    form.amount = application.amount;
    form.index = application.index;
    form.owner = application.owner;
    form.lastUpdate = Date.now();
    form.published = "no";
      
    try {
      const response = await axios.put(`http://localhost:3001/api/v1/applications/change/${selectedId}`, form);
      console.log(response.data);

      setTimeout(() => {
        setInfoStatus("Submitted")
      }, 1000)

      setProjectId(application.id)

    } catch (error) {
      console.error('There was an error submitting the form!', error);
    }
  }

  return (
    <>
      <h2>3. Provide info about your business</h2> 
        {infoStatus !== "Submitted" ?  (
          <>
        <div className="button-control">
          <button onClick={handleFetch}>Retrieve your contract</button>
        </div>
      {fetchStatus === "fetched" && (
      <>
        <form>
          <div className="form-control">
            <label htmlFor="applyform-company-name">Company name</label>
            <select id="applyform-company-name" name="company" onChange={handleChangeContract}>
              <option defaultValue>Choose company</option>
              {applications.map((application) => <option key={application.id} data-id={application.id}>{application.company}</option>)}
            </select>
          </div>
          <div className="form-control">
            <label htmlFor="applyform-amount">Loan amount</label>
            <input type="text" id="applyform-amount" name="amount" readOnly value={application.amount || ""}></input>
          </div>
        </form>
        <form onSubmit={handleSubmit}>

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
        </>
        )}
      </>
      ) : (<div>Your application has been updated.</div>
    )}
  </>
)}
