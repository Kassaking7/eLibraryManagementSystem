package com.example.elibrarybackend.controller;


import com.example.elibrarybackend.entity.Copy;
import com.example.elibrarybackend.service.CopyService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/copy")
public class CopyController {
    @Resource
    private CopyService service;

    @GetMapping("/{ISBN}/{copy_id}")
    public Copy findCopyByISBNAndCopyId(@PathVariable("ISBN") String ISBN,
                                        @PathVariable("copy_id") long copyId){
        return service.findCopyByISBNAndCopyId(ISBN,copyId);
    }
}
