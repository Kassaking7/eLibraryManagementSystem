package com.example.elibrarybackend.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Event {
    long ID;
    String name;
    String startDateTime;
    String endDateTime;
    int capacity;
    int currentAmount;
    String description;
    long locationID;
    long adminID;
}
