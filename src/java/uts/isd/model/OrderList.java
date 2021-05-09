/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.model;

import java.util.ArrayList;

/**
 *
 * @author Administrator
 */
public class OrderList {
    private ArrayList<Order> orderList;

    
    public OrderList() {
        this.orderList = new ArrayList<Order>();
    }
    public OrderList(ArrayList<Order> orderList) {
        this.orderList = orderList;
    }
    
    public void addOrder(Order newOrder) {
        this.orderList.add(newOrder);
    }
    
    
    public void displayOrders() {
        for(Order each: orderList) {
            System.out.println(each);
        }
    }
    
}
