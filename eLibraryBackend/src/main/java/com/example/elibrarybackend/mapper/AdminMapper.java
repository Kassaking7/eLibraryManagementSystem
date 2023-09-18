package com.example.elibrarybackend.mapper;

import com.example.elibrarybackend.entity.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface AdminMapper {

    @Select("SELECT * FROM Administrator\n" +
            "        where id IN (\n" +
            "          SELECT a.id\n" +
            "          FROM Administrator AS a\n" +
            "          INNER JOIN People AS p ON a.id = p.id\n" +
            "          WHERE p.username=#{username}\n" +
            "        )")
    public List<Admin> checkAdminByName(String username);


    @Select("SELECT COUNT(*) > 0\n" +
            "        FROM Administrator AS a\n" +
            "        INNER JOIN in_charged_by AS b ON a.ID = b.administrator_ID\n" +
            "        WHERE b.location_ID = #{locationID}\n" +
            "        AND a.can_host_event = TRUE\n" +
            "        AND a.ID = #{adminID}")
    public Boolean canHoldEvent(long adminID, long locationID);
}
