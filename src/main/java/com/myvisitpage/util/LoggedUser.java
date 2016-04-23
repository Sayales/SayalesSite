package com.myvisitpage.util;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * Created by Павел on 22.04.2016.
 */
public class LoggedUser {

    public static String getName() {
        Object o = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (o instanceof UserDetails) {
            UserDetails ud = (UserDetails) o;
            return ud.getUsername();
        } else if (o instanceof String) {
            return (String) o;
        }
        return null;
    }

}
