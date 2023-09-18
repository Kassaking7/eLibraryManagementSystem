package com.example.elibrarybackend.entity.Books;

import lombok.Data;

@Data
public class Book {
    String ISBN;
    String title;
    int pages;
    String publisher_ID;
    String publication_year;
}
