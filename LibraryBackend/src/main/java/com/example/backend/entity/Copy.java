package com.example.backend.entity;

public class Copy {
    private String ISBN;
    private long copyID;

    private Boolean availability;

    private long bookshelfID;

    public Copy(String ISBN, long copyID, Boolean availability, long bookshelfID) {
        this.ISBN = ISBN;
        this.copyID = copyID;
        this.availability = availability;
        this.bookshelfID = bookshelfID;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public long getCopyID() {
        return copyID;
    }

    public void setCopyID(long copyID) {
        this.copyID = copyID;
    }

    public Boolean getAvailability() {
        return availability;
    }

    public void setAvailability(Boolean availability) {
        this.availability = availability;
    }

    public long getBookshelfID() {
        return bookshelfID;
    }

    public void setBookshelfID(long bookshelfID) {
        this.bookshelfID = bookshelfID;
    }
}
