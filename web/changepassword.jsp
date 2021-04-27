<%-- 
    Document   : changepassword
    Created on : 02/04/2021, 10:11:04 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<%@page import="java.sql.*"%>
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
        
        String change = request.getParameter("change");
        String userName = user.getUsername();
        
        boolean isUserNull = user == null? true : false;
        boolean isChangeButtonClicked = change != null? true : false;
        
        boolean isPasswordsDifference = false;
        boolean isCurrentPasswordWrong = false;
        boolean isPasswordUpdated = false;
        
        if(isChangeButtonClicked) {
            String pPassword = request.getParameter("ppassword");
            String nPassword = request.getParameter("npassword"); 
            String cPassword = request.getParameter("cpassword");
            if(user.getPassword().equals(pPassword)) {
                if(nPassword.equals(cPassword)) {
                    PreparedStatement preparedStmt = null;
                    Connection connection = null;
                    
                    try {
                        //STEP 2: Register JDBC driver
                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                                
                        //STEP 3: Open a connection
                        //Declare variables to store database url, username, and password
                        String url = "jdbc:derby://localhost:1527/ISD";
                        String databaseUser = "root";
                        String databasePassword = "root";
                        //Create a connection to access the database
                        connection = DriverManager.getConnection(url, databaseUser, databasePassword);
                                
                        //STEP 4: Execute a query
                        //Declare a string to store database query
                        String query = "UPDATE USERS SET PASSWORD = ? WHERE USERNAME = ?";
                        //Store values into each column
                        preparedStmt = connection.prepareStatement(query);
                        preparedStmt.setString(1, nPassword);
                        preparedStmt.setString(2, userName);
                       
                                                                
                        //Execute the query and get a reponse from database
                        preparedStmt.executeUpdate();
                        
                        //Close the connection
                        preparedStmt.close();
                        connection.close();
                        
                        
                        //Update customer's current password
                        isPasswordUpdated = user.setPassword(nPassword);
                        
                        //Update session
                        session.setAttribute("user", user);
                                
                                
                       
                        
                                               
                    }
                    //handle errors
                    catch(SQLException se){
                        //Handle errors for JDBC
                        se.printStackTrace();
                    }
                    catch(Exception e){
                        //Handle errors for Class.forName
                        e.printStackTrace();
                    }
                    finally{
                        //finally block used to close resources
                        try{
                            if(preparedStmt != null)
                                preparedStmt.close();
                        }
                        catch(SQLException se2){
                        }// nothing we can do
                        try{
                            if(connection != null)
                                connection.close();
                        }
                        catch(SQLException se){
                            se.printStackTrace();
                        }//end finally try
                    }//end try
                    
                    
                    
                    
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
