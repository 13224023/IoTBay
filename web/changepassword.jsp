<%-- 
    Document   : changepassword
    Created on : 02/04/2021, 10:11:04 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<%@page import="java.sql.*"%>
<%@page import="uts.isd.model.dao.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password Page</title>
        <link rel="stylesheet" href="CSS/changepassword.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    </head>
    <body>
        
    <%
                
        //Get data from the object
        User user = (User) session.getAttribute("user");
        
        String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
        
        //String change = request.getParameter("change");
        //String userName = user.getUsername();
        
        boolean isUserNull = user == null? true : false;
        boolean isChangeButtonClicked = request.getParameter("change") != null? true : false;
        
        boolean isPasswordsDifference = false;
        boolean isCurrentPasswordWrong = false;
        boolean isPasswordUpdated = false;
        
        if(isChangeButtonClicked) {
            String pPassword = request.getParameter("ppassword");
            String nPassword = request.getParameter("npassword"); 
            String cPassword = request.getParameter("cpassword");
            if(user.getPassword().equals(pPassword)) {
                if(nPassword.equals(cPassword)) {
                    String username = user.getUsername();
                    DBConnector connector = new DBConnector();
                    DBManager dbManager = new DBManager(connector.getConnection());
                    dbManager.updateUserPassword(username, nPassword);
                    //Update customer's current password
                    isPasswordUpdated = user.setPassword(nPassword);
                    //Update session
                    session.setAttribute("user", user);
                }else {
                    isPasswordsDifference = true;
                }
            }else {
                isCurrentPasswordWrong = true;
            } 
        }
    %>
    
    <%if(isUserNull) {
            response.sendRedirect(redirectURL);
    %>
    <%}else {%>
        <form class="box" action="changepassword.jsp" method="post" id="change">
            <h1>Password</h1>
            <input type="password" id="ppassword" name="ppassword" autocomplete="off" placeholder="Current Password" required>
            <input type="password" id="npassword" name="npassword" autocomplete="off" placeholder="New Password" required>
            <input type="password" id="cpassword" name="cpassword" autocomplete="off" placeholder="Confirm New Password" required>
            <input type="submit" form="change" name="change" value="Confirm">
            <input type="button" value="Back" onclick="location.href='http://localhost:8080/IOTBay/profile.jsp'">
            <%if(isChangeButtonClicked) {
                    if (isPasswordUpdated) {%>
                        <p class="successinfo">Your password is updated</p>
                    <%}else if(isCurrentPasswordWrong) {%>
                        <p class="errorinfo">Sorry, Your current password is wrong</p>
                    <%}else if(isPasswordsDifference) {%>
                        <p class="errorinfo">Sorry, Your new and confirm passwords are not the same</p>
                    <%}else {%>
                        <p class="errorinfo">Error. Check code</p>
                    <%}
            }%>
        </form>
    <%}%>
    
    </body>
</html>
