package com.example.backend.service;

import com.example.backend.entity.People;

import java.util.List;

public interface PeopleService {
    public List<People> findByName(String username);
    public List<People> findPeopleByNameAndPassword(String username, String password);
    public People findById(long id);

    public List<People> ListPeople();

    public People insertPeople(long id,String username, Boolean is_guest,String password,String email);

    public int Delete(long id);

    public int Update(long id, Boolean is_guest);
}
