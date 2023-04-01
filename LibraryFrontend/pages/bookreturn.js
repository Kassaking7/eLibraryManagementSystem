import React, { useState, useEffect } from "react";
import Link from 'next/link';
import Router from 'next/router';
import axios from "axios";


function bookreturn() {
  const [userName, setUserName] = useState([]);
  const [returnStatus, setReturnStatus] = useState("");

  useEffect(() => {
    if (typeof window == "undefined" && !localStorage.getItem("username")) {
      Router.push("/login");
    } else {
      setUserName(localStorage.getItem("username"));
    }
  }, []);
  function handleSubmit(event) {
    event.preventDefault();

    const formData = new FormData(event.target);
    const userId = formData.get("userId");
    const isbn = formData.get("isbn");
    const bookId = formData.get("bookId");

    axios.post("http://localhost:8080/copycrud/findCopyByISBNAndCopyId?ISBN="+isbn+"&copy_id="+bookId)
    .then(response => {
      if (response.data == "") {
        setReturnStatus("book information incorrect");
        return;
      }
      axios.post("http://localhost:8080/bookcrud/returnBook?user_id="+userId+ "&ISBN="+isbn+"&book_id="+bookId)
        .then(response => {
          setReturnStatus("book returns successfully");
        })
        .catch(error => {
          console.log(error);
          setReturnStatus("book return failed");
        });
    })
    .catch(error => {
      console.log(error);
      setReturnStatus("book return failed");
    });

  }
  return (
    <div className="main-page">
      <div className="left-side">
        {/* Left side menu */}
        {/* ... */}
        <Link href="/mainPage">
          Search Books
        </Link>
        <Link href="/event">
          Event
        </Link>
        <Link href="/bookreturn">
          Return Books
        </Link>
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
        <form onSubmit={handleSubmit}>
            <div>
              <label>User ID:</label>
              <input type="text" name="userId" required />
            </div>
            <div>
              <label>ISBN:</label>
              <input type="text" name="isbn" required />
            </div>
            <div>
              <label>Book ID:</label>
              <input type="text" name="bookId" required />
            </div>
            <button type="submit">Return the book</button>
          </form>
          <div>{returnStatus}</div>
        </div>
      </div>
    </div>
  );
}


export default bookreturn;
