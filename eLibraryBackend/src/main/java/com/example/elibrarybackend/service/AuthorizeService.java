package com.example.elibrarybackend.service;

import com.example.elibrarybackend.entity.People;
import com.example.elibrarybackend.mapper.PeopleMapper;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.io.IOException;

public interface AuthorizeService extends UserDetailsService{
    String sendValidateEmail(String email, String sessionId, boolean hasAccount);
    String validateAndRegister(String username, String password, String email, String code, String sessionId);
    String validateOnly(String email, String code, String sessionId);
    boolean resetPassword(String password, String email);

    String getName(String email);

    People getInfo(String username);
}
