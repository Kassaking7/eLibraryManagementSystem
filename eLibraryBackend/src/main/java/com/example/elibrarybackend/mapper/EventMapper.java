package com.example.elibrarybackend.mapper;


import com.example.elibrarybackend.entity.Event;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.mapping.StatementType;

import java.util.List;
import java.util.Map;

@Mapper
public interface EventMapper {
    @Select("SELECT * FROM Event WHERE Event.ID = #{eventId}")
    public Event findEvent(long eventId);

    @Select("SELECT * FROM Event")
    public List<Event> listEvents();


    @Select("call register_event(" +
            "#{guest_ID mode=IN jdbcType=BIGINT}," +
            "#{event_ID mode=IN jdbcType=BIGINT}," +
            "#{if_registerd mode=OUT jdbcType=VARCHAR})")
    @ResultType(java.util.Map.class)
    @Options(statementType = StatementType.CALLABLE)
    public List<Map<String, Object>> registerEvent(Map<String, Object> param);

    @Select("call cancel_register(" +
            "#{guest_ID mode=IN jdbcType=BIGINT}," +
            "#{event_ID mode=IN jdbcType=BIGINT}," +
            "#{if_registerd mode=OUT jdbcType=VARCHAR})")
    @ResultType(java.util.Map.class)
    @Options(statementType = StatementType.CALLABLE)
    public List<Map<String, Object>> cancelRegisterEvent(Map<String, Object> param);


    @Select("SELECT COUNT(*) = 0 FROM Event\n" +
            "WHERE Event.location_ID = #{locationID} AND \n" +
            "((#{start_time} BETWEEN Event.start_date_time AND Event.end_date_time) OR \n" +
            "(#{end_time} BETWEEN Event.start_date_time AND Event.end_date_time))")
    public Boolean checkOverlappingEvents(String start_time, String end_time,long locationID);


    @Select("INSERT INTO Event (name, start_date_time, end_date_time, capacity, current_amount, description, location_ID, admin_ID)\n" +
            "VALUES(" +
            "#{name}, " +
            "#{start_date_time}, " +
            "#{end_date_time}, " +
            "#{capacity}, " +
            "0, " +
            "#{description}, " +
            "#{location_ID}, " +
            "#{admin_ID})")
    public void insertEvent(String name,String start_date_time,String end_date_time, long capacity, String description, long location_ID, long admin_ID);
}
