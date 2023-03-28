package com.example.backend.entity;

public class BookISBNTagPair {

    private String ISBN;
    private String title;
    private String tags;

    public BookISBNTagPair(String ISBN, String title,String tags) {
        this.ISBN = ISBN;
        this.title = title;
        this.tags= tags;
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

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

}

