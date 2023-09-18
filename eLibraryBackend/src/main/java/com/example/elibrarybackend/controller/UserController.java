package com.example.elibrarybackend.controller;

import com.example.elibrarybackend.entity.AccountUser;
import com.example.elibrarybackend.entity.People;
import com.example.elibrarybackend.entity.RestBean;
import com.example.elibrarybackend.service.AuthorizeService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserController {
    @Resource
    AuthorizeService service;
    @GetMapping("/me")
    public RestBean<AccountUser> me(@SessionAttribute("account") AccountUser user){
        return RestBean.success(user);
    }

    @GetMapping("/info/{username}")
    public People info(@PathVariable("username") String username) {
        return service.getInfo(username);
    }
}