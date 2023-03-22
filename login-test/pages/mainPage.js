import React, { useState, useEffect } from "react";
import Link from 'next/link';
import Router from 'next/router';
import axios from "axios";

function MainPage() {
  const [userName, setUserName] = useState([]);
  const [books, setBooks] = useState([]);

  useEffect(() => {
    if (typeof window == "undefined" && !localStorage.getItem("username")) {
      Router.push("/login");
    } else {
      setUserName(localStorage.getItem("username"));
    }
    axios.get("http://localhost:8080/bookcrud/listBook")
    .then(response => {
      setBooks(response.data);
    })
    .catch(error => {
      console.log(error);
    });
  }, []);
  return (
    <div className="main-page">
      <div className="left-side">
        {/* Left side menu */}
        {/* ... */}
        <Link href="/search-books">
          Search Books
        </Link>
        <Link href="/event">
          Event
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
          {/* List of books */}
          {books.map(book => (
            <div className="book-info">
              {book.title}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

export default MainPage;
