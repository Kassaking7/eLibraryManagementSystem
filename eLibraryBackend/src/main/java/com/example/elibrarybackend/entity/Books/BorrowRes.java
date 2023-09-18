package com.example.elibrarybackend.entity.Books;

import lombok.Data;

@Data
public class BorrowRes {
    Boolean enough_credit;
    Boolean copy_available;

    public BorrowRes(Boolean res1, Boolean res2) {
        enough_credit = res1;
        copy_available = res2;
    }
}
