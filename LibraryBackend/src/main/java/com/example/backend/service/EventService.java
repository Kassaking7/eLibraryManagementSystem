package com.example.backend.service;

import com.example.backend.entity.Event;

import java.time.LocalDateTime;
import java.util.List;

public interface EventService {
    public Event findEvent(long eventId);

    public List<Event> listEvents();

    public String insertEvent(String eventName, String startDateTime, String endDateTime,
                             int capacity, String description, int locationID, int adminID);

    public String registerEvent(long guestID, long eventID);

    public String cancelRegisterEvent(long guestID, long eventID);
}
