package com.myvisitpage.repository;

import com.myvisitpage.model.CustomerMessage;
import com.myvisitpage.model.Project;
import com.myvisitpage.util.exceptions.NotFoundException;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Павел on 04.04.2016.
 */

@Repository
@Transactional
public class ProjectRepository {

    @Autowired
    private SessionFactory sessionFactory;


    public void save(Project project) {
        Session session = sessionFactory.getCurrentSession();
        Project updProject = session.get(Project.class, project.getId());
        if (updProject == null) {
            session.save(project);
        } else {
            updProject.setDescription(project.getDescription());
            updProject.setChunks(project.getChunks());
            updProject.setDevTime(project.getDevTime());
            session.save(updProject);
        }
    }



    /*public void update(Project project) {
        Session session = sessionFactory.getCurrentSession();
        Project updProject = session.get(Project.class, project.getId());
        updProject.setDescription(project.getDescription());
        updProject.setChunks(project.getChunks());
        updProject.setDevTime(project.getDevTime());
        session.save(updProject);
    }*/


    @SuppressWarnings("unchecked")
    public void delete(int id, String userEmail) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Project.class)
                .add(Restrictions.eq("userEmail", userEmail))
                .add(Restrictions.eq("id",id));
        List<Project> list = criteria.list();
        Project project;
        if (list.size() > 0) {
            project = list.get(0);
        } else {
           throw new NotFoundException();
        }
        session.delete(project);
    }

    @SuppressWarnings("unchecked")
    public Project get(int id, String userEmail) {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Project.class)
                .add(Restrictions.eq("userEmail", userEmail))
                .add(Restrictions.eq("id",id));
        List<Project> list = criteria.list();
        if (list.size() > 0) {
            return list.get(0);
        } else {
            return null;
        }
    }
    public Project get(int id) {
       return sessionFactory.getCurrentSession().get(Project.class, id);
    }
    @SuppressWarnings("unchecked")
    public List<Project> getAll(String userEmail) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(Project.class)
                .add(Restrictions.eq("userEmail",userEmail))
                .addOrder(Order.desc("startDate"));
        return criteria.list();
    }
}
