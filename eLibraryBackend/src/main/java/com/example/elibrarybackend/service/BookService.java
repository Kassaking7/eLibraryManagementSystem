package com.example.elibrarybackend.service;

import com.example.elibrarybackend.entity.Books.Book;
import com.example.elibrarybackend.entity.Books.BookISBNTagPair;
import com.example.elibrarybackend.entity.Books.BookInfo;
import com.example.elibrarybackend.entity.Books.BorrowRes;

import java.util.List;

public interface BookService {
    public Book findByISBN(String ISBN);

    public BookInfo findBookInfo(String ISBN);

    public BorrowRes borrowBook(int user_id, String ISBN);
    public String returnBook(int user_id, String ISBN, int book_id);

    public List<BookISBNTagPair> ListISBNTag();

    public List<Book> ListBook();

    public Boolean insertBook(String ISBN, String title, int pages, String publisher_ID, String publication_year);

}
