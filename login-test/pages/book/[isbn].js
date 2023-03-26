import React, { useState, useEffect } from "react";
import axios from "axios";
import Link from "next/link";
import { useRouter } from "next/router";
import Router from 'next/router';
import styles from "../../styles/bookInfoPage.module.css";

function BookPage() {
  const router = useRouter();
  const [userName, setUserName] = useState([]);
  const {isbn} = router.query;
  const [book, setBook] = useState([]);
  const [bookInfo,setBookInfo] = useState([]);

  // Fetch book details using the book ID
  // ...
  useEffect(() => {
    if (typeof window == "undefined" && !localStorage.getItem("username")) {
      Router.push("/login");
    } else {
      setUserName(localStorage.getItem("username"));
    }
    axios.get("http://localhost:8080/bookcrud/findBookByISBN?ISBN=" + isbn)
    .then(response => {
      setBook(response.data);
    })
    .catch(error => {
      console.log(error);
    });

    axios.get("http://localhost:8080/bookcrud/findBookInfo?ISBN=" + isbn)
    .then(response => {
      setBookInfo(response.data);
    })
    .catch(error => {
      console.log(error);
    });
  }, [router.query]);

  return (
    <div className={styles.bookPageContainer}>
      <h1 className={styles.title}>{book.title}</h1>

      {/* Book information section */}
      <div className={styles.bookInfoContainer}>
        <div className={styles.bookInfoItem}>
          <span className={styles.bookInfoLabel}>ISBN: </span>
          <span className={styles.bookInfoValue}>{book.isbn}</span>
        </div>
        <div className={styles.bookInfoItem}>
          <span className={styles.bookInfoLabel}>Authors: </span>
          <span className={styles.bookInfoValue}>{bookInfo.authors}</span>
        </div>
        <div className={styles.bookInfoItem}>
          <span className={styles.bookInfoLabel}>Tags: </span>
          <span className={styles.bookInfoValue}>{bookInfo.tags}</span>
        </div>
        <div className={styles.bookInfoItem}>
          <span className={styles.bookInfoLabel}>Publication Year: </span>
          <span className={styles.bookInfoValue}>{bookInfo.publication_year}</span>
        </div>
        <div className={styles.bookInfoItem}>
          <span className={styles.bookInfoLabel}>Available Copy: </span>
          <span className={styles.bookInfoValue}>{bookInfo.copy}</span>
        </div>
      </div>

      <div className={styles.goBackButton} onClick={() => Router.push("/mainPage")}>
        Go back to Main page
      </div>
    </div>
  );
}

export default BookPage;
