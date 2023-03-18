package com.example.backend.service;

import com.example.backend.entity.Copy;
import com.sun.org.apache.xpath.internal.operations.Bool;

import java.util.List;
public interface CopyService {
    public Copy findCopyByISBNAndCopyId(String ISBN, long copyID);

    public List<Copy> listCopiesByISBN(String ISBN);

    public Copy insertCopy(String ISBN, long copyID, Boolean availability, long bookshelfID);

    public int delete(String ISBN, long copyID);

    public int update(String ISBN, long copyID, Boolean availability, long bookshelfID);

    public Boolean borrowBookWithKnownBook(String ISBN, long userID);

    public Boolean borrowBookWithKnownCopy(String ISBN, long copyID, long userID);

    public int returnBook(String ISBN, long copyID, long userID);
}
