package com.example.elibrarybackend.entity;

import lombok.Data;

@Data
public class Admin {
    long ID;
    Boolean can_edit_book;
    Boolean can_host_event;
}
