/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.model.dao;

import uts.isd.model.*;
import java.sql.*;
/**
 *
 * @author Administrator
 */
public class DBManager {
    private PreparedStatement preparedStmt;
    private Connection connection;
    private ResultSet resultSet;
    
    public DBManager(Connection connection) throws SQLException {       
          this.connection = connection;
          this.preparedStmt = null;
          this.resultSet = null;
    }
    
    //find the specific user by username and password
    public User findUser(String username, String password) throws SQLException {
        String fetch = "SELECT * FROM ROOT.USERS " +
            "WHERE USERNAME = ? AND PASSWORD = ?";
        this.preparedStmt = connection.prepareStatement(fetch);
        this.preparedStmt.setString(1, username);
        this.preparedStmt.setString(2, password);
        resultSet = preparedStmt.executeQuery();
        
        while(resultSet.next()) {
            String userName = resultSet.getString(1);
            String userPassword = resultSet.getString(2);
            if(userName.equals(username) && userPassword.equals(password))
                return new User(userName, userPassword, 
                        resultSet.getString(3), 
                        resultSet.getString(4),  
                        resultSet.getString(5), 
                        resultSet.getString(6), 
                        resultSet.getString(7), 
                        resultSet.getString(8));
        }
        resultSet.close();
        return null;
    }
    
    public UserAccount getAllUsers() throws SQLException{
        String fetch = "SELECT * FROM ROOT.USERS";
        this.preparedStmt = connection.prepareStatement(fetch);
        resultSet = preparedStmt.executeQuery();
        UserAccount accountList = new UserAccount();
        
        while(resultSet.next()) {
            
            accountList.setAnUser(new User(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3), 
                        resultSet.getString(4),  
                        resultSet.getString(5), 
                        resultSet.getString(6), 
                        resultSet.getString(7), 
                        resultSet.getString(8)));
        }
        resultSet.close();
        return accountList;
    }
    
    public UserAccount getAllUsersByUsertype(String usertype) throws SQLException {
        String fetch = "SELECT * FROM ROOT.USERS";
        resultSet = preparedStmt.executeQuery();
        UserAccount accountList = new UserAccount();
        
        while(resultSet.next()) {
            if(resultSet.getString(3).equals(usertype)) {
                accountList.setAnUser(
                    new User(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3), 
                        resultSet.getString(4),  
                        resultSet.getString(5), 
                        resultSet.getString(6), 
                        resultSet.getString(7), 
                        resultSet.getString(8))
                );
            }
            
        }
        //resultSet.close();
        return accountList;
    
    }
       
    
    public void addUser(String username, String password,
            String usertype) throws SQLException {
        String query = "INSERT INTO USERS " + 
            "(USERNAME,PASSWORD,USERTYPE,FIRSTNAME,LASTNAME,PHONE,EMAIL,DOB) " +
            " VALUES(?,?,?,'','','','','')";
        this.preparedStmt = connection.prepareStatement(query);
        this.preparedStmt.setString(1, username);
        this.preparedStmt.setString(2, password);
        this.preparedStmt.setString(3, usertype);
        
        //Execute the query, then return a value for storing successfully
        int row = preparedStmt.executeUpdate();
        
    }
    
    public void updateUserProfile(String username, String password, 
            String firstname, String lastname, String email, String birthday, 
            String phone) throws SQLException {
        String query = "UPDATE ROOT.USERS SET " + 
            "FIRSTNAME = ?, LASTNAME = ?, EMAIL = ?, DOB = ?, PHONE = ? " + 
            "WHERE USERNAME = ? AND PASSWORD = ?";
        //Store values into each column
        preparedStmt = connection.prepareStatement(query);
        preparedStmt.setString(1, firstname);
        preparedStmt.setString(2, lastname);
        preparedStmt.setString(3, email);
        preparedStmt.setString(4, birthday);
        preparedStmt.setString(5, phone);
        preparedStmt.setString(6, username);
        preparedStmt.setString(7, password);
        
        //Execute the query and get a reponse from database
        preparedStmt.executeUpdate();
    }
    
    public void updateUserPassword(String username, 
            String newpassword) throws SQLException {
        String query = "UPDATE ROOT.USERS SET " + 
            "PASSWORD = ? " + 
            "WHERE USERNAME = ?";
        //Store values into each column
        preparedStmt = connection.prepareStatement(query);
        preparedStmt.setString(1, newpassword);
        preparedStmt.setString(2, username);
       
        
        //Execute the query and get a reponse from database
        preparedStmt.executeUpdate();
    }
    
    public void deleteUser(String username) throws SQLException {
        String query = "DELETE FROM USERS WHERE USERNAME = ?";
        preparedStmt = connection.prepareStatement(query);
        preparedStmt.setString(1, username);
        //Execute the query, then return a value for storing successfully
        int row = preparedStmt.executeUpdate();
        resultSet.close();
        
    }
    
    public boolean checkUser(String username, 
            String password)throws SQLException {
        String fetch = "SELECT * FROM ROOT.USERS " +
            "WHERE USERNAME = ? AND PASSWORD = ?";
        this.preparedStmt = connection.prepareStatement(fetch);
        this.preparedStmt.setString(1, username);
        this.preparedStmt.setString(2, password);
        resultSet = preparedStmt.executeQuery();
        
        while(resultSet.next()) {
            String userName = resultSet.getString(1);
            String userPassword = resultSet.getString(2);
            if(userName.equals(username) && userPassword.equals(password))
                return true;
        }
        resultSet.close();
        return false;
    }
    
}
