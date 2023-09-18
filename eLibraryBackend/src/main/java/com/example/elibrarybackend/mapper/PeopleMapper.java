package com.example.elibrarybackend.mapper;

import com.example.elibrarybackend.entity.AccountUser;
import com.example.elibrarybackend.entity.People;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface PeopleMapper {
    @Select("select * from People where username=#{text} or email_address=#{text}")
    People findPeopleByNameOrEmail(String text);
    @Select("select * from People where username=#{text} or email_address=#{text}")
    AccountUser findAccountUserByNameOrEmail(String text);

    @Insert("insert into People (email_address, username, password) values (#{email}, #{username}, #{password})")
    int createAccount(String username, String password, String email);


    @Update("update People set password = #{password} where email_address = #{email}")
    int resetPasswordByEmail(String password, String email);

    @Select("Select username from People where email_address=#{email}")
    String getNameByEmail(String email);


    @Deprecated // Used Trigger in MySQL instead
    @Insert("insert into Guest (is_activated) values (true)")
    int ValidateAccount();
}
