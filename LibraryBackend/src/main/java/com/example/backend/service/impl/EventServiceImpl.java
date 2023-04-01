package com.example.backend.service.impl;

import com.example.backend.entity.Event;
import com.example.backend.mapper.EventMapper;
import com.example.backend.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EventServiceImpl implements EventService {
    @Autowired
    private EventMapper eventMapper;
    public Event findEvent(long eventId) {
        return eventMapper.findEvent(eventId);
    }

    public List<Event> listEvents() {
        return eventMapper.listEvents();
    }

    public String insertEvent(String eventName, String startDateTime, String endDateTime,
                               int capacity, String description, int locationID, int adminID) {
        Map<String, Object> param = new HashMap<>();
        param.put("event_name", eventName);
        param.put("start_date_time", startDateTime);
        param.put("end_date_time", endDateTime);
        param.put("capacity", capacity);
        param.put("description", description);
        param.put("location_ID", locationID);
        param.put("admin_ID", adminID);
        param.put("if_succeeded", false);
        List<Map<String, Object>> res = eventMapper.insertEvent(param);
        return (String) param.get("if_succeeded");
    }


    public String registerEvent(long guestID, long eventID) {
        Map<String, Object> param = new HashMap<>();
        param.put("guest_ID", guestID);
        param.put("event_ID", eventID);
        param.put("if_registerd", false);
        List<Map<String, Object>> res = eventMapper.registerEvent(param);
        return (String) param.get("if_registerd");
    }

    public String cancelRegisterEvent(long guestID, long eventID) {
        Map<String, Object> param = new HashMap<>();
        param.put("guest_ID", guestID);
        param.put("event_ID", eventID);
        param.put("if_registerd", false);
        List<Map<String, Object>> res = eventMapper.cancelRegisterEvent(param);
        return (String) param.get("if_registerd");
    }
}
