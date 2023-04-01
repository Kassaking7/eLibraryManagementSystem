package com.example.backend.service.impl;

import com.example.backend.entity.Book;
import com.example.backend.entity.BookISBNTagPair;
import com.example.backend.entity.BookInfo;
import com.example.backend.entity.BorrowRes;
import com.example.backend.mapper.BookMapper;
import com.example.backend.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    private BookMapper BookMapper;

    public Book findByISBN(String ISBN){
        return BookMapper.findBookByISBN(ISBN);
    }
    public BookInfo findBookInfo(String ISBN) {
        return BookMapper.findBookInfo(ISBN);
    }

    public BorrowRes borrowBook(int user_id, String ISBN) {
        Map<String, Object> param = new HashMap<>();
        param.put("user_id", user_id);
        param.put("ISBN", ISBN);
        param.put("enough_credit", false);
        param.put("copy_available", false);
        int res = BookMapper.borrowBook(param);
        Boolean res2 = (Boolean)(param.get("copy_available"));
        Boolean res1 =  (Boolean)(param.get("enough_credit"));
        return new BorrowRes(res1,res2);
    }

    public String returnBook(int user_id, String ISBN, int book_id) {
        Map<String, Object> param = new HashMap<>();
        param.put("user_id", user_id);
        param.put("ISBN", ISBN);
        param.put("book_id", book_id);
        List<Map<String, Object>> tmp = BookMapper.returnBook(param);
        return (String) param.get("ISBN");
    }

    public List<Book> ListBook(){
        return BookMapper.ListBook();
    }

    public List<BookISBNTagPair> ListISBNTag() {return BookMapper.ListISBNTag();}
    public Book insertBook(String ISBN, String title, int pages, String publisher_ID, String publication_year) {
        Book Book = new Book(ISBN, title, pages, publisher_ID, publication_year);
        BookMapper.insertBook(Book);
        return Book;
    }

    public int Delete(String ISBN) {
        return BookMapper.delete(ISBN);
    }

    public int Update(String ISBN, String title, int pages, String publisher_ID, String publication_year){
        Book Book = BookMapper.findBookByISBN(ISBN);
        Book.setTitle(title);
        Book.setPages(pages);
        Book.setPublisher_ID(publisher_ID);
        Book.setPublication_year(publication_year);
        return BookMapper.Update(Book);
    }

}
