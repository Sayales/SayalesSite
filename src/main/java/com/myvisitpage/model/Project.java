package com.myvisitpage.model;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by Павел on 01.04.2016.
 */

@Entity
@Table(name = "project")
public class Project implements Serializable {

    @Id
    @GeneratedValue
    @Column(name = "project_id")
    private int id;

    @Column(name = "project_name")
    private String name;

    @Column(name = "text")
    private String description;

    @Column(name = "date_time")
    private LocalDateTime startDate;

    @Column(name = "dev_time")
    private LocalTime devTime;

    @Column(name = "user_email")
    private String userEmail;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "project", cascade = CascadeType.REMOVE)
    private Set<ProjectChunk> chunks = new HashSet<>();

    public Project() {
        startDate = LocalDateTime.now();
        devTime = LocalTime.of(0,0,0);
    }

    public Project(String name, String description) {
        this.name = name;
        this.description = description;
        startDate = LocalDateTime.now();
        devTime = LocalTime.of(0,0,0);
    }

    public Project(String description, LocalDateTime startDate, LocalTime devTime) {
        this.description = description;
        this.startDate = startDate;
        this.devTime = devTime;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalTime getDevTime() {
        return devTime;
    }

    public void setDevTime(LocalTime devTime) {
        this.devTime = devTime;
    }

    public Set<ProjectChunk> getChunks() {
        return chunks;
    }

    public void setChunks(Set<ProjectChunk> chunks) {
        this.chunks = chunks;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
