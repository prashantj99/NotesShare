package com.prashant.webapp.entities;

import java.util.*;
import javax.persistence.*;

@Entity
public class Course {
    @Id
    private String courseId;
    private String courseName;
    private int sem ;
    @ManyToMany(mappedBy = "course",cascade = CascadeType.ALL)
    private List<Notes> notes=new ArrayList<>();

    public Course() {
    }

    public Course(String courseId, String courseName, int sem) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.sem = sem;
    }
    public Course(String courseId, String courseName, int sem, List<Notes> notes) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.sem = sem;
        this.notes=notes;
    }
    
    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public int getSem() {
        return sem;
    }

    public void setSem(int sem) {
        this.sem = sem;
    }

    public List<Notes> getNotes() {
        return notes;
    }

    public void setNotes(List<Notes> notes) {
        this.notes = notes;
    }
    
}
