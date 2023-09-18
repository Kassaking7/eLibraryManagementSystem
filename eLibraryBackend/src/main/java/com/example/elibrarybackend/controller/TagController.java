package com.example.elibrarybackend.controller;

import com.example.elibrarybackend.entity.Tag;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.example.elibrarybackend.service.TagService;

import java.util.List;

@RestController
@RequestMapping("/api/tag")
public class TagController {
    @Resource
    private TagService service;

    @GetMapping("/")
    public List<Tag> ListTags(){
        return service.ListTag();
    }

}
