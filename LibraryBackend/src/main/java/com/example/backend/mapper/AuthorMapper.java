package com.example.backend.mapper;

import com.example.backend.entity.Author;

import java.util.List;

public interface AuthorMapper {
    Author findAuthorById(long id);

    public List<Author> ListAuthor();
}
