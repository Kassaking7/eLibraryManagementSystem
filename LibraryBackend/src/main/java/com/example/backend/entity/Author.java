package com.example.backend.entity;

public class Author {
    private long ID;
    private String name;
    private String nationality;
    private String birth_year;

    public Author(long ID, String name, String nationality, String birth_year) {
        this.ID = ID;
        this.name = name;
        this.nationality = nationality;
        this.birth_year = birth_year;
    }

    public long getID() {
        return ID;
    }

    public void setID(long ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getBirth_year() {
        return birth_year;
    }

    public void setBirth_year(String birth_year) {
        this.birth_year = birth_year;
    }
}
