package com.example.backend.controller;

import com.example.backend.entity.Event;
import com.example.backend.entity.People;
import com.example.backend.service.impl.EventServiceImpl;
import com.example.backend.service.impl.PeopleServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value="/eventcrud",method = {RequestMethod.GET,RequestMethod.POST})
public class EventCRUD {

    @Autowired
    private EventServiceImpl eventService;

    @GetMapping("/findEvent")
    public Event findEvent(@RequestParam("eventId") long eventId){
        return eventService.findEvent(eventId);
    }

    @GetMapping("/listEvents")
    public List<Event> listEvents(){
        return eventService.listEvents();
    }

    @PostMapping("/insertEvent")
    public Boolean insertEvent(@RequestParam("eventName") String eventName,
                               @RequestParam("startDateTime") LocalDateTime startDateTime,
                               @RequestParam("endDateTime") LocalDateTime endDateTime,
                               @RequestParam("capacity") int capacity,
                               @RequestParam("description") String description,
                               @RequestParam("lcoationID") long lcoationID,
                               @RequestParam("adminID") long adminID) {
        return insertEvent(eventName, startDateTime, endDateTime, capacity, description, lcoationID, adminID);
    }

    @PostMapping("/registerEvent")
    public Boolean registerEvent(@RequestParam("guestID") long guestID,
                                 @RequestParam("eventID") long eventID) {
        return registerEvent(guestID, eventID);
    }

    @PostMapping("/cancelRegisterEvent")
    public Boolean cancelRegisterEvent(@RequestParam("guestID") long guestID,
                                       @RequestParam("eventID") long eventID) {
        return cancelRegisterEvent(guestID, eventID);
    }
}
