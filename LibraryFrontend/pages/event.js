import React, { useState, useEffect, useReducer } from "react";
import Link from 'next/link';
import Router from 'next/router';
import axios from "axios";

function Event() {
  const [userName, setUserName] = useState([]);
  const [userAdmin, setUserAdmin] = useState(0);
  const [selectedOption, setSelectedOption] = useState("");
  const [adminId,setAdminId]  = useState(-1);
  const [userId,setUserID] = useState(-1);
  const [eventID,setEventID] = useState(0);
  const [eventInfo,setEventInfo] = useState([]);
  const [formData, setFormData] = useState({
    event_name: '',
    start_date_time: '',
    end_date_time: '',
    capacity: '',
    description: '',
    location_ID: ''
  });

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData((prevFormData) => ({
      ...prevFormData,
      [name]: value
    }));
  };


  useEffect(() => {
    if (typeof window == "undefined" && !localStorage.getItem("username")) {
      Router.push("/login");
    } else {
      setUserName(localStorage.getItem("username"));
    }
    axios.get("http://localhost:8080/admincrud/checkAdminByName?username=" + localStorage.getItem("username"))
    .then(response => {
      if (response.data.length !== 0) {
        setUserAdmin(1);
        setAdminId(response.data[0].id);
        setUserID(response.data[0].id);
      } else {
        setUserAdmin(2);
      }
    })
    .catch(error => {
      console.log(error);
    });
  }, []);

  useEffect(() => {
    axios.get("http://localhost:8080/peoplecrud/listPeopleByName?name="+userName)
    .then(response => {
      setUserID(response.data[0].id);
      console.log(response.data[0].id)
    })
    .catch(error => {
      console.log(error);
    });
  },[userName])
  const handleOptionSelect = (option) => {
    setSelectedOption(option);
  }
  const handleSetUpSubmit = (event) => {
    event.preventDefault();
    axios.post("http://localhost:8080/eventcrud/insertEvent?eventName="+ 
                formData.event_name +
                "&startDateTime=" + formData.start_date_time.replace('T',' ') +
                "&endDateTime=" + formData.end_date_time.replace('T',' ')  +
                "&capacity=" + formData.capacity +
                "&description=" + formData.description +
                "&locationID=" + formData.location_ID +
                "&adminID=" + adminId)
      .then(response => {
        if (response.data == "0") {
          alert("fail to create the event");
        } else {
          alert("create the event successfully");
        }
      })
      .catch(error => {
        alert("fail to create the event");
      });
  }
  const handleEventInput = (event) => {
    setEventID(event.target.value);
  }
  const handleRegisterSubmit = (event) => {
    event.preventDefault();
    axios.post("http://localhost:8080/eventcrud/registerEvent?guestID="+userId+"&eventID="+eventID)
    .then(response => {
      if (response.data == "0") {
        alert("register fail");
      } else {
        alert("register successfully");
        axios.post("http://localhost:8080/eventcrud/findEvent?eventId="+eventID)
        .then(response => {
          setEventInfo([response.data.name, (response.data.startDateTime).replace('T',' '), (response.data.endDateTime).replace('T',' '),response.data.description]);
        })
      }
    })
    .catch(error => {
      alert("register fail");
    });
  }

  const handleCancelSubmit = (event) => {
    event.preventDefault();
    axios.post("http://localhost:8080/eventcrud/cancelRegisterEvent?guestID="+userId+"&eventID="+eventID)
    .then(response => {
      console.log(eventID);
      if (response.data == "0") {
        alert("cancel fail");
      } else {
        alert("cancel successfully");
      }
    })
    .catch(error => {
      alert("cancel fail");
    });
  }

  const renderContent = () => {
    switch (selectedOption) {
      case "set-up-event":
        return (
          <div className="setUpEvent">
          <form onSubmit={handleSetUpSubmit}>
            <div className="form-group">
              <label htmlFor="event_name" className="form-label">Event Name:</label>
              <input type="text" id="event_name" name="event_name" value={formData.event_name} onChange={handleInputChange} required />
            </div>
            <div className="form-group">
              <label htmlFor="start_date_time" className="form-label">Start Date/Time:</label>
              <input type="datetime-local" id="start_date_time" name="start_date_time" value={formData.start_date_time} onChange={handleInputChange} required />
            </div>
            <div className="form-group">
              <label htmlFor="end_date_time" className="form-label">End Date/Time:</label>
              <input className="form-input" type="datetime-local" id="end_date_time" name="end_date_time" value={formData.end_date_time} onChange={handleInputChange} required />
            </div>
            <div className="form-group">
              <label htmlFor="capacity" className="form-label">Capacity:</label>
              <input className="form-input" type="number" id="capacity" name="capacity" value={formData.capacity} onChange={handleInputChange} required />
            </div>
            <div className="form-group">
              <label htmlFor="description" className="form-label">Description:</label>
              <textarea className="form-input" id="description" name="description" value={formData.description} onChange={handleInputChange} maxLength={6000} required></textarea>
              <div className="description-char-limit">
                  {formData.description.length}/6000 characters
              </div>
            </div>
            <div className="form-group">
              <label htmlFor="location_ID" className="form-label">Location ID:</label>
              <input className="form-input" type="number" id="location_ID" name="location_ID" value={formData.location_ID} onChange={handleInputChange} required />
            </div>
            <button type="submit">Submit</button>
          </form>
          </div>
        );
      case "register-event":
        return (
          <div className="setUpEvent">
          <form onSubmit={handleRegisterSubmit}>
            <div className="form-group">
              <label htmlFor="event_id" className="form-label">Event ID:</label>
              <input type="text" id="event_id" name="event_id" value={eventID} onChange={handleEventInput} required />
            </div> 
            <button type="submit">Submit</button>
          </form>
          <div className="eventInfo">
            <div> {eventInfo[0]} </div>
            <div> {eventInfo[1]}</div>
            <div>{eventInfo[2]}</div>
            <div>{eventInfo[3]}</div>
          </div>
          </div>
        );
      case "cancel-event":
        return (
          <div className="setUpEvent">
          <form onSubmit={handleCancelSubmit}>
            <div className="form-group">
              <label htmlFor="event_id" className="form-label">Event ID:</label>
              <input type="text" id="event_id" name="event_id" value={eventID} onChange={handleEventInput} required />
            </div> 
            <button type="submit">Submit</button>
          </form>
          </div>
        );
      default:
        return null;
    }
  };
  

  return (
    <div className="main-page">
      <div className="left-side">
        {/* Left side menu */}
        <Link href="/mainPage">
          Search Books
        </Link>
        <Link href="/event">
          Event
        </Link>
        {(userAdmin == 1) && (<Link href="/bookreturn">
          Return Books
        </Link>)}
        <Link href="/contact">
          Contact
        </Link>
        <Link href="/login">
          Log out
        </Link>
      </div>
      <div className="right-side">
        <div className="top-part">
          {/* User name */}
          <div className="user-name" onClick={() => Router.push("/information")}>
            {userName}
          </div>
        </div>
        <div className="bottom-part">
          <div className="event-box">
            <div className="event-box-options">
            {userAdmin === 1 && <div className={`event-box-option ${selectedOption === "set-up-event" ? "selected" : ""}`} onClick={() => handleOptionSelect("set-up-event")}>Set up event</div>}
            {userAdmin != 1 && <div className={`event-box-option ${selectedOption === "register-event" ? "selected" : ""}`} onClick={() => handleOptionSelect("register-event")}>Register event</div>}
             {userAdmin != 1 &&  <div className={`event-box-option ${selectedOption === "cancel-event" ? "selected" : ""}`} onClick={() => handleOptionSelect("cancel-event")}>Cancel event</div>}
            </div>
            <div className="event-box-content">
              {renderContent()}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Event;
