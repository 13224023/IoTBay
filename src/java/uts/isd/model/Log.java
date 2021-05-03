/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.model;
import java.sql.*;
/**
 *
 * @author Administrator
 */
public class Log {
    final String username;
    final String type;
    final private Date date;
    final private Time time;
    
    
    public Log(String username, String type, Date date, Time time) {
        this.username = username;
        this.type = type;
        this.date = date;
        this.time = time;
        
    }
    
    public String getUsername() {
        return username;
    }
    public String getType() {
        return type;
    }
    public Date getDate() {
        return date;
    }
    public Time getTime() {
        return time;
    }
    
        
    public boolean isDateMatchByDate(String month, String days) {
        
        Date now = new Date(System.currentTimeMillis());
                
        Date comparedDate = new Date(now.getYear(), Integer.parseInt(month) - 1, Integer.parseInt(days));
        
        System.out.println(comparedDate);
               
        return comparedDate.compareTo(getDate()) == 0;
        
    }
    
    public String displayLogWithoutUsername() {
        return type + " " + date + " " + time;
    }
    
    
    @Override
    public String toString() {
        return username + " " + type + " " + date + " " + time;
    }
}
