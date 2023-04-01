package com.example.backend.mapper;

import com.example.backend.entity.BookISBNTagPair;
import com.example.backend.entity.BookInfo;
import com.example.backend.entity.BorrowRes;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.example.backend.entity.Book;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface BookMapper {
    Book findBookByISBN(String ISBN);
    public BookInfo findBookInfo(String ISBN);
    public int borrowBook(Map<String, Object> param);

    public List<Map<String, Object>> returnBook(Map<String, Object> param);
    public List<Book> ListBook();
    public List<BookISBNTagPair> ListISBNTag();
    public int insertBook(Book Book);
    public int delete(String ISBN);
    public int Update(Book Book);
}
