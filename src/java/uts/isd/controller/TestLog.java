/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.controller;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.*;
import java.util.Scanner;
import uts.isd.model.LogList;
import uts.isd.model.dao.DBConnector;
import uts.isd.model.dao.LOGManager;


/**
 *
 * @author Administrator
 */
public class TestLog {
    private static Scanner in = new Scanner(System.in);
    private DBConnector connector;
    private Connection connection;
    private LOGManager LogManager;
    
    public TestLog() throws SQLException {
        try {
            connector = new DBConnector();
            connection = connector.getConnection();
            LogManager = new LOGManager(connection);
        
        }catch(ClassNotFoundException | SQLException ex) {
            Logger.getLogger(TestDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public char readChoice() {
        System.out.print("Operation CRFS or * to exit: ");
        return in.nextLine().charAt(0);
    }
    
    private void testAdd() {
        System.out.print("Username: ");
        String username = in.nextLine();
        Date date = new Date(System.currentTimeMillis());
              
        System.out.print("LogType: login or logout ");
        String type = in.nextLine();
        
        try {
            LogManager.addLog(username, type);
        }catch(SQLException ex) {
            Logger.getLogger(TestDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println("New log is added into database.");
        
    }
    
    private void testRead() throws SQLException {
        System.out.print("Username: ");
        String username = in.nextLine();
        
        LogList logList = LogManager.getLogsByUsername(username);
                
        logList.displayLogs();
    }
    
    private void testFilter() throws SQLException {
        System.out.print("Username: ");
        String username = in.nextLine();
        System.out.print("Month: ");
        String month = in.nextLine();
        System.out.print("Days: ");
        String days = in.nextLine();
        LogList logList = LogManager.getLogsByNameAndDate(username, month, days);
        logList.displayLogs();
                
    
    }
    
    private void showAll() {
        try {
            LogList logList = LogManager.getAllLogs();
            logList.displayLogs();
        }catch(SQLException ex) {
            Logger.getLogger(TestDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        
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
                case 'F':
                    testFilter();
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
    
    public static void main(String [] args) throws SQLException {
        new TestLog().runQueries();
    }
}
