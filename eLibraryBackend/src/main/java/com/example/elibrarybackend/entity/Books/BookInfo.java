package com.example.elibrarybackend.entity.Books;

import lombok.Data;

@Data
public class BookInfo {
    String title;
    String authors;
    String publisher;
    String publicationYear;
    String tags;
    String availableCopies;
}
