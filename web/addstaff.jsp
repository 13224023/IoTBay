<%-- 
    Document   : addstaff
    Created on : 27/04/2021, 7:48:04 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<%--//STEP 1. Import required packages --%>
<%@page import="java.sql.*"%>
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
            
            //String redirectURL = "http://localhost:8080/IOTBay/accountlist.jsp";
            
            boolean isUserNull = getUser == null? true: false;
            
            boolean isRegisterButtonClicked = register != null ? true : false;
            
            boolean registerSuccessful = false;
            
            boolean isUserNameExist = false;
            String customerNameExistInfo = "Sorry, staff name already exists";
            
            boolean passwordsDifferent = false;
            String passwordDiffInfo = "Sorry, passwords are different";
            
            if(!isUserNull && getUser.getUsertype().equals("0")) {
                if(register != null) {
                    String name = request.getParameter("uname");
                    String uPassword = request.getParameter("upassword");
                    String cPassword = request.getParameter("cupassword");
                    String email = request.getParameter("email");
                    
                    if(uPassword.equals(cPassword)) {
                        
                        PreparedStatement preparedStmt = null;
                        Connection connection = null;
                        try {
                            //STEP 2: Register JDBC driver
                            Class.forName("org.apache.derby.jdbc.ClientDriver");
                                
                            //STEP 3: Open a connection
                            //Declare variables to store database url, username, and password
                            String url = "jdbc:derby://localhost:1527/ISD";
                            String user = "root";
                            String password = "root";
                            //Create a connection to access the database
                            connection = DriverManager.getConnection(url, user, password);
                                
                            //STEP 4: Execute a query
                            //Declare a string to store database query
                            String query = "INSERT INTO USERS (USERNAME, PASSWORD, USERTYPE, FIRSTNAME, LASTNAME, PHONE, EMAIL, DOB) " +
                                " VALUES(?,?,?,?,?,?,?,?)";
                                //Store values into each column
                            preparedStmt = connection.prepareStatement(query);
                            preparedStmt.setString(1, name);
                            preparedStmt.setString(2, uPassword);
                            preparedStmt.setString(3, "1");
                            preparedStmt.setString(4, "");
                            preparedStmt.setString(5, "");
                            preparedStmt.setString(6, "");
                            preparedStmt.setString(7, email);
                            preparedStmt.setString(8, "");
                                
                            //Execute the query, then return a value for storing successfully
                            int row = preparedStmt.executeUpdate();
                                
                            
                            //Store the result of registration
                            registerSuccessful = row == 1? true: false;
                            
                            
                            //Close the connection
                            connection.close();
                        }
                        //handle errors
                        catch(SQLException se){
                            //Handle errors for JDBC
                            isUserNameExist = true;
                            se.printStackTrace();
                        }
                        catch(Exception e){
                            //Handle errors for Class.forName
                            isUserNameExist = true;
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
                                isUserNameExist = true;
                                se.printStackTrace();
                            }//end finally try
                        }//end try
                        
                    }
                    else {
                        passwordsDifferent = true;
                    }
                    
                }
            }else {
            
            }
        %>
        <form class="box" action="register.jsp" method="post" id="register">
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
