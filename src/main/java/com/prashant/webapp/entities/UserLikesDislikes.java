package com.prashant.webapp.entities;

import javax.persistence.*;


@Entity
public class UserLikesDislikes {

    @Id
    private String id;

    @ManyToOne
    private User user;

    @ManyToOne
    private Notes note;

    @Column(name = "action")
    private String action;

    // Constructors, getters, and setters
    
    public UserLikesDislikes() {
    }

    public UserLikesDislikes(String id, User user, Notes note, String action) {
        this.id = id;
        this.user = user;
        this.note = note;
        this.action = action;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Notes getNote() {
        return note;
    }

    public void setNote(Notes note) {
        this.note = note;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }
    
}
