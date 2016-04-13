package com.myvisitpage.util;

import com.myvisitpage.model.Project;
import com.myvisitpage.util.exceptions.NotFoundException;

/**
 * Created by Павел on 06.04.2016.
 */
public class ExceptionUtil {

    private ExceptionUtil() {};

    public static Object checkException(Object o) throws NotFoundException {
        if (o == null)
            throw new NotFoundException();
        else
            return o;
    }
}

