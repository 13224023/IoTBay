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
import uts.isd.model.dao.LOGManager;
 
/*
The loginServlet controler captures the posted data from the form of login jsp
and validate the user logining-credentials by using validate class in uts.isd.controller
that contains validation patterns
*/ 
public class LoginServlet extends HttpServlet {
    @Override   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       
        //retrieve the current session
        HttpSession session = request.getSession();
        //create an instance of the Validator class    
        Validator validator = new Validator();
        //capture the posted email
        String username = request.getParameter("uname");
        //capture the posted password
        String password = request.getParameter("upassword");    
        //retrieve the manager instance from session
        DBManager manager = (DBManager) session.getAttribute("manager");
        LOGManager logManager = (LOGManager) session.getAttribute("logManager");
        //initialise the error message
        validator.clean(session);
        //Declare a user with value of null
        User user = null;
       
        if (!validator.validateUsername(username)) {           
            //set incorrect email error to the session
            session.setAttribute("usernameErr", "Error: Username format incorrect");
            //redirect user back to the login.jsp
            request.getRequestDispatcher("login.jsp").include(request, response);
        } else if (!validator.validatePassword(password)) {                  
            //set incorrect password error to the session
            session.setAttribute("passErr", "Error: Password format incorrect");

            //redirect user back to the login.jsp
            request.getRequestDispatcher("login.jsp").include(request, response);
        } else {
            try {
                //find user by email and password
                user = manager.findUser(username, password);
                if(user != null) {
                    //save the logged in user object to the session 
                    session.setAttribute("user", user);
                    //store log into database
                    logManager.addLog(username,"login");
                    
                    //redirect user to the welcom.jsp
                    request.getRequestDispatcher("welcome.jsp").include(request, response);
                }else {
                    //set user does not exist error to the session 
                    session.setAttribute("existErr", "Username or password is incorrect");
                    //redirect user back to the login.jsp  
                    request.getRequestDispatcher("login.jsp").include(request, response);
                }
            } catch (SQLException ex) {           
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);       
            }
        }
    } 
}