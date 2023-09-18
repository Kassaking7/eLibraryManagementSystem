package com.example.elibrarybackend.service.impl;

import com.example.elibrarybackend.entity.Tag;
import com.example.elibrarybackend.mapper.TagMapper;
import com.example.elibrarybackend.service.TagService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagServiceImpl implements TagService {
    @Resource
    private TagMapper mapper;
    public List<Tag> ListTag() {
        return mapper.ListTag();
    }
}
