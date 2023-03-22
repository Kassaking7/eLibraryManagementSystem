package com.example.backend.service.impl;

import com.example.backend.entity.Guest;
import com.example.backend.mapper.GuestMapper;
import com.example.backend.service.GuestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GuestServiceImpl implements GuestService {
    @Autowired
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
