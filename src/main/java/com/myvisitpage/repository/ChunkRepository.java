package com.myvisitpage.repository;

import com.myvisitpage.model.ProjectChunk;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Павел on 14.04.2016.
 */
@Repository
@Transactional
public class ChunkRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public ProjectChunk get(int id) {
        return sessionFactory.getCurrentSession().get(ProjectChunk.class, id);
    }

    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();
        ProjectChunk chunk = session.get(ProjectChunk.class, id);
        session.delete(chunk);
    }

}
