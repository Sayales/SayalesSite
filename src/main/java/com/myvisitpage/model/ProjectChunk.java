package com.myvisitpage.model;

import jdk.nashorn.internal.ir.annotations.Ignore;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Created by Павел on 01.04.2016.
 */
@Entity
@Table(name = "project_chunk")
public class ProjectChunk implements Serializable {

    @Id
    @GeneratedValue
    @Column(name = "chunk_id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "project_id")
    private Project project;

    @Column(name = "text")
    private String description;

    @Column(name = "date_time")
    private LocalDateTime date;

    @Column(name = "value")
    private Integer value;


    public ProjectChunk() {
    }

    public ProjectChunk(Integer id, String description, LocalDateTime date, Integer value) {
        this.id = id;
        this.description = description;
        this.date = date;
        this.value = value;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }
}
