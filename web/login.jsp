<%-- 
    Document   : login
    Created on : 
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<%@page import="uts.isd.model.dao.*"%>
<%--//STEP 1. Import required packages --%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/login.css">
        <title>Login Page</title>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            String redirectURL = "http://localhost:8080/IOTBay/welcome.jsp";
            
            boolean isUserNull = user == null? true : false;
            boolean isLoginButtonClicked = request.getParameter("login") != null? true : false;
            boolean loginSuccessful = false;
            boolean isAccountLocked = false;
            if(!isUserNull) {
                response.sendRedirect(redirectURL);
            }else {
                if(isLoginButtonClicked) {
                    String username = request.getParameter("uname");
                    String password = request.getParameter("upassword");
                    
                    DBConnector connector = new DBConnector();
                    DBManager dbManager = new DBManager(connector.getConnection());
                    User matchedUser = dbManager.findUser(username, password);
                    if(matchedUser != null) {
                        if(matchedUser.getStatus().equals("1")) {
                            loginSuccessful = true;
                            session.setAttribute("user", matchedUser);
                            response.sendRedirect(redirectURL);
                        }else {
                            isAccountLocked = true;
                        }
                        
                    } 
                }
            }
            
        %>
       
        
        <form class="box" action="login.jsp" method="get" id="login">
            <h1>Login</h1>
            <input type="text" id="uname" name="uname" autocomplete="off" placeholder="Username" required>
            <input type="password" id="upassword" name="upassword" autocomplete="off" placeholder="Password" required>
            <input type="submit" form="login" name="login" value="Login">
            <input type="button" value="Back" onclick="location.href='http://localhost:8080/IOTBay/'">
            <p> Not a Customer? <a href="register.jsp">Register</a></p>
            <p class="errorinfo"><%= isLoginButtonClicked? loginSuccessful? "": isAccountLocked? "Your Account is Locked": "Invalid password. Please try again" :"" %></p>
        </form>
        
    </body>
</html>
