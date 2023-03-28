package com.example.backend.controller;

import com.example.backend.entity.Book;
import com.example.backend.entity.BookISBNTagPair;
import com.example.backend.entity.BookInfo;
import com.example.backend.entity.BorrowRes;
import com.example.backend.service.impl.BookServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value="/bookcrud",method = {RequestMethod.GET,RequestMethod.POST})
public class BookCRUD {

    @Autowired
    private BookServiceImpl BookService;

    @GetMapping("/listBook")
    public List<Book> ListBook(){
        return BookService.ListBook();
    }

    @GetMapping("/listBookISBNTag")
    public List<BookISBNTagPair> ListISBNTag(){
        return BookService.ListISBNTag();
    }

    @GetMapping("/findBookByISBN")
    public Book findBookByISBN(@RequestParam("ISBN") String ISBN){
        return BookService.findByISBN(ISBN);
    }

    @GetMapping("/findBookInfo")
    public BookInfo findBookInfo(@RequestParam("ISBN") String ISBN){
        return BookService.findBookInfo(ISBN);
    }

    @GetMapping("/borrowBook")
    public BorrowRes borrowBook(@RequestParam("user_id") int user_id,
                                @RequestParam("ISBN") String ISBN){
        return BookService.borrowBook(user_id,ISBN);
    }

    @PostMapping(value="delete")
    public String delete(@RequestParam("ISBN") String ISBN){
        int result = BookService.Delete(ISBN);
        if (result >= 1){
            return "deleted";
        }else{
            return "failed to delete";
        }
    }

    @PostMapping(value = "insert")
    public Book insert(@RequestParam("ISBN") String ISBN,
                       @RequestParam("title") String title, 
                       @RequestParam("pages") int pages,
                       @RequestParam("publisher_ID") String publisher_ID, 
                       @RequestParam("publication_year") String publication_year) {
        return BookService.insertBook(ISBN, title, pages, publisher_ID, publication_year);
    }

    @PostMapping(value = "update")
    public String update(@RequestParam("ISBN") String ISBN,
                         @RequestParam("title") String title, 
                         @RequestParam("pages") int pages,
                         @RequestParam("publisher_ID") String publisher_ID, 
                         @RequestParam("publication_year") String publication_year) {
        int result = BookService.Update(ISBN, title, pages, publisher_ID, publication_year);
        if (result >= 1){
            return "modified";
        }else{
            return "failed to modify";
        }
    }
}

