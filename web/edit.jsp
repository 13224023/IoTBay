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
            //Get data from session
            //CustomerAccount customerList= (CustomerAccount) session.getAttribute("customerList");
            
            //Get data from the object
            User user = (User) session.getAttribute("user");
            
            //The variable is to check user presses update button or not 
            String updated = request.getParameter("updated");
            
            //The variables is to check to disply the update result
            boolean isUserNull = user == null? true: false;
            boolean isUpdateSuccessful = false;
            boolean isUpdateOn = updated != null? true : false;
            
            String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            
            String pFirstName;
            String pLastName;
            String pEmail;
            String pBirthday;
            String pPhone;
            
            
            //Store user info into variables
            pFirstName = user.getUserFirstName();
            pLastName = user.getUserLastName();
            pEmail = user.getEmail();
            pBirthday = user.getBirthday();
            pPhone = user.getPhone();
            
              
            
            //The variables is store the inforamtion of success or failure update
            String successInfo = "Successfully update";
            String failureInfo = "Update Failure! Check the code";
            
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
                    /*
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
                        String query = "UPDATE USERS SET FIRSTNAME = ?, LASTNAME = ?, EMAIL = ?, DOB = ?, PHONE = ? WHERE USERNAME = ?";
                        //Store values into each column
                        preparedStmt = connection.prepareStatement(query);
                        preparedStmt.setString(1, firstName);
                        preparedStmt.setString(2, lastName);
                        preparedStmt.setString(3, email);
                        preparedStmt.setString(4, birthday);
                        preparedStmt.setString(5, phone);
                        preparedStmt.setString(6, userName);
                                                                
                        //Execute the query and get a reponse from database
                        preparedStmt.executeUpdate();
                        
                        //Close the connection
                        preparedStmt.close();
                        connection.close();
                        
                        
                        //update customer profile
                        isUpdateSuccessful = user.setProfile(firstName, lastName , email, birthday, phone);
                    
                        //update session
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
                    
                    */
                    
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
