package com.example.backend.service;

import com.example.backend.entity.Event;

import java.time.LocalDateTime;
import java.util.List;

public interface EventService {
    public Event findEvent(long eventId);

    public List<Event> listEvents();

    public Boolean insertEvent(String eventName, LocalDateTime startDateTime, LocalDateTime endDateTime,
                             int capacity, String description, long lcoationID, long adminID);

    public Boolean registerEvent(long guestID, long eventID);

    public Boolean cancelRegisterEvent(long guestID, long eventID);
}
