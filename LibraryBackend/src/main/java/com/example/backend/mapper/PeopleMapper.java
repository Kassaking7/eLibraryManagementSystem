package com.example.backend.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.example.backend.entity.People;

import java.util.List;

@Repository
@Mapper
public interface PeopleMapper {
    List<People> findPeopleByName(String username);
    List<People> findPeopleByNameAndPassword(String username, String password);
    People findPeopleById(long id);

    public List<People> ListPeople();

    public int insertPeople(People People);

    public int delete(long id);

    public int Update(People people);
}
