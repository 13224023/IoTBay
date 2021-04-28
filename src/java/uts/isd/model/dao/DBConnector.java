/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.model.dao;

import java.sql.*;
/**
 *
 * @author Administrator
 */
public class DBConnector extends DB {
    //
    public DBConnector() throws ClassNotFoundException, SQLException {
        Class.forName(driver);
        connection = DriverManager.getConnection(url + db, dbUser, dbPassword);
    }
    
    public Connection getConnection() {
        return this.connection;
    }
    
    public void closeConnection() throws SQLException {
        this.connection.close();
    }
}
