import axios from "axios";
import { useEffect, useState } from "react"
import coffee1 from '../content/img/coffee-1-grid.jpg';
import coffee2 from '../content/img/coffee-2-grid.jpg';
import coffee3 from '../content/img/coffee-3-grid.jpg';
import coffee4 from '../content/img/coffee-4-grid.jpg';
import coffee5 from '../content/img/coffee-5-grid.jpg';
import coffee6 from '../content/img/coffee-6-grid.jpg';
import { Link } from "react-router-dom";

export const Viewall = () => {

  const [applications, setApplications] = useState([])

  useEffect(() => {
    const getApplications = async () => {
  
      try {
        const response = await axios.get('http://localhost:3001/api/v1/applications/')
        setApplications(response.data)
      } catch (error) {
        console.error('There was an error listing the applications!', error);
      }
    }

    getApplications();

  }, []) 

  const images = [coffee1, coffee2, coffee3, coffee4, coffee5, coffee6];
  
  

  return (
    <div className="main-content">


      <div className="grid-container">
        {/* <h3>Applications</h3> */}
        {applications.length > 0 ? 
        <>{applications.map((application, index) => application.published === "yes" && (
        <div key={application.id} className="grid-item">
          <Link to={`/coffeblock/details/${application.id}`}><div className="img-container"><img src={images[index % images.length] || coffee1} alt="Coffee cup" /></div></Link>
          <div className="caption"><h2>{application.company || "company missing"}</h2></div>
          <h2>{application.area || "area missing"}</h2>
          <p>{application.reason || "reason missing"}</p>
          {/* <div>{application.amount || "amount missing"}</div>
          <div>{application.time || "time missing"}</div>
          <div>{application.date || "date missing"}</div> */}
        </div>)
        
      )}</>
        :
        <div>Inga applikationer funna</div>
        }
      </div>
    </div>
  )
}
