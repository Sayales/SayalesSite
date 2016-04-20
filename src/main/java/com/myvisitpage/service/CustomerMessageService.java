package com.myvisitpage.service;

import com.myvisitpage.model.CustomerMessage;
import com.myvisitpage.repository.CustomerMessageRepository;
import com.myvisitpage.util.ExceptionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Павел on 01.04.2016.
 */
@Service
public class CustomerMessageService {

    @Autowired
    private CustomerMessageRepository repository;

    public List<CustomerMessage> getAllByEmail(String email) {
        return repository.getAllByEmail(email);
    }
    public List<CustomerMessage> getAllByEmail(String email, int pageNum) {
        return repository.getAllByEmail(email, pageNum);
    }

    public void save(CustomerMessage message) {
        repository.save(message);
    }

    public Void delete(int id, String email) {
        repository.delete(id, email);
        return null;
    }

    public CustomerMessage get(int id, String email) {
        return (CustomerMessage) ExceptionUtil.checkException(repository.get(id,email));
    }
    public CustomerMessage getById(int id) {
        return repository.get(id);
    }
    public void deleteById(int id) {
        repository.delete(id);
    }
}
