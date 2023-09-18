package com.example.elibrarybackend.service;

import com.example.elibrarybackend.entity.Event;

import java.util.List;

public interface EventService {
    public Event findEvent(long eventId);

    public List<Event> listEvents();

    public Boolean insertEvent(Event event);

    public Boolean registerEvent(long guestID, long eventID);

    public Boolean cancelRegisterEvent(long guestID, long eventID);
}
