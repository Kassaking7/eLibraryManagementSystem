package com.example.backend.service;

import com.example.backend.entity.Guest;
import com.example.backend.entity.People;

import java.util.List;

public interface GuestService {

    public Guest findById(long id);

    public List<Guest> listGuests();

    public Boolean activateGuest(long id);
}
