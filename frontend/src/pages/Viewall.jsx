import axios from "axios";
import { useEffect, useState } from "react"

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

  console.log();

  return (
    <div className="main-content">


      <div className="grid-container">
        {applications.length > 0 ? 
        <>{applications.map((application) => application.published === "yes" && (
        <div key={application.id} className="grid-item">
          <Link to={`/coffeeblock/details/${application.id}`}><div className="img-container"><img src={application.image.src} alt="Coffee cup" /></div></Link>
          <div className="caption"><h2>{application.company || "company missing"}</h2></div>
          <h2>{application.area || "area missing"}</h2>
          <p>{application.reason || "reason missing"}</p>
        </div>)
      )}</>
        :
        <div>Inga applikationer funna</div>
        }
      </div>
    </div>
  )
}
