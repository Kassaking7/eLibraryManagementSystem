package com.example.elibrarybackend.entity.Books;

import lombok.Data;

@Data
public class BookISBNTagPair {
    String ISBN;
    String title;
    String tags;
}
