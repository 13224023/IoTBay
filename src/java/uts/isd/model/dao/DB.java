/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.model.dao;


//import java.sql.Connection
import java.sql.Connection;

/**
 *
 * @author Administrator
 */
public abstract class DB {
    protected String url = "jdbc:derby://localhost:1527/";
    protected String db = "ISD";
    protected String dbUser = "root";
    protected String dbPassword = "root";
    protected String driver = "org.apache.derby.jdbc.ClientDriver";
    protected Connection connection;
    
    
    
}
