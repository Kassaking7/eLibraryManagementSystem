package com.example.elibrarybackend.service.impl;

import com.example.elibrarybackend.entity.People;
import com.example.elibrarybackend.mapper.PeopleMapper;
import com.example.elibrarybackend.service.AuthorizeService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.Random;
import java.util.concurrent.TimeUnit;

@Service
public class AuthorizeServiceImpl implements AuthorizeService {
    @Resource
    PeopleMapper mapper;
    @Value("${spring.mail.username}")
    String from;

    @Resource
    MailSender mailSender;

    @Resource
    StringRedisTemplate template;

    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        if (username == null) {
            throw new UsernameNotFoundException("Username can't be empty");
        }
        People usr = mapper.findPeopleByNameOrEmail(username);
        if (usr == null) {
            throw new UsernameNotFoundException("incorrect username or password");
        }
        return User
                .withUsername(usr.getUsername())
                .password(usr.getPassword())
                .roles("user")
                .build();
    }

    @Override
    public String sendValidateEmail(String email, String sessionId, boolean hasAccount) {
        System.out.println("get sessionId: " + sessionId);
        String key = "email:" + sessionId + ":" + email + ":" +hasAccount;
        if(Boolean.TRUE.equals(template.hasKey(key))) {
            Long expire = Optional.ofNullable(template.getExpire(key, TimeUnit.SECONDS)).orElse(0L);
            if(expire > 120) return "Too many requests, please try again later.";
        }
        People account = mapper.findPeopleByNameOrEmail(email);
        if(hasAccount && account == null) return "There is no account associated with this email address.";
        if(!hasAccount && account != null) return "This email address has already been registered by another user.";
        Random random = new Random();
        int code = random.nextInt(899999) + 100000;
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(from);
        message.setTo(email);
        message.setSubject("Your verification code email");
        message.setText("Verification code: "+code);
        try {
            mailSender.send(message);
            template.opsForValue().set(key, String.valueOf(code), 3, TimeUnit.MINUTES);
            return null;
        } catch (MailException e) {
            e.printStackTrace();
            return "Email sending failed, please check if the email address is valid.";
        }
    }

    @Override
    public String validateAndRegister(String username, String password, String email, String code, String sessionId) {
        String key = "email:" + sessionId + ":" + email + ":false";
        System.out.println("get sessionId: " + sessionId);
        if(Boolean.TRUE.equals(template.hasKey(key))) {
            String s = template.opsForValue().get(key);
            if(s == null) return "Verification code has expired, please request again.";
            if(s.equals(code)) {
                People account = mapper.findPeopleByNameOrEmail(username);
                if(account != null) return "This username has already been registered, please choose a different username.";
                template.delete(key);
                password = encoder.encode(password);
                if (mapper.createAccount(username, password, email) > 0) {
                    return null;
                } else {
                    return "Internal error, please contact the administrator.";
                }
            } else {
                return "Incorrect verification code, please check and submit again.";
            }
        } else {
            return "Please request a verification code email first";
        }
    }

    @Override
    public String validateOnly(String email, String code, String sessionId) {
        String key = "email:" + sessionId + ":" + email + ":true";
        if(Boolean.TRUE.equals(template.hasKey(key))) {
            String s = template.opsForValue().get(key);
            if(s == null) return "Verification code has expired, please request again.";
            if(s.equals(code)) {
                template.delete(key);
                return null;
            } else {
                return "Incorrect verification code, please check and submit again.";
            }
        } else {
            return "Please request a verification code email first";
        }
    }

    @Override
    public boolean resetPassword(String password, String email) {
        password = encoder.encode(password);
        return mapper.resetPasswordByEmail(password, email) > 0;
    }

    @Override
    public String getName(String email) {
        return mapper.getNameByEmail(email);
    }

    @Override
    public People getInfo(String username) {
        return mapper.findPeopleByNameOrEmail(username);
    }
}
