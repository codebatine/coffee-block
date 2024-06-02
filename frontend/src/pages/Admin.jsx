import axios from "axios";
import { useEffect, useState } from "react";

export const Admin = () => {

  const [applications, setApplications] = useState([]);

  const handlePublish = async (id, e) => {
    e.preventDefault();
    try {
      await axios.patch(`http://localhost:3001/api/v1/applications/publish/${id}`, { published: "yes" });
      setApplications((prevApplications) =>
        prevApplications.map((application) =>
          application.id === id ? { ...application, published: "yes" } : application
        )
      );
    } catch (error) {
      console.error("There was an error updating the application!", error);
    }
  };

  const handleUnPublish = async (id, e) => {
    e.preventDefault();
    try {
      await axios.patch(`http://localhost:3001/api/v1/applications/publish/${id}`, { published: "no" });
      setApplications((prevApplications) =>
        prevApplications.map((application) =>
          application.id === id ? { ...application, published: "no" } : application
        )
      );
    } catch (error) {
      console.error("There was an error updating the application!", error);
    }
  };

  useEffect(() => {
    const getApplications = async () => {
      try {
        const response = await axios.get('http://localhost:3001/api/v1/applications/');
        setApplications(response.data);
      } catch (error) {
        console.error('There was an error listing the applications!', error);
      }
    };
    getApplications();
  }, []);

  return (
    <div className="content-container">
      <h2>Admin</h2>
      <div className="application-admin-wrapper">
        {applications.length > 0 ? (
          <section>
            {applications.map((application) => (
              <div key={application.id} className="application-admin-display">
                <div className="application-detail" style={{fontWeight: 'bold'}}>{application.company || "company missing"}</div>
                <div className="application-detail">{`${application.amount || "amount missing"} USDC`}</div>
                <div className="application-detail">{application.area || "area missing"}</div>
                <div className="application-detail">{application.reason || "reason missing"}</div>
                <div className="application-detail">{application.time || "time missing"}</div>
                {/* <div className="application-detail">{application.date || "date missing"}</div> */}
                <div className="admin-publish-buttons">
                  {application.published === "no" ? (
                    <button className="application-button" onClick={(e) => handlePublish(application.id, e)}>
                      Unlisted
                    </button>
                  ) : (
                    <button className="application-button" onClick={(e) => handleUnPublish(application.id, e)}>
                      Published
                    </button>
                  )}
                </div>
              </div>
            ))}
          </section>
        ) : (
          <div>Inga applikationer funna</div>
        )}
      </div>
    </div>
  );
};
