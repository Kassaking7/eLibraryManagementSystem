package com.example.backend.mapper;

import com.example.backend.entity.BookInfo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.example.backend.entity.Book;

import java.util.List;

@Repository
@Mapper
public interface BookMapper {
    Book findBookByISBN(String ISBN);
    public BookInfo findBookInfo(String ISBN);
    public List<Book> ListBook();

    public int insertBook(Book Book);

    public int delete(String ISBN);

    public int Update(Book Book);
}
