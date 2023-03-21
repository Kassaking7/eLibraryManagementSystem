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

    public Boolean insertEvent(String eventName, String startDateTime, String endDateTime,
                               int capacity, String description, long locationID, long adminID) {
        Map<String, Object> param = new HashMap<>();
        param.put("event_name", eventName);
        param.put("start_date_time", startDateTime);
        param.put("end_date_time", endDateTime);
        param.put("capacity", capacity);
        param.put("description", description);
        param.put("location_ID", locationID);
        param.put("admin_ID", adminID);
        param.put("if_succeeded", false);
        if (eventMapper.insertEvent(param)) {
            return (Boolean) param.get("if_succeeded");
        }
        return false;
    }

    /*
    org.springframework.beans.factory.UnsatisfiedDependencyException:
    Error creating bean with name 'adminCRUD': Unsatisfied dependency expressed through field 'AdministratorService';
    nested exception is org.springframework.beans.factory.UnsatisfiedDependencyException:
        Error creating bean with name 'administratorServiceImpl':
            Unsatisfied dependency expressed through field 'AdministratorMapper';
    nested exception is org.springframework.beans.factory.UnsatisfiedDependencyException:
        Error creating bean with name 'administratorMapper' defined in file
        [/Users/zihanpan/Downloads/CS348/eLibraryManagementSystem/LibraryBackend/target/classes/com/example/backend/mapper/AdministratorMapper.class]:
            Unsatisfied dependency expressed through bean property 'sqlSessionFactory'; nested exception is org.springframework.beans.factory.BeanCreationException:
                Error creating bean with name 'sqlSessionFactory' defined in class path resource [org/mybatis/spring/boot/autoconfigure/MybatisAutoConfiguration.class]:
                    Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException:
                        Failed to instantiate [org.apache.ibatis.session.SqlSessionFactory]:
                            Factory method 'sqlSessionFactory' threw exception;
    nested exception is org.springframework.core.NestedIOException:
        Failed to parse mapping resource: 'file [/Users/zihanpan/Downloads/CS348/eLibraryManagementSystem/LibraryBackend/target/classes/mapper/EventMapper.xml]';
    nested exception is org.apache.ibatis.builder.BuilderException:
        Error parsing Mapper XML. The XML location is 'file [/Users/zihanpan/Downloads/CS348/eLibraryManagementSystem/LibraryBackend/target/classes/mapper/EventMapper.xml]'.
        Cause: org.apache.ibatis.builder.BuilderException: Error resolving JdbcType.
        Cause: java.lang.IllegalArgumentException: No enum constant org.apache.ibatis.type.JdbcType.DATETIME
    */

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
