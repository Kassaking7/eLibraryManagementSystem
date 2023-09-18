package com.example.elibrarybackend.entity.Books;

import lombok.Data;

@Data
public class BorrowReq {
    int UserId;
    String ISBN;
}
