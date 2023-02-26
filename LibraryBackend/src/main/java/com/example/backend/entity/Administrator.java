package com.example.backend.entity;

public class Administrator {

    private long ID;
    private Boolean can_edit_book;
    private Boolean can_host_event;
    
    public Administrator(long ID,Boolean can_edit_book,Boolean can_host_event) {
        this.ID = ID;
        this.can_edit_book = can_edit_book;
        this.can_host_event = can_host_event;
    }

    public long getID() {
        return ID;
    }

    public void setID(long ID) {
        this.ID = ID;
    }

    public Boolean getCan_edit_book() {
        return can_edit_book;
    }

    public void setCan_edit_book(Boolean can_edit_book) {
        this.can_edit_book = can_edit_book;
    }

    public Boolean getCan_host_event() {
        return can_host_event;
    }

    public void setCan_host_event(Boolean can_host_event) {
        this.can_host_event = can_host_event;
    }
}
