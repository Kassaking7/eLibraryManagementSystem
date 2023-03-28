package com.example.backend.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.example.backend.entity.People;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@Repository
@Mapper
public interface PeopleMapper {
    List<People> findPeopleByName(String username);
    List<People> findPeopleByNameAndPassword(String username, String password);

    List<Map<String, Object>> Login(Map<String, Object> param);

    List<Map<String, Object>> SignUp(Map<String, Object> param);


    People findPeopleById(long id);

    public List<People> ListPeople();

    public int insertPeople(People People);

    public int delete(long id);

    public int Update(People people);
}
