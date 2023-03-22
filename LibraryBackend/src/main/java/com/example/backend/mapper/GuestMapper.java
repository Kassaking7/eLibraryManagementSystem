package com.example.backend.mapper;

import com.example.backend.entity.Guest;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface GuestMapper {

    public Guest findById(long id);

    public List<Guest> listGuests();

    public void activateGuest(Map<String, Object> param);
}
