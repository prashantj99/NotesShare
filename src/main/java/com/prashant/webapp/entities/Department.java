package com.prashant.webapp.entities;

import java.util.*;
import javax.persistence.*;

@Entity
public class Department {
    @Id
    private String departmentId;
    private String departmentName;
    @OneToMany(mappedBy = "department",cascade = CascadeType.ALL)
    private List<Notes> notes=new ArrayList<>();

    public Department(String departmentId, String departmentName) {
        this.departmentId = departmentId;
        this.departmentName = departmentName;
    }

    public Department() {
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public List<Notes> getNotes() {
        return notes;
    }

    public void setNotes(List<Notes> notes) {
        this.notes = notes;
    }
        
}
