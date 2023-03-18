package com.example.backend.entity;

public class Book {

    private String ISBN;
    private String title;
    private int pages;
    private String publisher_ID;
    private String publication_year;

    public Book(String ISBN, String title, int pages, String publisher_ID, String publication_year) {
        this.ISBN = ISBN;
        this.title = title;
        this.pages = pages;
        this.publisher_ID = publisher_ID;
        this.publication_year = publication_year;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public String getPublisher_ID() {
        return publisher_ID;
    }

    public void setPublisher_ID(String publisher_ID) {
        this.publisher_ID = publisher_ID;
    }

    public String getPublication_year() {
        return publication_year;
    }

    public void setPublication_year(String publication_year) {
        this.publication_year = publication_year;
    }
}

