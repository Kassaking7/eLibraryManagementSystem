package com.example.backend.mapper;

import com.example.backend.entity.Guest;

import java.util.List;
import java.util.Map;

public interface GuestMapper {

    public Guest findById(long id);

    public List<Guest> listGuests();

    public void activateGuest(Map<String, Object> param);
}
