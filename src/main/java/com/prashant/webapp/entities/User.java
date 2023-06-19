package com.prashant.webapp.entities;

import java.util.*;
import javax.persistence.*;

@Entity
public class User {

    @Id
    private String userId;
    private String userName;
    private String userPassword;
    private String userEmail;
    private String userPic;
    private String userType;
    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    private List<Notes> notes = new ArrayList<>();
    
    public User() {
    }
    public User(String userId, String userName, String userPassword, String userEmail, String userPic, String userType, List<Notes> notes) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userPic = userPic;
        this.userType=userType;
        this.notes = notes;
    }
    public User(String userId, String userName, String userPassword, String userEmail, String userPic, String userTYpe) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userPic = userPic;
        this.userType=userTYpe;
    }

    public User(String userName, String userPassword, String userEmail, String userPic,String userType, List<Notes> notes) {
        this.userName = userName;
        this.userPassword = userPassword;
        this.userEmail = userEmail;
        this.userPic = userPic;
        this.userType=userType;
        this.notes = notes;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }


    public List<Notes> getNotes() {
        return notes;
    }

    public void setNotes(List<Notes> notes) {
        this.notes = notes;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPic() {
        return userPic;
    }

    public void setUserPic(String userPic) {
        this.userPic = userPic;
    }
    

}
