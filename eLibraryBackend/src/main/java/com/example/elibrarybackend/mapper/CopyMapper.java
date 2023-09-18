package com.example.elibrarybackend.mapper;

import com.example.elibrarybackend.entity.Copy;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CopyMapper {
    @Select("SELECT * FROM Copy WHERE Copy.ISBN = #{ISBN} AND Copy.copy_ID = #{copyID}")
    Copy findCopyByISBNAndCopyId(String ISBN, long copyID);
}
