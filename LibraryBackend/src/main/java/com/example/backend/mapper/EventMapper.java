package com.example.backend.mapper;

import com.example.backend.entity.Event;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface EventMapper {

    public Event findEvent(long eventId);

    public List<Event> listEvents();

    public List<Map<String, Object>> insertEvent(Map<String, Object> param);

    public List<Map<String, Object>> registerEvent(Map<String, Object> param);

    public List<Map<String, Object>> cancelRegisterEvent(Map<String, Object> param);
}
