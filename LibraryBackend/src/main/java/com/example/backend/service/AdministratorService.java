package com.example.backend.service;

import com.example.backend.entity.Administrator;

import java.util.List;

public interface AdministratorService {
    public Administrator findById(long id);

    public List<Administrator> ListAdministrator();

    public Administrator insertAdministrator(long id, Boolean can_edit_book,Boolean can_host_event);

    public int Delete(long id);

    public int Update(long id, Boolean can_edit_book,Boolean can_host_event);
}
