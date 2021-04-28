<%-- 
    Document   : delete
    Created on : 27/04/2021, 5:57:48 PM
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
        <title>Delete Page</title>
    </head>
    <body>
        <%
            User getUser = (User)session.getAttribute("user");
            boolean isUserNull = getUser == null? true: false;
            String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            String username = "";
            if(!isUserNull) {
                username = getUser.getUsername();
            }
            
            boolean isUserDeleted = false;
            
            //start to access database
            
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
                            String query = "DELETE FROM USERS WHERE USERNAME = ?";
                                //Store values into each column
                            preparedStmt = connection.prepareStatement(query);
                            preparedStmt.setString(1, username);
                            
                                
                            //Execute the query, then return a value for storing successfully
                            int row = preparedStmt.executeUpdate();
                                
                            
                            //Store the result of registration
                            isUserDeleted = row == 1? true: false;
                            
                            
                            //Close the connection
                            connection.close();
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
            
            
            
                        if(!isUserNull) {
                            session.invalidate();
                        }
        %>
        
        <%if(isUserNull) {
            response.sendRedirect(redirectURL);
        %>
        <%}else {%>
            <h1>Delete Page</h1>
            <h2>Your account has been deleted. </h2>
            <button onclick="location.href='http://localhost:8080/IOTBay/'" class="button">Back to homepage</button>
        <%}%>
    </body>
</html>
