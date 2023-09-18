package com.example.elibrarybackend.service;

import com.example.elibrarybackend.entity.Copy;

public interface CopyService {
    public Copy findCopyByISBNAndCopyId(String ISBN, long copyID);
}
