package com.example.backend.service.impl;

import com.example.backend.entity.Administrator;
import com.example.backend.mapper.AdministratorMapper;
import com.example.backend.service.AdministratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdministratorServiceImpl implements AdministratorService {
    @Autowired
    private AdministratorMapper AdministratorMapper;

    public Administrator findById(long id){
        return AdministratorMapper.findAdministratorById(id);
    }

    public List<Administrator> ListAdministrator(){
        return AdministratorMapper.ListAdministrator();
    }
    public Administrator insertAdministrator(long id, Boolean can_edit_book,Boolean can_host_event) {
        Administrator Administrator = new Administrator(id,can_edit_book,can_host_event);
        AdministratorMapper.insertAdministrator(Administrator);
        return Administrator;
    }

    public int Delete(long id) {
        return AdministratorMapper.delete(id);
    }

    public int Update(long id, Boolean can_edit_book,Boolean can_host_event){
        Administrator Administrator = AdministratorMapper.findAdministratorById(id);
        Administrator.setCan_edit_book(can_edit_book);
        Administrator.setCan_host_event(can_host_event);
        return AdministratorMapper.Update(Administrator);
    }
}
