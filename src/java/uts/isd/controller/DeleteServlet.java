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
import uts.isd.model.dao.DBManager;

/**
 *
 * @author Administrator
 */
public class DeleteServlet extends HttpServlet {
    @Override   
    protected void doPost(HttpServletRequest request, 
            HttpServletResponse response) throws ServletException, IOException {
        //retrieve the current session
        HttpSession session = request.getSession();
        
        //Get user from session
        User user = (User) session.getAttribute("user");
        String username = request.getParameter("delete");
                
        String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
        if(user == null || !user.getUsertype().equals("0")) {
            response.sendRedirect(redirectURL);
        }
        
        //retrieve the manager instance from session
        DBManager manager = (DBManager) session.getAttribute("manager");
        
        try {
                User getUser = manager.findUserByUserName(username);
                if(getUser != null) manager.deleteUser(username);
                session.setAttribute("accountList", manager.getAllUsersWithoutRoot());
                request.getRequestDispatcher("accountlist.jsp").include(request, response);
        } catch (SQLException ex) {           
                Logger.getLogger(DeleteServlet.class.getName()).log(Level.SEVERE, null, ex);       
        }
        
    }
}
