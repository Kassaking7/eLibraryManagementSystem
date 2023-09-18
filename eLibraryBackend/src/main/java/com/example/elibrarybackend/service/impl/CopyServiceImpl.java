package com.example.elibrarybackend.service.impl;

import com.example.elibrarybackend.entity.Copy;
import com.example.elibrarybackend.mapper.CopyMapper;
import com.example.elibrarybackend.service.CopyService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

@Service
public class CopyServiceImpl implements CopyService {
    @Resource
    private CopyMapper mapper;

    public Copy findCopyByISBNAndCopyId(String ISBN, long copyID) {
        return mapper.findCopyByISBNAndCopyId(ISBN, copyID);
    }

}
