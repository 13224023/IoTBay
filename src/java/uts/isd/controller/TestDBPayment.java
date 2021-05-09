/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.controller;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import uts.isd.model.PaymentList;
import uts.isd.model.dao.DBConnector;
import uts.isd.model.dao.DBPaymentManager;

/**
 *
 * @author Administrator
 */
public class TestDBPayment {
    private static Scanner in = new Scanner(System.in);
    private DBConnector connector;
    private Connection connection;
    private DBPaymentManager paymentManager;
    
    public TestDBPayment() throws SQLException {
        try {
            connector = new DBConnector();
            connection = connector.getConnection();
            paymentManager = new DBPaymentManager(connection);
        
        }catch(ClassNotFoundException | SQLException ex) {
            Logger.getLogger(TestDBPayment.class.getName()).log(Level.SEVERE, null, ex);
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
                /*
                case 'F':
                    testFilter();
                    break;
                */
                case 'S':
                    showAll();
                    break;
                    
                default:
                    System.out.println("Unknown command");
                    break;
            }
        }
    }
    
    private void testAdd() {
        System.out.print("PaymentID: ");
        int paymentID = Integer.parseInt(in.nextLine());
                      
        System.out.print("Username: ");
        String username = in.nextLine();
        
        System.out.print("Payment Type: ");
        String type = in.nextLine();
        
        System.out.print("Payment number: ");
        int number = Integer.parseInt(in.nextLine());
                
        paymentManager.addPayment(paymentID, username, type, number);
        System.out.println("A payment is added into database.");
        
        
    }
    
    private void testRead() throws SQLException {
        System.out.print("Username : ");
        String username = in.nextLine();
        PaymentList paymentList = paymentManager.getPaymentByUsername(username);
        paymentList.displayPaymentList();
    }
    
    private void testUpdate() {
        System.out.print("Payment ID: ");
        int paymentNo = Integer.parseInt(in.nextLine());
        System.out.print("Payment type: ");
        String type = in.nextLine();
        System.out.print("Payment number: ");
        int paymentNumber = Integer.parseInt(in.nextLine());
        try {
            if(paymentManager.findPayment(paymentNo)) {
                paymentManager.updatePayment(paymentNo, type, paymentNumber);
                System.out.println("Payment detail is updated.");
            }else {
                System.out.println("Payment does not exist in database.");
            }
        }catch(SQLException ex) {
            Logger.getLogger(TestDBPayment.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void testDelete() {
        System.out.print("Payment ID: ");
        int paymentID = Integer.parseInt(in.nextLine());
        
        try {
            if(paymentManager.findPayment(paymentID)) {
                //test update user profile
                paymentManager.deletePayment(paymentID);
                System.out.println("payment ID is removed from database.");
            }else {
                System.out.println("payment ID does not exist in database.");
            }
        }catch(SQLException ex) {
            Logger.getLogger(TestDBPayment.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    private void showAll() {
        try {
            PaymentList productList = paymentManager.getAllRecords();
            productList.displayPaymentList();
        }catch(SQLException ex) {
            Logger.getLogger(TestDBPayment.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
}
