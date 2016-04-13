package com.myvisitpage.service.components;

import com.myvisitpage.model.Role;
import com.myvisitpage.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.util.Locale;

/**
 * Created by Павел on 11.04.2016.
 */
@Component
public class RoleFormatter implements Formatter<Role> {

    @Autowired
    private RoleService service;

    @Override
    public Role parse(String s, Locale locale) throws ParseException {
        return service.getByName(s);
    }

    @Override
    public String print(Role role, Locale locale) {
        return role.getRoleText();
    }
}
