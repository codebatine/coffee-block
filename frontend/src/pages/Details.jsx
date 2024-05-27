import axios from "axios"
import { useEffect, useState } from "react"
import { useParams } from "react-router-dom"
import coffee1 from '../content/img/coffee-1-grid.jpg';

export const Details = () => {

  const [application, setApplication] = useState({})

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

  }, [id])

  return (
    <div className="main-content-x">
      <div className="grid-container">
        <div className="grid-item-x">
        <h2>Company: {application.company || 'N/A'}</h2>
        <h2>Area: {application.area || 'N/A'}</h2>
        <p>Reason: {application.reason || 'N/A'}</p>
        <p>Amount: {application.amount || 'N/A'}</p>
        <p>Time: {application.time || 'N/A'}</p>
        <p>Date: {application.date || 'N/A'}</p>
        <div className="img-container-x"><img src={coffee1} alt="Coffee cup" /></div>
        </div>
      </div>
    </div>
  )
}
