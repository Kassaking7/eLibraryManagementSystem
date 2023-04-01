package com.example.backend.service;

import com.example.backend.entity.Book;
import com.example.backend.entity.BookISBNTagPair;
import com.example.backend.entity.BookInfo;
import com.example.backend.entity.BorrowRes;

import java.util.List;

public interface BookService {
    public Book findByISBN(String ISBN);

    public BookInfo findBookInfo(String ISBN);

    public BorrowRes borrowBook(int user_id, String ISBN);
    public String returnBook(int user_id, String ISBN, int book_id);

    public List<BookISBNTagPair> ListISBNTag();

    public List<Book> ListBook();

    public Book insertBook(String ISBN, String title, int pages, String publisher_ID, String publication_year);

    public int Delete(String ISBN);

    public int Update(String ISBN, String title, int pages,String publisher_ID, String publication_year);
}