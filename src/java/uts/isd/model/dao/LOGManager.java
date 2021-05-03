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
public class LOGManager {
    private PreparedStatement preparedStmt;
    private Connection connection;
    private ResultSet resultSet;
    
    public LOGManager(Connection connection) throws SQLException {       
          this.connection = connection;
          this.preparedStmt = null;
          this.resultSet = null;
    }
    
    public void addLog(String username, String type) throws SQLException {
        
        String queryGetLine = "SELECT COUNT(*) FROM ROOT.LOGS";
        this.preparedStmt = connection.prepareStatement(queryGetLine);
        resultSet = preparedStmt.executeQuery();
        int number = 0;
        if(resultSet.next()) {
            number = resultSet.getInt(1) + 1;
        } 
        preparedStmt.close();
        resultSet.close();
        
        String query = "INSERT INTO ROOT.LOGS " + 
            "(NUMBER,USERNAME,DATE,TIME,TYPE) " +
            " VALUES(?,?,?,?,?)";
        this.preparedStmt = connection.prepareStatement(query);
        long now = System.currentTimeMillis();
        Date date = new Date(now);
        Time time = new Time(now);
        this.preparedStmt.setInt(1, number);
        this.preparedStmt.setString(2, username);
        this.preparedStmt.setDate(3, date);
        this.preparedStmt.setTime(4, time);
        this.preparedStmt.setString(5, type);
                
        //Execute the query, then return a value for storing successfully
        int row = preparedStmt.executeUpdate();
        preparedStmt.close();
        
    }
    
    public LogList getLogsByUsername(String username) throws SQLException {
        String fetch = "SELECT DATE,TIME,TYPE FROM ROOT.LOGS " + 
                "WHERE USERNAME=?";
        this.preparedStmt = connection.prepareStatement(fetch);
        this.preparedStmt.setString(1, username);
        resultSet = preparedStmt.executeQuery();
        
        LogList logList = new LogList();
        
        while(resultSet.next()) {
            String type = resultSet.getString("TYPE");
            Date date = resultSet.getDate("DATE");
            Time time = resultSet.getTime("TIME");
            logList.addLog(new Log(username, type, date, time));
        }
        resultSet.close();
        return logList;
    }
    
    public LogList getLogsByNameAndDate(String username, String month,
            String day) throws SQLException {
        LogList filterList = getLogsByUsername(username).getListByDate(month, day);
        return  filterList;
    }
    
    public LogList getAllLogsByDate(String month,
            String day) throws SQLException  {
    
        LogList filterList = getAllLogs().getListByDate(month, day);
        return  filterList;
    }
    
    public LogList getAllLogs() throws SQLException {
        String fetch = "SELECT USERNAME,TYPE,DATE,TIME FROM ROOT.LOGS ";
        this.preparedStmt = connection.prepareStatement(fetch);
        resultSet = preparedStmt.executeQuery();
        
        LogList logList = new LogList();
        
        while(resultSet.next()) {
            String username = resultSet.getString(1);
            String type = resultSet.getString(2);
            Date date = resultSet.getDate(3);
            Time time = resultSet.getTime(4);
            logList.addLog(new Log(username, type, date, time));
        }
        resultSet.close();
        return logList;
    }
    
    
    
    
}
