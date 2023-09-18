package com.example.elibrarybackend.mapper;

import com.example.elibrarybackend.entity.Tag;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface TagMapper {
    @Select("Select * from Tag")
    public List<Tag> ListTag();
}