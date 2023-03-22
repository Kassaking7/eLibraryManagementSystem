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

    public Boolean insertEvent(Map<String, Object> param);

    public Boolean registerEvent(Map<String, Object> param);

    public Boolean cancelRegisterEvent(Map<String, Object> param);
}
