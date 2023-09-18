package com.example.elibrarybackend.mapper;

import com.example.elibrarybackend.entity.Books.Book;
import com.example.elibrarybackend.entity.Books.BookISBNTagPair;
import com.example.elibrarybackend.entity.Books.BookInfo;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.StatementType;

import java.util.List;
import java.util.Map;

@Mapper
public interface BookMapper {
    @Select("SELECT * FROM Book where ISBN = #{ISBN}")
    Book findBookByISBN(String ISBN);

    @Select("SELECT * FROM Book")
    public List<Book> ListBook();

    @Select("call show_detailed_book_info(#{ISBN})")
    public BookInfo findBookInfo(String ISBN);

    @Select("SELECT B.ISBN AS ISBN, B.title AS title,MIN(tag_name) AS tags\n" +
            "        FROM Book AS B\n" +
            "        INNER JOIN Has_tag AS H ON B.ISBN = H.ISBN\n" +
            "        GROUP BY B.ISBN")
    public List<BookISBNTagPair> ListISBNTag();

    @Insert("INSERT INTO Book(\n" +
            "           ISBN, title, pages, descrpition, publisher_ID, publication_year\n" +
            "        )\n" +
            "        VALUES(\n" +
            "        #{ISBN}, #{title},#{pages},#{descrpition},#{publisher_ID},#{publication_year}\n" +
            "        )")
    public boolean InsertBook(String ISBN, String title, int pages, String publisher_ID, String publication_year);

    @Select("call book_return(" +
            "#{user_id, mode=IN, jdbcType=BIGINT}," +
            "#{ISBN, mode=IN, jdbcType=VARCHAR}," +
            "#{book_id, mode=IN, jdbcType=BIGINT})")
    @Options(statementType = StatementType.CALLABLE)
    public List<Map<String, Object>> returnBook(Map<String, Object> param);

    @Select("call borrow_via_guest(" +
            "#{user_id, mode=IN, jdbcType=BIGINT}," +
            "#{ISBN, mode=IN, jdbcType=VARCHAR}," +
            "#{enough_credit, mode=OUT, jdbcType=BOOLEAN}," +
            "#{copy_available, mode=OUT, jdbcType=BOOLEAN})")
    @ResultType(java.util.Map.class)
    @Options(statementType = StatementType.CALLABLE)
    public void borrowBook(Map<String, Object> param);
}
