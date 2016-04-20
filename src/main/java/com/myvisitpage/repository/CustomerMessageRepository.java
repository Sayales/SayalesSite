package com.myvisitpage.repository;

import com.myvisitpage.model.CustomerMessage;
import com.myvisitpage.util.exceptions.NotFoundException;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


import javax.annotation.Resource;
import javax.sql.DataSource;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Created by Павел on 01.04.2016.
 */

@Repository
@Transactional
public class CustomerMessageRepository {

    @Autowired
    private SessionFactory sessionFactory;


    public void save(CustomerMessage message) {
        Session session = sessionFactory.getCurrentSession();
        CustomerMessage updMessage = session.get(CustomerMessage.class, message.getId());
        if (updMessage == null) {
            session.save(message);
        }
        else {
            updMessage.setText(message.getText());
            session.save(updMessage);
        }
    }



  /*  public void update(CustomerMessage message) {
        Session session = sessionFactory.getCurrentSession();
        CustomerMessage updMessage = session.get(CustomerMessage.class, message.getId());
        updMessage.setText(message.getText());
        session.save(updMessage);
    }*/

    @SuppressWarnings("unchecked")
    public void delete(int id,String email) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(CustomerMessage.class)
                .add(Restrictions.eq("userEmail", email))
                .add(Restrictions.eq("id", id));
        List<CustomerMessage> list = criteria.list();
        CustomerMessage message;
        if (list.size() > 0) {
            message = list.get(0);
        } else {
            throw new NotFoundException();
        }
        session.delete(message);
    }

    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();
        CustomerMessage message = session.get(CustomerMessage.class, id);
        session.delete(message);
    }

    @SuppressWarnings("unchecked")
    public CustomerMessage get(int id, String email) {
       Criteria criteria = sessionFactory.getCurrentSession().createCriteria(CustomerMessage.class)
               .add(Restrictions.eq("userEmail", email))
               .add(Restrictions.eq("id", id));
        List<CustomerMessage> list = criteria.list();
        if (list.size() > 0) {
            return list.get(0);
        } else {
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public List<CustomerMessage> getAllByEmail(String email) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(CustomerMessage.class)
                .add(Restrictions.eq("userEmail",email))
                .addOrder(Order.desc("dateTime"));
        return criteria.list();
    }

    @SuppressWarnings("unchecked")
    public List<CustomerMessage> getAllByEmail(String email, int pageNum) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(CustomerMessage.class)
                .add(Restrictions.eq("userEmail",email))
                .addOrder(Order.desc("dateTime"));
        criteria.setFirstResult((pageNum - 1) * 30);
        criteria.setMaxResults(30);
        return criteria.list();
    }

    public CustomerMessage get(int id) {
        return sessionFactory.getCurrentSession().get(CustomerMessage.class, id);
    }
}
