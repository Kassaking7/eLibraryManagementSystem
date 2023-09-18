package com.example.elibrarybackend.mapper;

import com.example.elibrarybackend.entity.Location;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface LocationMapper {

    @Select("select open_time, close_time from location where ID = #{id}")
    public Location getLocationByID(long id);
}
