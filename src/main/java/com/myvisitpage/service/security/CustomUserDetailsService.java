package com.myvisitpage.service.security;

import com.myvisitpage.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Created by Павел on 05.04.2016.
 */
@Service
@Transactional(readOnly = true)
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository repository;


    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        com.myvisitpage.model.User domainUser = repository.getByEmail(s);
        return new User(domainUser.getEmail(), domainUser.getPassword(), true,true,true,true, getAuthorities(domainUser.getRole().getId()));
    }
    public Collection<? extends GrantedAuthority> getAuthorities(Integer role) {
        return getGrantedAuthorities(getRoles(role));
    }

    public List<String> getRoles(Integer role) {

        List<String> roles = new ArrayList<String>();

        if (role == 1) {
            roles.add("ROLE_USER");
            roles.add("ROLE_ADMIN");
        } else if (role == 2) {
            roles.add("ROLE_USER");
        }
        return roles;
    }

    public static List<GrantedAuthority> getGrantedAuthorities(List<String> roles) {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

        for (String role : roles) {
            authorities.add(new SimpleGrantedAuthority(role));
        }
        return authorities;
    }
}
