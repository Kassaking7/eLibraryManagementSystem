package com.example.elibrarybackend.service.impl;

import com.example.elibrarybackend.entity.Admin;
import com.example.elibrarybackend.mapper.AdminMapper;
import com.example.elibrarybackend.service.AdminService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Resource
    AdminMapper mapper;
    public List<Admin> checkAdminByName(String username) {
        return mapper.checkAdminByName(username);
    }
}
