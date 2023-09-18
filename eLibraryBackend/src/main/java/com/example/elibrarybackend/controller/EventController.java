package com.example.elibrarybackend.controller;


import com.example.elibrarybackend.entity.Event;
import com.example.elibrarybackend.entity.RestBean;
import com.example.elibrarybackend.service.EventService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/events")
public class EventController {

    @Resource
    EventService service;
    @PostMapping("/{eventId}")
    public Event findEvent(@PathVariable("eventId") long eventId){
        return service.findEvent(eventId);
    }

    @GetMapping("/")
    public List<Event> listEvents(){
        return service.listEvents();
    }

    @PostMapping("/")
    public RestBean<Boolean> insertEvent(@RequestBody Event event) {
        Boolean res = service.insertEvent(event);
        return RestBean.success(res);
    }

    @PostMapping("/{eventId}/register")
    public RestBean<Boolean> registerEvent(@PathVariable("eventId") long eventID,
                                @RequestParam("guestID") long guestID) {
        Boolean res = service.registerEvent(guestID, eventID);
        return RestBean.success(res);
    }

    @PostMapping("/{eventId}/cancel")
    public RestBean<Boolean> cancelRegisterEvent(@PathVariable("eventId") long eventID,
                                      @RequestParam("guestID") long guestID) {
        Boolean res =service.cancelRegisterEvent(guestID, eventID);
        return RestBean.success(res);
    }
}
