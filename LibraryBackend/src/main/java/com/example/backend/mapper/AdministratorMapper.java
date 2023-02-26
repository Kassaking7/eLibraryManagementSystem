package com.example.backend.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.example.backend.entity.Administrator;

import java.util.List;

@Repository
@Mapper
public interface AdministratorMapper {
    Administrator findAdministratorById(long id);

    public List<Administrator> ListAdministrator();

    public int insertAdministrator(Administrator Administrator);

    public int delete(long id);

    public int Update(Administrator Administrator);
}
