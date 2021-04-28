/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.controller;

import java.util.*;
import java.util.logging.*;
import java.sql.*;
import uts.isd.model.*;
import uts.isd.model.dao.*;

/**
 *
 * @author Administrator
 */
public class TestDB {
    //Fields
    private static Scanner in = new Scanner(System.in);
    private DBConnector connector;
    private Connection connection;
    private DBManager dbManager;
    
    public TestDB() {
        try {
            connector = new DBConnector();
            connection = connector.getConnection();
            dbManager = new DBManager(connection);
        
        }catch(ClassNotFoundException | SQLException ex) {
            Logger.getLogger(TestDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public char readChoice() {
        System.out.print("Operation CRUDS or * to exit: ");
        return in.nextLine().charAt(0);
    }
    
    public void runQueries() throws SQLException {
        char c;
        
        
        while((c = readChoice()) != '*') {
            switch(c) {
                case 'C':
                    testAdd();
                    break;
                case 'R':
                    testRead();
                    break;
                case 'U':
                    testUpdate();
                    break;
                case 'D':
                    testDelete();
                    break;
                case 'S':
                    showAll();
                    break;
                default:
                    System.out.println("Unknown command");
                    break;
            }
        
        
        
        }
    
    }
    //test addUser(String username, String password,  String usertype)
    private void testAdd() {
        System.out.print("Username: ");
        String username = in.nextLine();
        System.out.print("Userpassword: ");
        String password = in.nextLine();
        System.out.print("Usertype: ");
        String usertype = in.nextLine();
        
        try {
            dbManager.addUser(username, password, usertype);
        }catch(SQLException ex) {
            Logger.getLogger(TestDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println("User is added into database.");
        
    }
    
    //test findUser(String username, String password) 
    private void testRead() throws SQLException {
        System.out.print("Username: ");
        String username = in.nextLine();
        System.out.print("Userpassword: ");
        String password = in.nextLine();
        User user = dbManager.findUser(username, password);
        if(user != null) {
            System.out.println("User " + user.getUsername() + " exists in database.");
        }else {
            System.out.println("User " + username + " does not exist in database.");
        }
        
    }
    
    //check checkUser(), 
    //updateUserProfile(String username, String password, 
    //        String firstname, String lastname, String email, String birthday, 
    //        String phone), 
    //updatePassword(String username, 
    //       String newpassword)
    private void testUpdate() {
        System.out.print("Username: ");
        String username = in.nextLine();
        System.out.print("Userpassword: ");
        String password = in.nextLine();
        
        try {
            if(dbManager.checkUser(username, password)) {
                //test update user profile
                System.out.print("Firstname: ");
                String firstname = in.nextLine();
                System.out.print("Lastname: ");
                String lastname = in.nextLine();
                System.out.print("Emal: ");
                String email = in.nextLine();
                System.out.print("Birthday: ");
                String birthday = in.nextLine();
                System.out.print("Phone: ");
                String phone = in.nextLine();
                dbManager.updateUserProfile(username, password, firstname, lastname, email, birthday, phone);
                System.out.println("User " + username + " profile is updated.");
                
                //test change password
                System.out.print("User new password: ");
                String newPassword = in.nextLine();
                dbManager.updateUserPassword(username, newPassword);
                System.out.println("User " + username + " password is updated.");
                
                
            }else {
                System.out.println("User " + username + " does not exist in database.");
            }
            //dbManager.addUser(username, password, usertype);
        }catch(SQLException ex) {
            Logger.getLogger(TestDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    //deleteUser(String username)
    private void testDelete() {
        System.out.print("Username: ");
        String username = in.nextLine();
        System.out.print("Userpassword: ");
        String password = in.nextLine();
        
        try {
            if(dbManager.checkUser(username, password)) {
                //test update user profile
                dbManager.deleteUser(username);
                System.out.println("User " + username + " is removed from database.");
            }else {
                System.out.println("User " + username + " does not exist in database.");
            }
        }catch(SQLException ex) {
            Logger.getLogger(TestDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    
    }
    
    private void showAll() {
        try {
            UserAccount accountList = dbManager.getAllUsers();
            accountList.showAllUsers();
        }catch(SQLException ex) {
            Logger.getLogger(TestDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    public static void main(String [] args) throws SQLException {
        new TestDB().runQueries();
    }
}

