package com.prashant.webapp.entities;

import java.sql.Timestamp;
import javax.persistence.*;
import javax.persistence.ManyToOne;

@Entity
public class SavedNotes {
    @Id
    private String id;
    @ManyToOne
    private Notes note;
    @ManyToOne
    private User user;
    @Column(name = "savedTime", nullable=false)
    private Timestamp timestamp;

    public SavedNotes(String id, Notes note, User user, Timestamp timestamp) {
        this.id = id;
        this.note = note;
        this.user = user;
        this.timestamp = timestamp;
    }

    public SavedNotes() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Notes getNote() {
        return note;
    }

    public void setNote(Notes note) {
        this.note = note;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }
    
}
