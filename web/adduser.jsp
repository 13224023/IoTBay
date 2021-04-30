<%-- 
    Document   : adduser
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
        <link rel="stylesheet" href="CSS/adduser.css">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <title>ADD USER</title>
    </head>
    <body>
        <%
            User getUser = (User) session.getAttribute("user");
            String register = request.getParameter("register");
            String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            
            boolean isUserNull = getUser == null? true: false;
            boolean isRegisterButtonClicked = false;
            boolean registerSuccessful = false;
            boolean isUserTypeWrong = false;
            boolean isUserNameExist = false;
            boolean passwordsDifferent = false;
            boolean isCustomer = false;
            boolean isStaff = false;
            String customerNameExistInfo = "Sorry, staff name already exists";
            String passwordDiffInfo = "Sorry, passwords are different";
            String typeWrongInfo = "Sorry, User type is wrong";
            String userTypeCode = "";
            String codeToType = "";
            if(isUserNull || !getUser.getUsertype().equals("0")) {
                response.sendRedirect(redirectURL);
            }
            else {
                if(register != null) {
                    isRegisterButtonClicked = true;
                    String name = request.getParameter("uname");
                    String type = request.getParameter("utype");
                    String uPassword = request.getParameter("upassword");
                    String cPassword = request.getParameter("cupassword");
                    isCustomer = type.toLowerCase().equals("customer");
                    isStaff = type.toLowerCase().equals("staff");
                    if(isCustomer || isStaff) {
                        if(uPassword.equals(cPassword)) {
                            userTypeCode = isCustomer? "2" : "1";
                            codeToType = isCustomer? "Customer": "Staff";
                            DBConnector connector = new DBConnector();
                            DBManager dbManager = new DBManager(connector.getConnection());
                            if(!dbManager.isUsernameExist(name)) {
                                dbManager.addUser(name, uPassword, userTypeCode, "", "1");
                                registerSuccessful = true;
                                connector.closeConnection();
                            }else {
                                isUserNameExist = true;
                            }
                        }
                        else {
                            passwordsDifferent = true;
                        }
                    
                    }else {
                        isUserTypeWrong = true;
                    }
                        
                    
                }
            }
        %>
        <form class="box" action="adduser.jsp" method="post" id="register">
            <h1>User Registration</h1>
            <input type="text" id="uname" name="uname" autocomplete="off" placeholder="Username" required>
            <input type="text" id="utype" name="utype" autocomplete="off" placeholder="Customer or Staff" required>
            <input type="password" id="upassword" name="upassword" autocomplete="off" placeholder="Password" required>
            <input type="password" id="cupassword" name="cupassword" autocomplete="off" placeholder="Confirm Password" required>
            <input type="submit" form="register" name="register" value="Register">
            <input type="button" value="Back" onclick="location.href='http://localhost:8080/IOTBay/accountlist.jsp'">
            
            <%
            if(isRegisterButtonClicked) {
                if(!registerSuccessful) {
                    if(isUserNameExist) {%>
                        <p class="errorinfo"><%= customerNameExistInfo%></p>
                    <%}else if(passwordsDifferent) {%>
                        <p class="errorinfo"><%= passwordDiffInfo%></p>
                    <%}else if(isUserTypeWrong) {%>
                        <p class="errorinfo"><%= typeWrongInfo%></p>
                    <%}else {%>
                        <p class="errorinfo">Should check the code logic</p>
                    <%}%>
                <%}else {%>
                    <p class="successinfo"> <%=codeToType%> account is created.</p>   
                <%}%>
            <%}%>
        </form>
    </body>
</html>
