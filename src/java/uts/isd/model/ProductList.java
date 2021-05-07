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
public class ProductList {
    ArrayList<Product> productList;
    
    public ProductList() {
        productList = new ArrayList<>();
    }
    
    public int listSize() {
        return productList.size();
    }
    
    public void addProduct(Product product) {
        productList.add(product);
    }
    
    public Product getProductByIndex(int index) {
        return productList.get(index);
    }
    
    public void displayProducts() {
        if(listSize() == 0) {
            System.out.println("No records.");
            return;
        }
        for(int i = 0; i < listSize(); i++) {
            System.out.println(getProductByIndex(i));
        }
    
    }
}
