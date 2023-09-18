import React, { useState, useEffect } from "react";
import axios from "axios";
import Link from "next/link";
import { useRouter } from "next/router";
import Router from 'next/router';
import styles from "../../styles/bookInfoPage.module.css";
import { setTokenSourceMapRange } from "typescript";
import { userInfo } from "os";

function BookPage() {
  const router = useRouter();
  const [userName, setUserName] = useState("");
  const [id,setId] = useState("");
  const {isbn} = router.query;
  const [book, setBook] = useState([]);
  const [bookInfo,setBookInfo] = useState([]);
  const [borrowRes,setBorrowRes] = useState();
  const [enCre,setEnCre] = useState();
  const [copy,setCopy] = useState();
  useEffect(() => {
    if (typeof window == "undefined" && !localStorage.getItem("username")) {
      Router.push("/login");
    } else {
      setUserName(localStorage.getItem("username"));
    }
  });
  useEffect(() => { 
    console.log(userName)
    axios.get("http://127.0.0.1:8080/api/user/info/" + userName,{},{withCredentials: true})
    .then(response => {
      console.log(response.data)
      setId(response.data.id);
    })
    .catch(error => {
      console.log(error);
    });

    axios.get("http://127.0.0.1:8080/api/book/" + isbn,{},{withCredentials: true})
    .then(response => {
      setBook(response.data);
    })
    .catch(error => {
      console.log(error);
    });

    axios.get("http://127.0.0.1:8080/api/book/detail/" + isbn,{},{withCredentials: true})
    .then(response => {
      console.log(response.data)
      setBookInfo(response.data);
    })
    .catch(error => {
      console.log(error);
    });
  },[userName]);
  function handleBorrow() {
    axios.post("http://127.0.0.1:8080/api/book/borrow?user_id="+id+"&ISBN="+isbn,{},{withCredentials: true})
    .then(response => {
      console.log(response.data)
      setBorrowRes(response.data.message.enough_credit && response.data.message.copy_available);
      setEnCre(response.data.message.enough_credit);
      setCopy(response.data.message.copy_available);
    })
    .catch(error => {
      console.log("error happens at borrowing");
      console.log(error);
    });
  }
  useEffect(() => {
    if (borrowRes === undefined){
      return;
    } 
    if (borrowRes) {
      alert("Borrow Successful");
    } else {
      if (!copy && !enCre) {
        alert("Fail to Borrow: No more copy and no more credit");
      } else if (!copy) {
        alert("Fail to Borrow: No more copy");
      } else {
        alert("Fail to Borrow: No more credit");
      }
    }
    setBorrowRes(undefined);
  },[borrowRes]);
  useEffect(() => {
    console.log(borrowRes);
  },[borrowRes]);
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
          <span className={styles.bookInfoValue}>{bookInfo.publicationYear}</span>
        </div>
        <div className={styles.bookInfoItem}>
          <span className={styles.bookInfoLabel}>Available Copy: </span>
          <span className={styles.bookInfoValue}>{bookInfo.availableCopies <=copy ? bookInfo.availableCopies:copy
}</span>
        </div>
      </div>
      <div className={styles.borrowButton} onClick={() => handleBorrow()}>
        Borrow this book
      </div>
      <div className={styles.goBackButton} onClick={() => Router.push("/mainPage")}>
        Go back to Main page
      </div>
    </div>
  );
}

export default BookPage;
