package com.example.backend.service.impl;

import com.example.backend.entity.Guest;
import com.example.backend.mapper.GuestMapper;
import com.example.backend.service.GuestService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GuestServiceImpl implements GuestService {

    private GuestMapper guestMapper;

    public Guest findById(long id) {
        return guestMapper.findById(id);
    }

    public List<Guest> listGuests() {
        return guestMapper.listGuests();
    }

    public Boolean activateGuest(long id) {
        Map<String, Object> param = new HashMap<>();
        param.put("guest_ID", id);
        guestMapper.activateGuest(param);
        return true;
    }
}
