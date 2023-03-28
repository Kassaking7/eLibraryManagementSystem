package com.example.backend.mapper;

import com.example.backend.entity.Tag;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface TagMapper {
    public List<Tag> ListTag();
}
