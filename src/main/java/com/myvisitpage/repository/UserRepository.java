package com.myvisitpage.repository;

import com.myvisitpage.model.User;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Павел on 05.04.2016.
 */
@Repository
@Transactional
public class UserRepository {

    @Autowired
    private SessionFactory sessionFactory;


    @SuppressWarnings("unchecked")
    public User getByEmail(String email) {
        Criteria criteria = sessionFactory.getCurrentSession()
                .createCriteria(User.class)
                .add(Restrictions.eq("email", email));
        List<User> result = criteria.list();
        if (result.size() > 0)
            return result.get(0);
        else
            return null;
    }

    @SuppressWarnings("unchecked")
    public User getById(int id) {
        Criteria criteria = sessionFactory.getCurrentSession()
                .createCriteria(User.class)
                .add(Restrictions.eq("id", id));
        List<User> result = criteria.list();
        if (result.size() > 0)
            return result.get(0);
        else
            return null;
    }

    public void save(User user) {
        Session session = sessionFactory.getCurrentSession();
        User upd = session.get(User.class,user.getId());
        if (upd == null) {
            session.save(user);
        } else {
            upd.setEmail(user.getEmail());
            upd.setPassword(user.getPassword());
            upd.setRole(user.getRole());
            session.update(upd);
        }
    }

    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(User.class)
                .add(Restrictions.eq("id", id));
        session.delete(criteria.list().get(0));
    }

    @SuppressWarnings("unchecked")
    public List<User> getAll() {
        return sessionFactory.getCurrentSession().createCriteria(User.class).list();
    }
}
