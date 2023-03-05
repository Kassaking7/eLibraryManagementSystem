package com.example.backend.service.impl;

import com.example.backend.entity.People;
import com.example.backend.mapper.PeopleMapper;
import com.example.backend.service.PeopleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.ObjectError;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PeopleServiceImpl implements PeopleService {
    @Autowired
    private PeopleMapper peopleMapper;

    public List<People> findByName(String username){
        return peopleMapper.findPeopleByName(username);
    }

    public List<People> findPeopleByNameAndPassword(String username, String password) {
        return peopleMapper.findPeopleByNameAndPassword(username,password);}

    public String Login(String username, String password) {
        Map<String, Object> param = new HashMap<>();
        param.put("username", username);
        param.put("password", password);
        param.put("password_match", false);
        List<Map<String, Object>> res = peopleMapper.Login(param);
        return (String) param.get("password_match");
    }

    public People findById(long id){
        return peopleMapper.findPeopleById(id);
    }

    public List<People> ListPeople(){
        return peopleMapper.ListPeople();
    }

    public People insertPeople(long id, String username, Boolean is_guest,String password, String email){
        People people = new People(id,username, password, email,is_guest);
        peopleMapper.insertPeople(people);
        return people;
    }

    public int Delete(long id){
        return peopleMapper.delete(id);
    }


    public int Update(long id, Boolean is_guest){
        People people = peopleMapper.findPeopleById(id);
        people.setIs_guest(is_guest);
        return peopleMapper.Update(people);
    }
}
