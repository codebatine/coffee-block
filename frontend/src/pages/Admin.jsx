import axios from "axios";
import { useEffect, useState } from "react"

export const Admin = () => {

  const [applications, setApplications] = useState([])

  const handlePublish = async (id) => {
    console.log("frontend publish");
    console.log(id);
    try {
      // Update the published status in the backend
      await axios.patch(`http://localhost:3001/api/v1/applications/publish/${id}`, { published: "yes" });

      // Update the published status in the local state
      setApplications((prevApplications) =>
        prevApplications.map((application) =>
          application.id === id ? { ...application, published: "yes" } : application
        )
      );
    } catch (error) {
      console.error("There was an error updating the application!", error);
    }
  };

  const handleUnPublish = async (id) => {
    try {
      // Update the published status in the backend
      await axios.put(`http://localhost:3001/api/v1/applications/publish/${id}`, { published: "no" });

      // Update the published status in the local state
      setApplications((prevApplications) =>
        prevApplications.map((application) =>
          application.id === id ? { ...application, published: "no" } : application
        )
      );
    } catch (error) {
      console.error("There was an error updating the application!", error);
    }
  };

  const handleClick = async () => {

    try {
      const response = await axios.get('http://localhost:3001/api/v1/applications/')
      setApplications(response.data)
      console.log(response.data);
    } catch (error) {
      console.error('There was an error listing the applications!', error);
    }
  }
  

  return (
    <div className="admin-wrapper">
      <h2>Admin</h2>

      <div className="application-admin-wrapper">
        <h3>Applications</h3>
        <button onClick={handleClick}>Retrieve applications</button>
        {applications.length > 0 ? 
        <section>{applications.map((application) => 
        <div key={application.id} className="application-admin-display">
          <div>{application.company || "company missing"}</div>
          <div>{application.amount || "amount missing"}</div>
          <div>{application.area || "area missing"}</div>
          <div>{application.reason || "reason missing"}</div>
          <div>{application.time || "time missing"}</div>
          <div>{application.date || "date missing"}</div>
          
          <div>{application.published === "no" ? <button className="button-pub" onClick={() => handlePublish(application.id)}>PUBLISH</button> : <button className="button-pub" onClick={() => handleUnPublish(application.id)} >UNPUBLISH</button>}</div>
        </div>
      )}</section>
        :
        <div>Inga applikationer funna</div>
        }
      </div>
    </div>
  )
}
