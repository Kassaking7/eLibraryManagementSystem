package com.example.backend.service.impl;

import com.example.backend.entity.Event;
import com.example.backend.mapper.EventMapper;
import com.example.backend.service.EventService;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EventServiceImpl implements EventService {
    private EventMapper eventMapper;
    public Event findEvent(long eventId) {
        return eventMapper.findEvent(eventId);
    }

    public List<Event> listEvents() {
        return eventMapper.listEvents();
    }

    public Boolean insertEvent(String eventName, LocalDateTime startDateTime, LocalDateTime endDateTime,
                               int capacity, String description, long lcoationID, long adminID) {
        Map<String, Object> param = new HashMap<>();
        param.put("event_name", eventName);
        param.put("start_date_time", startDateTime);
        param.put("end_date_time", endDateTime);
        param.put("capacity", capacity);
        param.put("description", description);
        param.put("location_ID", lcoationID);
        param.put("admin_ID", adminID);
        param.put("if_succeeded", false);
        if (eventMapper.insertEvent(param)) {
            return (Boolean) param.get("if_succeeded");
        }
        return false;
    }

    public Boolean registerEvent(long guestID, long eventID) {
        Map<String, Object> param = new HashMap<>();
        param.put("guest_ID", guestID);
        param.put("event_ID", eventID);
        param.put("if_succeeded", false);
        if (eventMapper.registerEvent(param)) {
            return (Boolean) param.get("if_succeeded");
        }
        return false;
    }

    public Boolean cancelRegisterEvent(long guestID, long eventID) {
        Map<String, Object> param = new HashMap<>();
        param.put("guest_ID", guestID);
        param.put("event_ID", eventID);
        param.put("if_succeeded", false);
        if (eventMapper.cancelRegisterEvent(param)) {
            return (Boolean) param.get("if_succeeded");
        }
        return false;
    }
}
