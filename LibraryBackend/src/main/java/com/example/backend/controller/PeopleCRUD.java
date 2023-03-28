package com.example.backend.controller;

import com.example.backend.entity.People;
import com.example.backend.service.impl.PeopleServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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

    @PostMapping(value="Login")
    public List<String> Login(@RequestParam("username") String username,
                              @RequestParam("password")String password){
        List<String> result = new ArrayList<String>();
        result.add(peopleService.Login(username,password));
        return result;
    }

    @PostMapping(value="SignUp")
    public List<People> SignUp(@RequestParam("username") String username,
                              @RequestParam("password")String password,
                               @RequestParam("email_address")String email_address){
        List<People> result = new ArrayList<People>();
        result.add(peopleService.SignUp(username,password,email_address));
        return result;
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
                        @RequestParam("username")String username,
                       @RequestParam("is_guest")Boolean is_guest,
                       @RequestParam("password")String password, 
                       @RequestParam("email_address")String email_address){
        return peopleService.insertPeople(id,username,is_guest,password,email_address);
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

