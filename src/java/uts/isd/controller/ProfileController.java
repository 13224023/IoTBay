/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uts.isd.model.User;
import uts.isd.model.dao.DBManager;
import uts.isd.model.dao.LOGManager;

/**
 *
 * @author Administrator
 */
public class ProfileController extends HttpServlet{
    @Override   
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       
        //retrieve the current session
        HttpSession session = request.getSession();
        //capture the posted username
        //String encodedUsername = request.getParameter("username");
        //byte[] decodedUsernameBytes = Base64.getDecoder().decode(encodedUsername);
        //String username = new String(decodedUsernameBytes);
        
        //capture the posted password
        //String encodedPassword = request.getParameter("password");
        //byte[] decodedPasswordBytes = Base64.getDecoder().decode(encodedPassword);
        //String password = new String(decodedPasswordBytes);
        //retrieve the manager instance from session
        User user = (User) session.getAttribute("user");
        String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
        if(user == null) {
            response.sendRedirect(redirectURL);
        }
        request.getRequestDispatcher("profile.jsp").include(request, response);
        //String username = user.getUsername();
        //String password = user.getPassword();
        
        //DBManager manager = (DBManager) session.getAttribute("manager");
        
        //Declare a user with value of null
        //User user = null;
        //try {
            //find user by email and password
            //user = manager.findUser(username, password);
            //if(user != null) {
                //save the logged in user object to the session 
                //session.setAttribute("user", user);
                                                        
                //redirect user to the profile.jsp
                //request.getRequestDispatcher("profile.jsp").include(request, response);
            //}else {
                //System.out.println("The user is not in database");
                //redirect user back to the profile.jsp  
                //request.getRequestDispatcher("profile.jsp").include(request, response);
            //}
        //} catch (SQLException ex) {           
            //Logger.getLogger(ProfileServlet.class.getName()).log(Level.SEVERE, null, ex);       
        //}
        
    } 
}
