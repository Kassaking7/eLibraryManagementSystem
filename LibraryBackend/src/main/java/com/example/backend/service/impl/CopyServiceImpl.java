package com.example.backend.service.impl;

import com.example.backend.entity.Copy;
import com.example.backend.mapper.CopyMapper;
import com.example.backend.service.CopyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CopyServiceImpl implements CopyService {
    @Autowired
    private CopyMapper copyMapper;

    public Copy findCopyByISBNAndCopyId(String ISBN, long copyID) {
        return copyMapper.findCopyByISBNAndCopyId(ISBN, copyID);
    }

    public List<Copy> listCopiesByISBN(String ISBN) {
        return copyMapper.listCopiesByISBN(ISBN);
    }

    public Copy insertCopy(String ISBN, long copyID, Boolean availability, long bookshelfID) {
        Copy copy = new Copy(ISBN, copyID, availability, bookshelfID);
        copyMapper.insertCopy(copy);
        return copy;
    }

    public int delete(String ISBN, long copyID) {
        return copyMapper.delete(ISBN, copyID);
    }

    public int update(String ISBN, long copyID, Boolean availability, long bookshelfID) {
        Copy copy = copyMapper.findCopyByISBNAndCopyId(ISBN, copyID);
        copy.setAvailability(availability);
        copy.setBookshelfID(bookshelfID);
        return copyMapper.update(copy);
    }

    public Boolean borrowBookWithKnownBook(String ISBN, long userID) {
        Map<String, Object> param = new HashMap<>();
        param.put("user_id", userID);
        param.put("ISBN", ISBN);
        param.put("enough_credit", false);
        param.put("copy_available", false);
        if (copyMapper.borrowBookWithKnownBook(param) != null) {
            return ((Boolean) param.get("enough_credit") && (Boolean) param.get("copy_available"));
        };
        return false;
    }

    public Boolean borrowBookWithKnownCopy(String ISBN, long copyID, long userID) {
        Map<String, Object> param = new HashMap<>();
        param.put("user_id", userID);
        param.put("ISBN", ISBN);
        param.put("copy_ID", copyID);
        param.put("enough_credit", false);
        param.put("copy_available", false);
        if (copyMapper.borrowBookWithKnownCopy(param) != null) {
            return ((Boolean) param.get("enough_credit") && (Boolean) param.get("copy_available"));
        };
        return false;
    }

    public int returnBook(String ISBN, long copyID, long userID) {
        return 0;
    }
}
