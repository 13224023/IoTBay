/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.model;
import java.sql.*;
import java.util.ArrayList;
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
    public int getMonth() {
        return date.getMonth();
    }
    
    
    private int getMonthDays(int month) {
        switch(month) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                return 31;
            case 2:
                return 28;
            case 4:
            case 6:
            case 9:
            case 11:
                return 30;
            default:
                return 0;
        }
    
    }
    
    
    
    private boolean isMonthIntegerable(String month) {
        try {
            int number = Integer.parseInt(month);
            if(number > 0 && number <= 12)
                return true;
            return false;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    private boolean isDayIntegerable(String days) {
        try {
            int number = Integer.parseInt(days);
            if(number > 0 && number <= 31)
                return true;
            return false;
        } catch (NumberFormatException e) {
            return false;
        }
    }
            
    public boolean isDateMatchByDate(String month, String days) {
        
        Date now = new Date(System.currentTimeMillis());
        int year = now.getYear();
        int numberOfMonth = isMonthIntegerable(month)? Integer.parseInt(month): 0;   
        int numberOfDays = isDayIntegerable(days)? Integer.parseInt(days): 0; 
        
        if(numberOfMonth != 0 && numberOfDays != 0) {
            Date comparedDate = new Date(now.getYear(), numberOfMonth - 1, numberOfDays);
            return comparedDate.compareTo(getDate()) == 0;
        }
        if(numberOfMonth != 0 && numberOfDays == 0) {
            Date startDate = new Date(year , numberOfMonth - 1 , 1);
            Date endDate = new Date(year , numberOfMonth - 1, getMonthDays(numberOfMonth));
            return this.date.compareTo(startDate) >= 0 && this.date.compareTo(endDate) <= 0;
        }
        
        if(numberOfMonth == 0 && numberOfDays != 0) {
            ArrayList<Date> dateList = new ArrayList<Date>();
            for(int i = 1; i <= 12; i++) {
                dateList.add(new Date(now.getYear(), i - 1, numberOfDays));
            }
            for(int i = 0; i < 12; i++) {
                if(dateList.get(i).compareTo(this.date) == 0)
                    return true;
            }
            return false;
        }    
        return true;
    }
    
    public String displayLogWithoutUsername() {
        return type + " " + date + " " + time;
    }
    
    
    @Override
    public String toString() {
        return username + " " + type + " " + date + " " + time;
    }
}
