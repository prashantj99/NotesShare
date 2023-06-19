package com.prashant.webapp.entities;

import java.util.*;
import javax.persistence.*;

@Entity
public class Category {
    @Id
    private String categoryId;
    private String categoryName;
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
    private List<Notes> notes=new ArrayList<>();
    public Category() {
    }

    public Category(String categoryId, String categoryName, List<Notes> notes) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.notes=notes;
    }

    public Category(String categoryId, String categoryName) {
        this.categoryId=categoryId;
        this.categoryName=categoryName;
    }

    public List<Notes> getNotes() {
        return notes;
    }

    public void setNotes(List<Notes> notes) {
        this.notes = notes;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
}
