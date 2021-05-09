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
import uts.isd.model.User;
import uts.isd.model.dao.DBCartManager;

/**
 *
 * @author Administrator
 */
public class WelcomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //retrieve the current session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        //create an instance of the Validator class    
        Validator validator = new Validator();
        
        //initialise the error message
        validator.clean(session);
        
        
        if(user.getUsertype().equals("2")) {
            DBCartManager cartManager = (DBCartManager) session.getAttribute("cartManager");
            try {
                session.setAttribute("cartProductList", cartManager.getCartProductByUsername(user.getUsername()));
            } catch (SQLException ex) {
                Logger.getLogger(WelcomeController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } 
        
        request.getRequestDispatcher("welcome.jsp").include(request, response);
    } 
}
