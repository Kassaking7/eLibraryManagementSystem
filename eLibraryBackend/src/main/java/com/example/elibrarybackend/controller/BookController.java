package com.example.elibrarybackend.controller;

import com.example.elibrarybackend.entity.Books.*;
import com.example.elibrarybackend.entity.RestBean;
import com.example.elibrarybackend.service.BookService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/book")
public class BookController {
    @Resource
    BookService BookService;

    @GetMapping("/")
    public List<Book> ListBook(){
        return BookService.ListBook();
    }

    @GetMapping("/ISBNTag")
    public List<BookISBNTagPair> ListISBNTag(){
        return BookService.ListISBNTag();
    }

    @GetMapping("/{ISBN}")
    public Book findBookByISBN(@PathVariable("ISBN") String ISBN){
        return BookService.findByISBN(ISBN);
    }

    @GetMapping("/detail/{ISBN}")
    public BookInfo findBookInfo(@PathVariable("ISBN") String ISBN){
        return BookService.findBookInfo(ISBN);
    }

    @PostMapping("/borrow")
    public RestBean<BorrowRes> borrowBook(@RequestParam("user_id") int user_id,
                                         @RequestParam("ISBN") String ISBN){

        BorrowRes res = BookService.borrowBook(user_id,ISBN);
        return RestBean.success(res);
    }
    @PostMapping("/return")
    public String returnBook(@RequestBody ReturnReq request){
        int user_id = request.getUserId();
        String ISBN = request.getISBN();
        int book_id = request.getBookId();
        return BookService.returnBook(user_id,ISBN,book_id);
    }


    @PostMapping(value = "insert")
    public Boolean insert(@RequestParam("ISBN") String ISBN,
                       @RequestParam("title") String title,
                       @RequestParam("pages") int pages,
                       @RequestParam("publisher_ID") String publisher_ID,
                       @RequestParam("publication_year") String publication_year) {
        return BookService.insertBook(ISBN, title, pages, publisher_ID, publication_year);
    }
}
