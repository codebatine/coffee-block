import axios from "axios"
import { useEffect, useState } from "react"
import { useParams } from "react-router-dom"
import coffee1 from '../content/img/coffee-1-grid.jpg';

export const Details = () => {

  const [application, setApplication] = useState(null)
  const [fundingForm, setFundingForm] = useState({amount: 0, chainId: "000"})

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

  const handleChange = (e) => {
    const {name, value} = e.target
    setFundingForm(prevForm => ({...prevForm, [name]: value}))
  }

  const handleSubmit = (e) => {
    e.preventDefault();
    alert("funding complte")
  }

  return (
    <>
    <div className="main-content-x">
      <div className="grid-container">
          {application &&         
        <div className="grid-item-x">
        <h2>Company: {application.company || 'N/A'}</h2>
        <h2>Area: {application.area || 'N/A'}</h2>
        <p>Reason: {application.reason || 'N/A'}</p>
        <p>Amount: {application.amount || 'N/A'}</p>
        <p>Time: {application.time || 'N/A'}</p>
        <p>Date: {application.lastUpdate || 'N/A'}</p>
        <div className="img-container-x"><img src={application.image.src} alt="Coffee cup" /></div>
        </div>
      }
      </div>
    <section className="fund-wrapper">
      <form onSubmit={handleSubmit}>
        <div className="form-control">
            <label htmlFor="fund-form-amount">Fund amount</label>
            <input type="text" id="fund-form-amount" name="amount" value={fundingForm.amount} onChange={handleChange}></input>
        </div>
        <div className="button-control">
            <button>Submit</button>
          </div>
      </form>
    </section>
    </div>
    </>
  )
}
