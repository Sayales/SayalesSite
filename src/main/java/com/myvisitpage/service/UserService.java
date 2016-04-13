package com.myvisitpage.service;

import com.myvisitpage.model.User;
import com.myvisitpage.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Павел on 05.04.2016.
 */
@Service
public class UserService {

    @Autowired
    private UserRepository repository;

    public void save(User user) {
        repository.save(user);
    }

    public List<User> getAll() {
        return repository.getAll();
    }

    public User getById(int id) {
        return repository.getById(id);
    }

    public User getByEmail(String email) {
        return repository.getByEmail(email);
    }

    public void delete(int id) {
        repository.delete(id);
    }
}
