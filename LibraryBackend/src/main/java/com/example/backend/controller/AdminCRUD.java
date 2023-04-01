package com.example.backend.controller;

import com.example.backend.entity.Administrator;
import com.example.backend.service.impl.AdministratorServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value="/admincrud",method = {RequestMethod.GET,RequestMethod.POST})
public class AdminCRUD {

    @Autowired
    private AdministratorServiceImpl AdministratorService;

    @GetMapping("/listAdministrator")
    public List<Administrator> ListAdministrator(){
        return AdministratorService.ListAdministrator();
    }

    @GetMapping("/checkAdminByName")
    public List<Administrator> checkAdminByName(@RequestParam("username") String username){
        return AdministratorService.checkAdminByName(username);
    }


    @PostMapping(value="delete")
    public String delete(@RequestParam("id") int id){
        int result = AdministratorService.Delete(id);
        if (result >= 1){
            return "deleted";
        }else{
            return "failed to delete";
        }
    }

    @PostMapping(value = "insert")
    public Administrator insert(@RequestParam("id") long id,
                        @RequestParam("can_edit_book") Boolean can_edit_book,
                       @RequestParam("can_host_event") Boolean can_host_event){
        return AdministratorService.insertAdministrator(id,can_edit_book,can_host_event);
    }

    @PostMapping(value = "update")
    public String update(@RequestParam("id") long id,
    @RequestParam("can_edit_book") Boolean can_edit_book,
    @RequestParam("can_host_event") Boolean can_host_event){
        int result = AdministratorService.Update(id,can_edit_book,can_host_event);
        if (result >= 1){
            return "modified";
        }else{
            return "failed to modify";
        }
    }
}

