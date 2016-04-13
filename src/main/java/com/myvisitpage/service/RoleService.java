package com.myvisitpage.service;

import com.myvisitpage.model.Role;
import com.myvisitpage.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Павел on 05.04.2016.
 */
@Service
public class RoleService {

    @Autowired
    private RoleRepository repository;

    public Role getById(int id) {
        return repository.getById(id);
    }

    public Role getByName(String name) {
        return repository.getByName(name);
    }

}
