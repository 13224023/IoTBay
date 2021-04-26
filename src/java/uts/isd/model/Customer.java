/*
 * The customer class is to store all customer profile from user input
 */
package uts.isd.model;
import java.io.Serializable;



/**
 *
 * @author Administrator
 */
public class Customer implements Serializable {
    private String username;
    private String userFirstName;
    private String userLastName;
    private String password;
    private String email;
    private String birthday;
    private String phone;
    private String usertype;
    private boolean isLogged;

    public Customer() {
        username = "";
        password = "";
        email = "";
        birthday = "";
        phone = "";
        isLogged = false;
    
    }
    
    //customer constructor is to initialise all fields
    public Customer(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.userFirstName = "";
        this.userLastName = "";
        this.birthday = "";
        this.phone = "";
        this.usertype = "0";
        this.isLogged = false;
    }
    
    public Customer(String username, String password, String usertype, String firstname,  String lastname, 
            String phone, String email, String birthday) {
        this.username = username;
        this.password = password;
        this.usertype = usertype;
        this.email = email;
        this.userFirstName = firstname;
        this.userLastName = lastname;
        this.birthday = birthday;
        this.phone = phone;
        this.isLogged = false;
    }
       
    public String getUsertype() {
        return usertype;
    }
    
    public boolean setUsertype(String usertype) {
        this.usertype = usertype;
        return this.usertype.equals(usertype);
    }
    
    public String getUserFirstName() {
        return userFirstName;
    }

    public boolean setUserFirstName(String userFirstName) {
        this.userFirstName = userFirstName;
        return this.userFirstName.equals(userFirstName);
    }

    public String getUserLastName() {
        return userLastName;
    }

    //getter and setter in class
    public boolean setUserLastName(String userLastName) {
        this.userLastName = userLastName;
        return this.userLastName.equals(userLastName);
    }

    public String getUsername() {
        return username;
    }

    public boolean setUsername(String username) {
        this.username = username;
        return this.username.equals(username);
    }

    public String getPassword() {
        return password;
    }

    public boolean setPassword(String password) {
        this.password = password;
        return this.password.equals(password);
    }

    public String getEmail() {
        return email;
    }

    public boolean setEmail(String email) {
        this.email = email;
        return this.email.equals(email);
    }

    public String getBirthday() {
        return birthday;
    }

    public boolean setBirthday(String birthday) {
        this.birthday = birthday;
        return this.birthday.equals(birthday);
    }

    public String getPhone() {
        return phone;
    }

    public boolean setPhone(String phone) {
        this.phone = phone;
        return this.phone.equals(phone);
    }
    
    public boolean setIsLogged(boolean logCondition) {
        this.isLogged = logCondition;
        return !this.isLogged != logCondition;
    }
    
    public boolean getIsLogged() {
        return this.isLogged;
    }
    
    public boolean setProfile(String firstName, String lastName, String mail, String birth, String phone) {
        
        if(!this.setUserFirstName(firstName)) return false;
        
        if(!this.setUserLastName(lastName)) return false;
        
        if(!this.setEmail(mail)) return false;
        
        if(!this.setBirthday(birth)) return false;
        
        if(!this.setPhone(phone)) return false;
        
        return true;
    }
        
    @Override
    public String toString() {
        return username + " " + password + " " + userFirstName + " " + userLastName + " " + email + " " + " " + birthday + " " + phone;
    }
}