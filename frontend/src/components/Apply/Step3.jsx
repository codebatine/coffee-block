import React from 'react'
import { useState } from "react"
import Application from "../../models/Application"
import axios from 'axios';

export const Step3 = ({setInfoStatus}) => {

  const [form, setForm] = useState(new Application())

  const handleSetForm = (e) => {
    const { name, value} = e.target
    setForm(prevForm => ({...prevForm, [name]: value}))
  }

  
  const handleSubmit = async (e) => {
    e.preventDefault();
    form.date = Date.now();
    form.published = "no";
    
    try {
      const response = await axios.post('http://localhost:3001/api/v1/applications/submit', form);
      console.log(response.data);
      setInfoStatus("Submitted")
    } catch (error) {
      console.error('There was an error submitting the form!', error);
    }
  }

  return (
    <form onSubmit={handleSubmit}>
      <h2>3. Provide info about your business</h2>
      <div className="form-control">
        <label htmlFor="applyform-company-name">Company name</label>
        <select id="applyform-company-name" name="company" onChange={handleSetForm}>
          <option>Company name for contract 1</option>
          <option>Company name for contract 2</option>
          <option>Company name for contract 3</option>
        </select>
        {/* <input type="text" id="applyform-company-name" name="company" onChange={handleSetForm}></input> */}
      </div>
      <div className="form-control">
        <label htmlFor="applyform-amount">Loan amount</label>
        <input type="text" id="applyform-amount" name="amount" onChange={handleSetForm}></input>
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
  )
}
