package com.example.elibrarybackend.entity;

import lombok.Data;

@Data
public class Copy {
    String ISBN;
    long copyID;
    Boolean availability;
    long bookshelfID;
}
