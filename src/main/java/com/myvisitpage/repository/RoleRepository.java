package com.myvisitpage.repository;

import com.myvisitpage.model.Role;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Павел on 05.04.2016.
 */
@Repository
@Transactional
public class RoleRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public Role getById(int id) {
        return sessionFactory.getCurrentSession().get(Role.class, id);
    }

    public Role getByName(String name) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Role.class)
                .add(Restrictions.eq("roleText",name));
        return (Role) criteria.list().get(0);
    }
}
