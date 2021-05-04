/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Administrator
 */
public class LogManager {
    private PreparedStatement preparedStmt;
    private Connection connection;
    private ResultSet resultSet;
    
    public LogManager(Connection connection) throws SQLException {       
        this.connection = connection;
        this.preparedStmt = null;
        this.resultSet = null;
    }
    
    public void addLog(String username) throws SQLException {
        //String query0 = "SELECT COUNT(*) AS COUNT FROM ROOT."
        //String query = "INSERT INTO USERS " + 
        //"(LOGID,USERNAME,DATE) " +
        //" VALUES(?,?,?)";
        
        //this.preparedStmt = connection.prepareStatement(query);
        //Execute the query, then return a value for storing successfully
        //int row = preparedStmt.executeUpdate();
    }
    
    
}
