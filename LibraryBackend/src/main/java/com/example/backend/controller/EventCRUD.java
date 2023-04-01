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

    @PostMapping("/findEvent")
    public Event findEvent(@RequestParam("eventId") long eventId){
        return eventService.findEvent(eventId);
    }

    @GetMapping("/listEvents")
    public List<Event> listEvents(){
        return eventService.listEvents();
    }

    @PostMapping("/insertEvent")
    public String insertEvent(@RequestParam("eventName") String eventName,
                               @RequestParam("startDateTime") String startDateTime,
                               @RequestParam("endDateTime") String endDateTime,
                               @RequestParam("capacity") int capacity,
                               @RequestParam("description") String description,
                               @RequestParam("locationID") int locationID,
                               @RequestParam("adminID") int adminID) {
        return eventService.insertEvent(eventName, startDateTime, endDateTime, capacity, description, locationID, adminID);
    }

    @PostMapping("/registerEvent")
    public String registerEvent(@RequestParam("guestID") long guestID,
                                @RequestParam("eventID") long eventID) {
        return eventService.registerEvent(guestID, eventID);
    }

    @PostMapping("/cancelRegisterEvent")
    public String cancelRegisterEvent(@RequestParam("guestID") long guestID,
                                       @RequestParam("eventID") long eventID) {
        return eventService.cancelRegisterEvent(guestID, eventID);
    }
}
