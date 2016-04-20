package com.myvisitpage.service;

import com.myvisitpage.model.Project;
import com.myvisitpage.model.ProjectChunk;
import com.myvisitpage.repository.ProjectRepository;
import com.myvisitpage.util.ExceptionUtil;
import com.myvisitpage.util.exceptions.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by Павел on 04.04.2016.
 */

@Service
public class ProjectService {

    @Autowired
    private ProjectRepository repository;

    public List<Project> getAll(String email) {
        return repository.getAll(email);
    }

    public Project get(int id, String userEmail) throws NotFoundException {
        return (Project) ExceptionUtil.checkException(repository.get(id,userEmail));
    }

    public void save(Project project) {
        repository.save(project);
    }

    public Void delete(int id, String email) {
        repository.delete(id, email);
        return null;
    }



    public void addChunk(ProjectChunk chunk, int projectId) throws NotFoundException {
        Project p = repository.get(projectId);
        p.getChunks().add(chunk);
        repository.save(p);
    }

    public Set<ProjectChunk> getChunks(int projectId, String userEmail) throws NotFoundException {
         Set<ProjectChunk> res = get(projectId, userEmail).getChunks();
        if (res == null) {
            return new HashSet<>();
        }
        return res;
    }

    public Set<ProjectChunk> getChunks(int projectId) throws NotFoundException {
        Set<ProjectChunk> res = repository.get(projectId).getChunks();
        if (res == null) {
            return new HashSet<>();
        }
        return res;
    }
}
