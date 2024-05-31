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

  return (
    <div className="main-content">


      <div className="grid-container">
        {/* <h3>Applications</h3> */}
        {applications.length > 0 ? 
        <>{applications.map((application, index) => application.published === "yes" && (
        <div key={application.id} className="grid-item">
          <Link to={`/coffeblock/details/${application.id}`}><div className="img-container"><img src={(application && application.image.src)} alt="Coffee cup" /></div></Link>
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
