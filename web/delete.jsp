<%-- 
    Document   : delete
    Created on : 27/04/2021, 5:57:48 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<%--//STEP 1. Import required packages --%>
<%@page import="java.sql.*"%>
<%@page import="uts.isd.model.dao.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Page</title>
    </head>
    <body>
        <%
            User user = (User)session.getAttribute("user");
            
            boolean isUserNull = user == null? true: false;
            boolean isIllegalUser = false;
            String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            
                    
            
            if(!isUserNull && user.getUsertype().equals("2")) {
                String username = user.getUsername();
                DBConnector connector = new DBConnector();
                DBManager dbManager = new DBManager(connector.getConnection());
                dbManager.deleteUser(username);
                connector.closeConnection();
                session.invalidate();
            }else {
                isIllegalUser = true;
            }
            
            if(isUserNull || isIllegalUser) {
                response.sendRedirect(redirectURL);
            }else {%>
                <h1>Delete Page</h1>
                <h2>Your account has been deleted. </h2>
                <button onclick="location.href='http://localhost:8080/IOTBay/'" class="button">Back to homepage</button>
        <%}%>
    </body>
</html>
