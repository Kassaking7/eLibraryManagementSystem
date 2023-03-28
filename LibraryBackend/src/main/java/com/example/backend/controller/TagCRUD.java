package com.example.backend.controller;

import com.example.backend.entity.Tag;
import com.example.backend.service.impl.TagServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value="/tagcrud",method = {RequestMethod.GET,RequestMethod.POST})
public class TagCRUD {

    @Autowired
    private TagServiceImpl TagService;

    @GetMapping("/listTag")
    public List<Tag> ListTags(){
        return TagService.ListTag();
    }


}

