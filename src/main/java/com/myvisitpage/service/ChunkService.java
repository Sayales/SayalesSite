package com.myvisitpage.service;

import com.myvisitpage.model.ProjectChunk;
import com.myvisitpage.repository.ChunkRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Павел on 14.04.2016.
 */

@Service
public class ChunkService {

    @Autowired
    private ChunkRepository repository;

    public ProjectChunk get(int id) {
        return repository.get(id);
    }

    public void delete(int id) {
        repository.delete(id);
    }
}
