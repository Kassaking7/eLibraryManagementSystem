package com.example.elibrarybackend.entity.Books;

import lombok.Data;

@Data
public class ReturnReq {
    int userId;
    String ISBN;
    int bookId;
    ReturnReq(int userId, String ISBN, int bookId) { // weird problem with Lombok
        this.userId = userId;
        this.ISBN = ISBN;
        this.bookId = bookId;
    }
}
