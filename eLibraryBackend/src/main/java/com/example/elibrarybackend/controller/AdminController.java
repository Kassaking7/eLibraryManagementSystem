package com.example.elibrarybackend.controller;

import com.example.elibrarybackend.entity.Admin;
import com.example.elibrarybackend.service.AdminService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@RequestMapping("/api/admin")
public class AdminController {
    @Resource
    private AdminService service;

    @GetMapping("/{name}")
    public List<Admin> checkAdminByName(@PathVariable("name") String username){
        return service.checkAdminByName(username);
    }
}
