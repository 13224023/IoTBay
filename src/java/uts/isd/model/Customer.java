/*
 * The customer class is to store all customer profile from user input
 */
package uts.isd.model;

import java.io.Serializable;



/**
 *
 * @author Administrator
 */
public class Customer {
    private String username;
    private String password;
    private String email;
    private String gender;
    private String birthday;
    private String phone;
    private boolean isLogged;

    public Customer() {
        username = "";
        password = "";
        email = "";
        gender = "";
        birthday = "";
        phone = "";
        isLogged = false;
    
    }
    
    //customer constructor is to initialise all fields
    public Customer(String username, String password, String email, String gender, String birthday, String phone) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.gender = gender;
        this.birthday = birthday;
        this.phone = phone;
        this.isLogged = false;
    }
    
    //getter and setter in class

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public void setIsLogged(boolean logCondition) {
        this.isLogged = logCondition;
    }
    
    public boolean getIsLogged() {
        return this.isLogged;
    }
    
    @Override
    public String toString() {
        return username + " " + password + " " + email + " " + gender + " " + birthday + " " + phone;
    }
}