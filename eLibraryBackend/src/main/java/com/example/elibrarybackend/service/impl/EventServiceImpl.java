package com.example.elibrarybackend.service.impl;

import com.example.elibrarybackend.entity.Event;
import com.example.elibrarybackend.entity.Location;
import com.example.elibrarybackend.mapper.AdminMapper;
import com.example.elibrarybackend.mapper.EventMapper;
import com.example.elibrarybackend.mapper.LocationMapper;
import com.example.elibrarybackend.service.EventService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EventServiceImpl implements EventService {
    @Resource
    private EventMapper eventMapper;

    @Resource
    private AdminMapper adminMapper;

    @Resource
    private LocationMapper locationMapper;
    public Event findEvent(long eventId) {
        return eventMapper.findEvent(eventId);
    }

    public List<Event> listEvents() {
        return eventMapper.listEvents();
    }

    public Boolean insertEvent(Event event) {
        String eventName = event.getName();
        String startDateTime = event.getStartDateTime();
        String endDateTime = event.getEndDateTime();
        int capacity = event.getCapacity();
        String description = event.getDescription();
        long locationID = event.getLocationID();
        long adminID = event.getAdminID();

        Boolean canHoldEvent = adminMapper.canHoldEvent(adminID,locationID);
        if (canHoldEvent == false) return false;
        Boolean validTime = locationTimeCheck(startDateTime, endDateTime, locationID);
        if (validTime == false) return false;
        Boolean noOverlappingEvents = eventMapper.checkOverlappingEvents(startDateTime, endDateTime, locationID);
        if (noOverlappingEvents == false) return false;
        System.out.println("No overlapping");
        try {
            eventMapper.insertEvent(eventName, startDateTime, endDateTime, capacity, description, locationID, adminID);
            return true; // Insertion was successful
        } catch (Exception e) {
            System.out.println("insertion fail");
            e.printStackTrace();
            return false; // Insertion failed
        }
    }


    public Boolean registerEvent(long guestID, long eventID) {
        Map<String, Object> param = new HashMap<>();
        param.put("guest_ID", guestID);
        param.put("event_ID", eventID);
        param.put("if_registerd", false);
        List<Map<String, Object>> res = eventMapper.registerEvent(param);
        System.out.println(param.get("if_registerd"));
        return (Boolean)param.get("if_registerd");
    }

    public Boolean cancelRegisterEvent(long guestID, long eventID) {
        Map<String, Object> param = new HashMap<>();
        param.put("guest_ID", guestID);
        param.put("event_ID", eventID);
        param.put("if_registerd", false);
        List<Map<String, Object>> res = eventMapper.cancelRegisterEvent(param);
        return (Boolean) param.get("if_registerd");
    }

    private Boolean isTimeInRange(LocalTime time, LocalTime startTime, LocalTime endTime) {
        return time.isAfter(startTime) && time.isBefore(endTime);
    }

    private Boolean locationTimeCheck(String startDateTime, String endDateTime, long locationID){
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        LocalDateTime start= LocalDateTime.parse(startDateTime, formatter1);
        LocalDateTime end= LocalDateTime.parse(endDateTime, formatter1);
        Location targetLocation = locationMapper.getLocationByID(locationID);
        DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("HH:mm:ss");
        LocalTime open_time= LocalTime.parse(targetLocation.getOpen_time(), formatter2);
        LocalTime close_time= LocalTime.parse(targetLocation.getClose_time(), formatter2);
        return now.isBefore(start) && now.isBefore(end)
                && start.isBefore(end)
                && isTimeInRange(start.toLocalTime(), open_time, close_time)
                && isTimeInRange(end.toLocalTime(), open_time, close_time);
    }
}
