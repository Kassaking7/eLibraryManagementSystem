import React, { useState, useEffect } from "react";
import Link from 'next/link';
import Router from 'next/router';
import axios from "axios";


function MainPage() {
  const [userName, setUserName] = useState([]);
  const [books, setBooks] = useState([]);
  const [filterText, setFilterText] = useState("");
  const [startIndex, setStartIndex] = useState(0);
  const [selectedTag, setSelectedTag] = useState([]);
  const [Tag, setTag] = useState([]);
  const booksPerPage = 5;

  function filterBooks(books) {
    return books.filter(book => {
      return book.title.toLowerCase().includes(filterText.toLowerCase())
        && (selectedTag.length === 0 || selectedTag.some(tag => book.tags.includes(tag)));
    });
  }

  function handleTagSelection(tagName) {
    if (selectedTag.includes(tagName)) {
      setSelectedTag(selectedTag.filter(tag => tag !== tagName));
    } else {
      setSelectedTag([...selectedTag, tagName]);
    }
  }
  useEffect(() => {
    if (typeof window == "undefined" && !localStorage.getItem("username")) {
      Router.push("/login");
    } else {
      setUserName(localStorage.getItem("username"));
    }
    axios.get("http://localhost:8080/bookcrud/listBookISBNTag")
    .then(response => {
      setBooks(response.data);
    })
    .catch(error => {
      console.log(error);
    });
  }, []);
  function handleReset() {
    setSelectedTag([]);
  }
  useEffect(() => {
    axios.get("http://localhost:8080/tagcrud/listTag")
    .then(response => {
      setTag(response.data);
    })
    .catch(error => {
      console.log(error);
    });
  },[])
  useEffect(() => {
    setStartIndex(0);
  }, [filterText]);
  const filteredBooks = filterBooks(books);
  const totalPages = Math.ceil(filteredBooks.length / booksPerPage);
  const currentPage = Math.floor(startIndex / booksPerPage);

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
          {/* Filter */}
          <div className="filter-tags">
          {Tag.map(tag => (
            <button key={tag.name} className={selectedTag.includes(tag.name) ? "active" : ""} onClick={() => handleTagSelection(tag.name)}>
            <input type="checkbox" id={tag.name} value={tag.name} checked={selectedTag.includes(tag.name)} onChange={() => {}} />
            <label htmlFor={tag.name}>{tag.name}</label>
            </button>
          ))}
        </div>
        <div>
        <button className="ResetButton" onClick={handleReset}>Reset</button>
        </div>
      <div className="filterWidth">
          <div className="filerBooks">
            <input type="text" placeholder="Search Books" value={filterText} onChange={e => setFilterText(e.target.value)} />
              </div>
            {/* List of books */}
              <div className="books" style={{ height: "150px", overflowY: "scroll" }}>
              {filteredBooks.slice(startIndex, startIndex + booksPerPage).map(book => (
                <Link href={{ pathname: `/book/${book.isbn}`, query: { isbn: book.isbn} }}>
                <div className="book-info" key={book.id}>
                <div>
                  {book.title}
                </div>

                <div>ISBN: {book.isbn}</div>
                </div>
                </Link>
                ))}
              </div>
          {/* Buttons to show different 5 books */}
              <div className="nexpreButtons">
              <button disabled={currentPage === 0} onClick={() => { setStartIndex(startIndex - booksPerPage) }}>Previous</button>
              <button disabled={currentPage === totalPages - 1} onClick={() => { setStartIndex(startIndex + booksPerPage) }}>Next</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}


export default MainPage;
