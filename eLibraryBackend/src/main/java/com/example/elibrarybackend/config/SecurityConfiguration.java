package com.example.elibrarybackend.config;

import com.alibaba.fastjson2.JSONObject;
import com.example.elibrarybackend.entity.RestBean;
import com.example.elibrarybackend.service.AuthorizeService;
import com.example.elibrarybackend.service.CustomAuthenticationEntryPoint;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.stereotype.Component;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Arrays;

@Configuration
public class SecurityConfiguration {
    @Resource
    AuthorizeService authorizeService;
    @Resource
    CustomAuthenticationEntryPoint customAuthenticationEntryPoint;

    @Resource
    DataSource dataSource;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http,
                                            PersistentTokenRepository repository) throws Exception {
        return http
                .authorizeHttpRequests(conf -> {
                    conf.requestMatchers("/api/auth/**").permitAll();
                    conf.anyRequest().authenticated();
                })
                .formLogin(conf -> {
                    conf.loginProcessingUrl("/api/auth/login");
                    conf.failureHandler(this::onAuthenticationFailure);
                    conf.successHandler(this::onAuthenticationSuccess);
                    conf.permitAll();
                })
                .logout(conf-> {
                    conf.logoutUrl("/api/auth/logout");
                    conf.logoutSuccessHandler(this::onAuthenticationSuccess);
                    conf.permitAll();
                })
                .cors(conf -> {
                    CorsConfiguration cors = new CorsConfiguration();
                    cors.addAllowedOriginPattern("*");
                    cors.addAllowedOriginPattern("http://127.0.0.1:3000");
                    cors.addAllowedOriginPattern("http://127.0.0.1:3000/signup");
                    cors.setAllowCredentials(true);
                    cors.addAllowedHeader("*");
                    cors.addAllowedMethod("*");
                    cors.addExposedHeader("*");
                    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
                    source.registerCorsConfiguration("/**", cors);
                    conf.configurationSource(source);
                })
                .userDetailsService(authorizeService)
                .exceptionHandling(conf->{
                    conf.authenticationEntryPoint(customAuthenticationEntryPoint);
                })
                .rememberMe(conf -> {
                    conf.rememberMeParameter("remember");
                    conf.tokenRepository(repository);
                    conf.tokenValiditySeconds(3600*24*3);
                })
                .csrf((csrf) -> {
                    csrf.disable();})
                .build();
    }

    @Bean
    public PersistentTokenRepository tokenRepository(){
        JdbcTokenRepositoryImpl jdbcTokenRepository = new JdbcTokenRepositoryImpl();
        jdbcTokenRepository.setDataSource(dataSource);
        jdbcTokenRepository.setCreateTableOnStartup(false);
        return jdbcTokenRepository;
    }
    @Bean
    public BCryptPasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    private void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException {
        httpServletResponse.setCharacterEncoding("utf-8");
        if(httpServletRequest.getRequestURI().endsWith("/login"))
            httpServletResponse.getWriter().write(JSONObject.toJSONString(RestBean.success("login success!")));
        else if(httpServletRequest.getRequestURI().endsWith("/logout"))
            httpServletResponse.getWriter().write(JSONObject.toJSONString(RestBean.success("log out success!")));
    }

    private void onAuthenticationFailure(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException{
        httpServletResponse.setCharacterEncoding("utf-8");
        httpServletResponse.getWriter().write(JSONObject.toJSONString(RestBean.failure(401, e.getMessage())));
    }

}
