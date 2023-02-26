package com.example.backend.entity;

public class People {

    private long ID;
    private String username;
    private String password;
    private String email_address;
    private Boolean is_guest;

    public People(long ID,String username, String password, String email_address,Boolean is_guest) {
        this.ID = ID;
        this.username = username;
        this.password = password;
        this.is_guest = is_guest;
        this.email_address = email_address;
    }

    public String getEmail_address() {
        return email_address;
    }

    public void setEmail_address(String email_address) {
        this.email_address = email_address;
    }
    public long getID() {
        return ID;
    }

    public void setID(long ID) {
        this.ID = ID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getIs_guest() {
        return is_guest;
    }

    public void setIs_guest(Boolean is_guest) {
        this.is_guest = is_guest;
    }
}
