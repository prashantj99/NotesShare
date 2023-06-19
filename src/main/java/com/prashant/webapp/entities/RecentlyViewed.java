package com.prashant.webapp.entities;

import java.sql.Timestamp;
import javax.persistence.*;

@Entity
public class RecentlyViewed {

    @Id
    private String id;

    @ManyToOne
    private User user;

    @ManyToOne
    private Notes note;
    
    @Column(name = "viewedTimestamp")
    private Timestamp viewedTimestamp;
    // Constructors, getters, and setters
    
    public RecentlyViewed() {
    }

    public RecentlyViewed(String id, User user, Notes note) {
        this.id = id;
        this.user = user;
        this.note = note;
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

    public Timestamp getViewedTimestamp() {
        return viewedTimestamp;
    }

    public void setViewedTimestamp(Timestamp viewedTimestamp) {
        this.viewedTimestamp = viewedTimestamp;
    }
}
