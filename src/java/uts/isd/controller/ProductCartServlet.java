/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uts.isd.model.Product;
import uts.isd.model.ProductList;
import uts.isd.model.User;

/**
 *
 * @author Administrator
 */
public class ProductCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //retrieve the current session
        HttpSession session = request.getSession();
        
        User user = (User)session.getAttribute("user");
        String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
        if(user == null) {
            response.sendRedirect(redirectURL);
        }
        
        Validator validator = new Validator();
        validator.clean(session);
        String number = request.getParameter("quantity");
        int orderNumber = 0;
        int index = Integer.parseInt(request.getParameter("add"));
        ProductList availableProductList = (ProductList) session.getAttribute("availableProductList");
        Product selectedProduct = availableProductList.getProductByIndex(index);
        if(!validator.validateProductNumber(number)) {
            //set incorrect password different error to the session
            session.setAttribute("productStockErr", "Error: Order number format incorrect");
        }else {
            orderNumber = Integer.parseInt(number);
            if(orderNumber < 0 || orderNumber > selectedProduct.getStock()) {
                //set incorrect password different error to the session
                session.setAttribute("productStockErr", "Error: Order number out of stock");
                
            }else {
                //System.out.println("index: " + index);
                int productNo;
                //DBProductManager productManager = (DBProductManager) session.getAttribute("productManager");
                ProductList cartProductList = (ProductList) session.getAttribute("cartProductList");
                if(cartProductList == null) cartProductList = new ProductList();
                productNo = selectedProduct.getProductNo();
                String pName = selectedProduct.getName();
                String pType = selectedProduct.getType();
                int price = selectedProduct.getPrice();

                if(cartProductList.isProductInList(productNo)) {
                    System.out.println("product exists cart");
                    cartProductList.updateSoldNumber(productNo, orderNumber);
                    availableProductList.setRemainStock(productNo, orderNumber);
                    System.out.println("Cart list:");
                    cartProductList.displayProducts();
                    System.out.println("Avaialable list");
                    availableProductList.displayProducts();
                }else {
                    System.out.println("product does not exist cart");
                    //selectedProduct.setStock(orderNumber);
                    Product newProduct = new Product(productNo, pName, pType, price, orderNumber);
                    //System.out.println(selectedProduct);
                    cartProductList.addProduct(newProduct);
                    System.out.println("Cart list:");
                    cartProductList.displayProducts();
                    //update the stock in available stock in productlist
                    availableProductList.setRemainStock(productNo, orderNumber);
                    System.out.println("Avaialable list");
                    availableProductList.displayProducts();
                }
                //store information into session
                session.setAttribute("successInfo", "Product is added into cart");
                session.setAttribute("availableProductList", availableProductList);
                session.setAttribute("cartProductList", cartProductList);
            }
        
        }
        
        //redirect user to the welcom.jsp
        request.getRequestDispatcher("welcome.jsp").include(request, response);
    }
}