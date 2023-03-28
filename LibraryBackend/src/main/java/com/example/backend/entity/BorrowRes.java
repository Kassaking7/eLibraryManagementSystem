package com.example.backend.entity;

public class BorrowRes {

    private Boolean enough_credit;
    private Boolean copy_available;

    public BorrowRes(Boolean enough_credit, Boolean copy_available) {
        this.enough_credit = enough_credit;
        this.copy_available = copy_available;
    }

    public Boolean getEnough_credit() {
        return enough_credit;
    }

    public void setEnough_credit(Boolean enough_credit) {
        this.enough_credit = enough_credit;
    }

    public Boolean getCopy_available() {
        return copy_available;
    }

    public void setCopy_available(Boolean copy_available) {
        this.copy_available=copy_available;
    }

}

