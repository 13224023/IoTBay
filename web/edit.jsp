<%-- 
    Document   : edit
    Created on : 31/03/2021, 6:51:57 PM
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
        <title>Edit Profile Page</title>
        <link rel="stylesheet" href="CSS/edit.css">
    </head>
    <body>
        <%
            //Get data from the object
            User user = (User) session.getAttribute("user");
            
            //The variable is to check user presses update button or not 
            String updated = request.getParameter("updated");
            String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            
            //The variables is store the inforamtion of success or failure update
            String successInfo = "Successfully update";
            String failureInfo = "Update Failure! Check the code";
            String pFirstName = "";
            String pLastName = "";
            String pEmail = "";
            String pBirthday = "";
            String pPhone = "";
                       
            //The variables is to check to disply the update result
            boolean isUserNull = user == null? true: false;
            boolean isUpdateSuccessful = false;
            boolean isUpdateOn = false;
            
            if(updated != null)
                isUpdateOn = true;
            
            //Store user info into variables
            if(!isUserNull) {
                pFirstName = user.getUserFirstName();
                pLastName = user.getUserLastName();
                pEmail = user.getEmail();
                pBirthday = user.getBirthday();
                pPhone = user.getPhone();
            }
                
            if(isUpdateOn && !isUserNull) {
                    //get data from html form
                    String username = user.getUsername();
                    String password = user.getPassword();
                    String firstname = request.getParameter("fname");
                    String lastname = request.getParameter("lname");
                    String email = request.getParameter("email");
                    String birthday = request.getParameter("birthday");
                    String phone = request.getParameter("phone");
                    
                                        
                    //update variables
                    pFirstName = firstname;
                    pLastName = lastname;
                    pEmail = email;
                    pBirthday = birthday;
                    pPhone = phone;
                    
                    DBConnector connector = new DBConnector();
                    DBManager dbManager = new DBManager(connector.getConnection());
                    dbManager.updateUserProfile(username, password, firstname, lastname, email, birthday, phone);
                    
                    //update user profile
                    isUpdateSuccessful = user.setProfile(firstname, lastname , email, birthday, phone);
                    
                    //update session
                    session.setAttribute("user", user);
                                      
            }
        
            if(isUserNull) {
                response.sendRedirect(redirectURL);
            }else {%>
            <form class="box" action="edit.jsp" method="post" id="update">
                <h1>Edit Profile</h1>
                <input type="text" id="fname" name="fname" autocomplete="off" placeholder="First Name" value="<%=pFirstName%>">
                <input type="text" id="lname" name="lname" autocomplete="off" placeholder="Last Name" value="<%=pLastName%>">
                <input type="mail" id="email" name="email" autocomplete="off" placeholder="Email" value="<%=pEmail%>" required>
                <input type="date" id="birthday" name="birthday" autocomplete="off" value="<%=pBirthday%>" required>
                <input type="tel" id="phone" name="phone" autocomplete="off" placeholder="Phone Number" value="<%=pPhone%>">
                <input type="submit" form="update" name="updated" value="Update">
                <input type="button" value="Back" onclick="location.href='http://localhost:8080/IOTBay/profile.jsp'">
                <%
                if(isUpdateOn) {
                    if(isUpdateSuccessful) {%>
                        <p><%=successInfo%></p>
                    <%}else {%>
                        <p class="errorinfo"><%=failureInfo%></p>
                    <%}%>
                <%}%>
            </form>
        <%}%>
            
    </body>
</html>
