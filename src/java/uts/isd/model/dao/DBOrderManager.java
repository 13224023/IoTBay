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
public class DBOrderManager {
    private PreparedStatement preparedStmt;
    private Connection connection;
    private ResultSet resultSet;
    
    public DBOrderManager(Connection connection) throws SQLException {       
          this.connection = connection;
          this.preparedStmt = null;
          this.resultSet = null;
    }
    
}
