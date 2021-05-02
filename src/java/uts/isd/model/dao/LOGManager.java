/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.model.dao;
import uts.isd.model.*;
import java.sql.*;
import java.text.SimpleDateFormat;

/**
 *
 * @author Administrator
 */
public class LOGManager {
    private PreparedStatement preparedStmt;
    private Connection connection;
    private ResultSet resultSet;
    
    public LOGManager(Connection connection) throws SQLException {       
          this.connection = connection;
          this.preparedStmt = null;
          this.resultSet = null;
    }
    
    public void addLog(String username) throws SQLException {
        
        String queryGetLine = "SELECT COUNT(*) FROM ROOT.LOGS";
        this.preparedStmt = connection.prepareStatement(queryGetLine);
        resultSet = preparedStmt.executeQuery();
        int number = 0;
        if(resultSet.next()) {
            number = resultSet.getInt(1) + 1;
        } 
        System.out.println(number);
        preparedStmt.close();
        resultSet.close();
        
        String query = "INSERT INTO ROOT.LOGS " + 
            "(NUMBER,USERNAME,DATE,TIME) " +
            " VALUES(?,?,?,?)";
        this.preparedStmt = connection.prepareStatement(query);
        long now = System.currentTimeMillis();
        Date date = new Date(now);
        Time time = new Time(now);
        this.preparedStmt.setInt(1, number);
        this.preparedStmt.setString(2, username);
        this.preparedStmt.setDate(3, date);
        this.preparedStmt.setTime(4, time);
                
        //Execute the query, then return a value for storing successfully
        int row = preparedStmt.executeUpdate();
        preparedStmt.close();
        
    }
    
    public void getLogsByUsername(String username) throws SQLException {
        String fetch = "SELECT DATE,TIME FROM ROOT.LOGS " + 
                "WHERE USERNAME=?";
        this.preparedStmt = connection.prepareStatement(fetch);
        this.preparedStmt.setString(1, username);
        resultSet = preparedStmt.executeQuery();
        
        int number = 1;
        while(resultSet.next()) {
            Date date = resultSet.getDate("DATE");
            Time time = resultSet.getTime("TIME");
            System.out.print("" + number + " " + username + " ");
            System.out.print(date);
            System.out.print(" ");
            System.out.print(time);
            
            
            //System.out.println(date);
            number++;
        }
        resultSet.close();
    
    }
    
}
