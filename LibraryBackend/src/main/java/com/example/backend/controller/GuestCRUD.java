package com.example.backend.controller;

import com.example.backend.entity.Guest;
import com.example.backend.service.impl.GuestServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value="/guestcrud",method = {RequestMethod.GET,RequestMethod.POST})
public class GuestCRUD {
    @Autowired
    private GuestServiceImpl guestService;

    @PostMapping("/findById")
    public Guest findById(@RequestParam("id")  long id) {
        return guestService.findById(id);
    }

    @GetMapping("/ListGuests")
    public List<Guest> listGuests() {
        return guestService.listGuests();
    }

    @PostMapping("/activateGuest")
    public Boolean activateGuest(@RequestParam("id") long id) {
        return guestService.activateGuest(id);
    }
}
