package com.example.backend.mapper;

import com.example.backend.entity.Copy;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
@Mapper
public interface CopyMapper {
    Copy findCopyByISBNAndCopyId(String ISBN, long copyID);

    public List<Copy> listCopiesByISBN(String ISBN);

    public int insertCopy(Copy copy);

    public int delete(String ISBN, long copyID);

    public int update(Copy copy);

    public List<Map<String, Object>> borrowBookWithKnownBook(Map<String, Object> param);

    public List<Map<String, Object>> borrowBookWithKnownCopy(Map<String, Object> param);

    public int returnBook(Copy copy);
}
