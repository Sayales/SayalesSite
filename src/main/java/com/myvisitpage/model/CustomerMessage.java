package com.myvisitpage.model;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDateTime;

/**
 * Created by Павел on 01.04.2016.
 */

@Entity
@Table(name = "message")
public class CustomerMessage implements Serializable{

    private static final long serialVersionUID = -5527566248002296042L;

    @Id
    @GeneratedValue
    @Column(name = "id")
    private int id;

    @Column(name = "text")
    private String text;

    @Column(name = "title")
    private String title = "Default title"; //default title for testing?

    @Column(name = "date_time")
    private LocalDateTime dateTime;

    @Column(name = "user_email")
    private String userEmail;

    public CustomerMessage() {
    }

    public CustomerMessage(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }

    public CustomerMessage(String userEmail) {
        this.userEmail = userEmail;
        this.dateTime = LocalDateTime.now();
    }

    public CustomerMessage(String text, LocalDateTime dateTime) {
        this.text = text;
        this.dateTime = dateTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
}
