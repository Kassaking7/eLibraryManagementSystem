package com.example.backend.controller;

import com.example.backend.entity.People;
import com.example.backend.service.impl.PeopleServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value="/peoplecrud",method = {RequestMethod.GET,RequestMethod.POST})
public class PeopleCRUD {

    @Autowired
    private PeopleServiceImpl peopleService;

    @GetMapping("/listPeople")
    public List<People> ListPeople(){
        return peopleService.ListPeople();
    }

    @PostMapping(value="listPeopleByName")
    public List<People> ListPeopleByNAME(@RequestParam("name") String name){
        return peopleService.findByName(name);
    }
    @PostMapping(value="findPeopleByNameAndPassword")
    public List<People> ListPeopleByNAME(@RequestParam("name") String name,
                                     @RequestParam("password")String password){
        return peopleService.findPeopleByNameAndPassword(name,password);
    }
    @PostMapping(value="delete")
    public String delete(@RequestParam("id") int id){
        int result = peopleService.Delete(id);
        if (result >= 1){
            return "deleted";
        }else{
            return "failed to delete";
        }
    }

    @PostMapping(value = "insert")
    public People insert(@RequestParam("id")int id,
                        @RequestParam("name")String name,
                       @RequestParam("is_guest")Boolean is_guest,
                       @RequestParam("password")String password, 
                       @RequestParam("email")String email){
        return peopleService.insertPeople(id,name,is_guest,password,email);
    }

    @PostMapping(value = "update")
    public String update(@RequestParam("id") int id,
                       @RequestParam("is_guest") Boolean is_guest){
        int result = peopleService.Update(id,is_guest);
        if (result >= 1){
            return "modified";
        }else{
            return "failed to modify";
        }
    }
}

