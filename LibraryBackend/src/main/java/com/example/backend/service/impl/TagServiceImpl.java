package com.example.backend.service.impl;

import com.example.backend.entity.Tag;
import com.example.backend.mapper.TagMapper;
import com.example.backend.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagServiceImpl implements TagService {
    @Autowired
    private TagMapper TagMapper;

    public List<Tag> ListTag() {
        return TagMapper.ListTag();
    }

}
