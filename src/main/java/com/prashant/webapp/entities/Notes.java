package com.prashant.webapp.entities;

import java.util.*;
import javax.persistence.*;

@Entity
public class Notes {
    @Id
    private String noteId;
    private String noteName;
    private String noteTitle;
    private String noteUniversity;
    private String type;//handwritten or printed
    private String noteDescription;
    private String noteSemester;
    private String noteTags;
    private long views;
    private long dislikes;
    private long likes;
    private int status;
    @ManyToOne
    private Category category;
    @ManyToOne
    private Department department;
    @ManyToOne
    private  User user;
    @ManyToMany(cascade = CascadeType.ALL)
    private List<Course> course=new ArrayList<>();
    
    
    public Notes(){
    }

    public Notes(String noteId, String noteName, String noteTitle, String noteUniversity, String type, String noteDescription, String noteSemester, String noteTags, int status, Category category, Department department, User user, List<Course> course) {
        this.noteId = noteId;
        this.noteName = noteName;
        this.noteTitle = noteTitle;
        this.noteUniversity = noteUniversity;
        this.type = type;
        this.noteDescription = noteDescription;
        this.noteSemester = noteSemester;
        this.noteTags = noteTags;
        this.status = status;
        this.category = category;
        this.department = department;
        this.user = user;
        this.course=course;
    }

    public Notes(String noteId, String noteName, String noteTitle, String noteUniversity, String type, String noteDescription, String noteSemester, String noteTags, long views, long dislikes, long likes, int status, Category category, Department department) {
        this.noteId = noteId;
        this.noteName = noteName;
        this.noteTitle = noteTitle;
        this.noteUniversity = noteUniversity;
        this.type = type;
        this.noteDescription = noteDescription;
        this.noteSemester = noteSemester;
        this.noteTags = noteTags;
        this.views = views;
        this.dislikes = dislikes;
        this.likes = likes;
        this.status = status;
        this.category = category;
        this.department = department;
    }

    public String getNoteId() {
        return noteId;
    }

    public void setNoteId(String noteId) {
        this.noteId = noteId;
    }

    public String getNoteName() {
        return noteName;
    }

    public void setNoteName(String noteName) {
        this.noteName = noteName;
    }

    public String getNoteTitle() {
        return noteTitle;
    }

    public void setNoteTitle(String noteTitle) {
        this.noteTitle = noteTitle;
    }

    public String getNoteUniversity() {
        return noteUniversity;
    }

    public void setNoteUniversity(String noteUniversity) {
        this.noteUniversity = noteUniversity;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getNoteDescription() {
        return noteDescription;
    }

    public void setNoteDescription(String noteDescription) {
        this.noteDescription = noteDescription;
    }

    public String getNoteSemester() {
        return noteSemester;
    }

    public void setNoteSemester(String noteSemester) {
        this.noteSemester = noteSemester;
    }

    public String getNoteTags() {
        return noteTags;
    }

    public void setNoteTags(String noteTags) {
        this.noteTags = noteTags;
    }

    public long getViews() {
        return views;
    }

    public void setViews(long views) {
        this.views = views;
    }

    public long getDislikes() {
        return dislikes;
    }

    public void setDislikes(long dislikes) {
        this.dislikes = dislikes;
    }

    public long getLikes() {
        return likes;
    }

    public void setLikes(long likes) {
        this.likes = likes;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Course> getCourse() {
        return course;
    }

    public void setCourse(List<Course> course) {
        this.course = course;
    }
    
    
    
}
