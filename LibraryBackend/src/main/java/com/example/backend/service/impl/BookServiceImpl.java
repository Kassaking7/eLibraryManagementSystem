package com.example.backend.service.impl;

import com.example.backend.entity.Book;
import com.example.backend.mapper.BookMapper;
import com.example.backend.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    private BookMapper BookMapper;

    public Book findByISBN(String ISBN){
        return BookMapper.findBookByISBN(ISBN);
    }

    public List<Book> ListBook(){
        return BookMapper.ListBook();
    }
    public Book insertBook(String ISBN, String title, int pages, String descrpition, String publisher_ID, String publication_year) {
        Book Book = new Book(ISBN, title, pages, descrpition, publisher_ID, publication_year);
        BookMapper.insertBook(Book);
        return Book;
    }

    public int Delete(String ISBN) {
        return BookMapper.delete(ISBN);
    }

    public int Update(String ISBN, String title, int pages, String descrpition, String publisher_ID, String publication_year){
        Book Book = BookMapper.findBookByISBN(ISBN);
        Book.setTitle(title);
        Book.setPages(pages);
        Book.setDescrpition(descrpition);
        Book.setPublisher_ID(publisher_ID);
        Book.setPublication_year(publication_year);
        return BookMapper.Update(Book);
    }
}
