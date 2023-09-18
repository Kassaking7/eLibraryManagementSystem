package com.example.elibrarybackend.service;

import com.example.elibrarybackend.entity.Admin;

import java.util.List;

public interface AdminService {
    public List<Admin> checkAdminByName(String username);
}
