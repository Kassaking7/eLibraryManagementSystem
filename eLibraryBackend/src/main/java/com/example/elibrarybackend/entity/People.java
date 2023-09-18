package com.example.elibrarybackend.entity;

import lombok.Data;
import org.springframework.data.relational.core.mapping.Column;

@Data
public class People {
    private long ID;
    private String username;
    private String password;
    private String email_address;
    private Boolean is_guest;
}
