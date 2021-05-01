<%-- 
    Document   : update
    Created on : 30/04/2021, 12:11:20 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<%@page import="java.sql.*"%>
<%@page import="uts.isd.model.dao.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="CSS/update.css">
    </head>
    <body>
        
        
        <%
            //Get data from the object
            User user = (User) session.getAttribute("user");
            String username = request.getParameter("username");
            String updated = request.getParameter("updated");
            //The variable is to check user presses update button or not 
            
            String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            
            String successInfo = "Successfully update";
            String failureInfo = "Update Failure! Check the code";
            String pFirstName = "";
            String pLastName = "";
            String pEmail = "";
            String pBirthday = "";
            String pPhone = "";
                       
            //The variables is to check to disply the update result
            boolean isUserIllegal = user == null || !user.getUsertype().equals("0") ? true: false;
            boolean isUpdateSuccessful = false;
            boolean isUpdateOn = updated != null ? true: false;
            boolean isEditButtonClicked = username != null? true: false;
            
            DBConnector connector = new DBConnector();
            DBManager dbManager = new DBManager(connector.getConnection());
            //dbManager.updateUserProfile(username, password, firstname, lastname, email, birthday, phone);
            User getUser;
            String password = "";
            //Store user info into variables
            if(!isUserIllegal && isEditButtonClicked) {
                getUser = dbManager.findUserByUserName(username);
                password = getUser.getPassword();
                pFirstName = getUser.getUserFirstName();
                pLastName = getUser.getUserLastName();
                pEmail = getUser.getEmail();
                pBirthday = getUser.getBirthday();
                pPhone = getUser.getPhone();
                
            }
                
            if(isUpdateOn && !isUserIllegal) {
                    String uname = request.getParameter("keyuser");
                    String upassword = request.getParameter("keypassword");
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
                    
                    
                    dbManager.updateUserProfile(uname, upassword, firstname, lastname, email, birthday, phone);
                    
                    //update user profile
                    isUpdateSuccessful = true;
                    
                                                          
            }
            if(isUserIllegal) {
                response.sendRedirect(redirectURL);
            }else {%>
                    <form class="box" action="update.jsp" method="post" id="update">
                        <h1><%=username%> Profile</h1>
                        <input type="text" id="fname" name="fname" autocomplete="off" placeholder="First Name" value="<%=pFirstName%>">
                        <input type="text" id="lname" name="lname" autocomplete="off" placeholder="Last Name" value="<%=pLastName%>">
                        <input type="mail" id="email" name="email" autocomplete="off" placeholder="Email" value="<%=pEmail%>" required>
                        <input type="date" id="birthday" name="birthday" autocomplete="off" value="<%=pBirthday%>" required>
                        <input type="tel" id="phone" name="phone" autocomplete="off" placeholder="Phone Number" value="<%=pPhone%>">
                        <input type="submit" form="update" name="updated" value="Update">
                        <input type="button" value="Back" onclick="location.href='http://localhost:8080/IOTBay/accountlist.jsp'">
                        <input type="hidden" name="keypassword" value="<%=password%>">
                        <input type="hidden" name="keyuser" value="<%=username%>">
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
