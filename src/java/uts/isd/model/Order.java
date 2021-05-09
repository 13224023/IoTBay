/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.model;

import java.sql.Date;

/**
 *
 * @author Administrator
 */
public class Order {
    private int orderID;
    private String username;
    private Date orderDate;
    private int status;
    private String paymentType;
    private String paymentNumber;
    private Date paymentDate;
    private int amount;
    
    public Order() {
        orderID = -1;
        username = "None";
        orderDate = new Date(System.currentTimeMillis());
        status = -1;
        paymentType = "None";
        paymentNumber = "None";
        paymentDate = new Date(System.currentTimeMillis());
        amount = 0;
    }
    
    public Order(int orderID, String username, Date orderDate, int status, int amount) {
        this.orderID = orderID;
        this.username = username;
        this.orderDate = orderDate;
        this.status = status;
        this.amount = amount;
    }

    public Order(int orderID, String username, Date orderDate, int status, String paymentType, String paymentNumber, Date paymentDate, int amount) {
        this.orderID = orderID;
        this.username = username;
        this.orderDate = orderDate;
        this.status = status;
        this.paymentType = paymentType;
        this.paymentNumber = paymentNumber;
        this.paymentDate = paymentDate;
        this.amount = amount;
    }

    public int getOrderID() {
        return orderID;
    }

    public String getUsername() {
        return username;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public int getStatus() {
        return status;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public String getPaymentNumber() {
        return paymentNumber;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public int getAmount() {
        return amount;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public void setPaymentNumber(String paymentNumber) {
        this.paymentNumber = paymentNumber;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    @Override
    public String toString() {
        return "" + this.orderID + " " +
        this.username + " " +
        this.orderDate + " " +
        this.status + " " +
        this.paymentType + " " +
        this.paymentNumber + " " +
        this.paymentDate + " " +
        this.amount;
    }
}
