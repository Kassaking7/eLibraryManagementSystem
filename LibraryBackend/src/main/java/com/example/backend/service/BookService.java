package com.example.backend.service;

import com.example.backend.entity.Book;

import java.util.List;

public interface BookService {
    public Book findByISBN(String ISBN);

    public List<Book> ListBook();

    public Book insertBook(String ISBN, String title, int pages, String publisher_ID, String publication_year);

    public int Delete(String ISBN);

    public int Update(String ISBN, String title, int pages, String publisher_ID, String publication_year);
}
