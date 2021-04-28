<%-- 
    Document   : addstaff
    Created on : 27/04/2021, 7:48:04 PM
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
        <link rel="stylesheet" href="CSS/addstaff.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <title>ADD STAFF</title>
    </head>
    <body>
        <%
            User getUser = (User) session.getAttribute("user");
            
            String register = request.getParameter("register");
            
            String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            
            boolean isUserNull = getUser == null? true: false;
            
            boolean isRegisterButtonClicked = false;
            
            boolean registerSuccessful = false;
            
            boolean isUserNameExist = false;
            String customerNameExistInfo = "Sorry, staff name already exists";
            
            boolean passwordsDifferent = false;
            String passwordDiffInfo = "Sorry, passwords are different";
            if(isUserNull || !getUser.getUsertype().equals("0")) {
                response.sendRedirect(redirectURL);
            }
            else {
                if(register != null) {
                    isRegisterButtonClicked = true;
                    String name = request.getParameter("uname");
                    String uPassword = request.getParameter("upassword");
                    String cPassword = request.getParameter("cupassword");
                    String email = request.getParameter("email");
                    
                    if(uPassword.equals(cPassword)) {
                        DBConnector connector = new DBConnector();
                        DBManager dbManager = new DBManager(connector.getConnection());
                        
                        if(!dbManager.isUsernameExist(name)) {
                            dbManager.addUser(name, uPassword, "1", email);
                            registerSuccessful = true;
                            connector.closeConnection();
                        }else {
                            isUserNameExist = true;
                        }
                    }
                    else {
                        passwordsDifferent = true;
                    }
                    
                }
            }
        %>
        <form class="box" action="addstaff.jsp" method="post" id="register">
            <h1>Staff Registration</h1>
            <input type="text" id="uname" name="uname" autocomplete="off" placeholder="Username" required>
            <input type="password" id="upassword" name="upassword" autocomplete="off" placeholder="Password" required>
            <input type="password" id="cupassword" name="cupassword" autocomplete="off" placeholder="Confirm Password" required>
            <input type="mail" id="email" name="email" autocomplete="off" placeholder="xxx@xxx.xxx" required>
            <input type="submit" form="register" name="register" value="Register">
            <input type="button" value="Back" onclick="location.href='http://localhost:8080/IOTBay/accountlist.jsp'">
            
            <%
            if(isRegisterButtonClicked) {
                if(!registerSuccessful) {
                    if(isUserNameExist) {%>
                        <p class="errorinfo"><%= customerNameExistInfo%></p>
                    <%}else if(passwordsDifferent) {%>
                        <p class="errorinfo"><%= passwordDiffInfo%></p>
                    <%}else {%>
                        <p class="errorinfo">Should check the code logic</p>
                    <%}%>
                <%}else {%>
                    <p class="successinfo">Staff account is created.</p>   
                <%}%>
            <%}%>
        </form>
    </body>
</html>
