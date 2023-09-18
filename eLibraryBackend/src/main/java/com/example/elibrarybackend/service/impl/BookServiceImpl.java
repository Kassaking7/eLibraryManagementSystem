package com.example.elibrarybackend.service.impl;

import com.example.elibrarybackend.entity.Books.Book;
import com.example.elibrarybackend.entity.Books.BookISBNTagPair;
import com.example.elibrarybackend.entity.Books.BookInfo;
import com.example.elibrarybackend.entity.Books.BorrowRes;
import com.example.elibrarybackend.service.BookService;
import com.example.elibrarybackend.mapper.BookMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BookServiceImpl implements BookService {

    @Resource
    BookMapper mapper;

    public Book findByISBN(String ISBN) {
        return mapper.findBookByISBN(ISBN);
    }

    public BookInfo findBookInfo(String ISBN) {
        return mapper.findBookInfo(ISBN);
    }

    public BorrowRes borrowBook(int user_id, String ISBN) {
        System.out.println(user_id);
        System.out.println(ISBN);
        Map<String, Object> param = new HashMap<>();
        param.put("user_id", user_id);
        param.put("ISBN", ISBN);
        param.put("enough_credit", 0);
        param.put("copy_available", 0);
        mapper.borrowBook(param);
        Boolean res2 = (Boolean)(param.get("copy_available"));
        Boolean res1 =  (Boolean)(param.get("enough_credit"));
        return new BorrowRes(res1,res2);
    }
    public String returnBook(int user_id, String ISBN, int book_id) {
        Map<String, Object> param = new HashMap<>();
        param.put("user_id", user_id);
        param.put("ISBN", ISBN);
        param.put("book_id", book_id);
        List<Map<String, Object>> tmp = mapper.returnBook(param);
        return (String) param.get("ISBN");
    }

    public List<BookISBNTagPair> ListISBNTag() {
        return mapper.ListISBNTag();
    }

    public List<Book> ListBook() {
        return mapper.ListBook();
    }

    public Boolean insertBook(String ISBN, String title, int pages, String publisher_ID, String publication_year) {
        return mapper.InsertBook(ISBN,title,pages,publisher_ID,publication_year);
    }

}
