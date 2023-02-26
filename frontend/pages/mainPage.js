import React, { useState, useEffect } from "react";
import Link from 'next/link';
import Router from 'next/router';

function MainPage() {
  const [userName, setUserName] = useState(localStorage.getItem("username"));
  const [books, setBooks] = useState([]);


  return (
    <div className="main-page">
      <div className="left-side">
        {/* Left side menu */}
        {/* ... */}
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
              {book.name}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

export default MainPage;
