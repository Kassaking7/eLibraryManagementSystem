package com.example.backend.entity;

public class BookInfo {

    private String title;
    private String authors;
    private String publisher;
    private String publication_year;
    private String tags;
    private String copy;
    public BookInfo(String title,String authors,String publisher, String publication_year, String tags, String copy) {
        this.title = title;
        this.authors = authors;
        this.publisher = publisher;
        this.publication_year = publication_year;
        this.tags = tags;
        this.copy = copy;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthors() {
        return authors;
    }

    public void setAuthors(String authors) {
        this.authors = authors;
    }
    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags= tags;
    }

    public String getPublication_year() {
        return publication_year;
    }

    public void setPublication_year(String publication_year) {
        this.publication_year = publication_year;
    }

    public String getCopy() {
        return copy;
    }

    public void setCopy(String copy) {
        this.copy= copy;
    }
}

