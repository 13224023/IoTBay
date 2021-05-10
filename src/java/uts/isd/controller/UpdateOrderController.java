/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uts.isd.model.ProductList;
import uts.isd.model.User;
import uts.isd.model.dao.DBOrderlineManager;

/**
 *
 * @author Administrator
 */
public class UpdateOrderController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //retrieve the current session
        HttpSession session = request.getSession();
        
        User user = (User)session.getAttribute("user");
        String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
        if(user == null || !user.getUsertype().equals("2")) {
            response.sendRedirect(redirectURL);
        }
        //create an instance of the Validator class    
        Validator validator = new Validator();
        
        //initialise the error message
        validator.clean(session);
        String update = request.getParameter("update");
        int orderID = Integer.parseInt(update);
        
        DBOrderlineManager orderlineManager = (DBOrderlineManager) session.getAttribute("orderlineManager");
        
        try {
            ProductList orderProductList = orderlineManager.getProductsByOrderID(orderID);
            session.setAttribute("orderProductList", orderProductList);
            session.setAttribute("orderID", update);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateOrderController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        //redirect user to the welcom.jsp
        request.getRequestDispatcher("orderline.jsp").include(request, response);
        
        
    }
    
}
