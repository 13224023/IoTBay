<%-- 
    Document   : login
    Created on : 
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<%--//STEP 1. Import required packages --%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/login.css">
        <title>Login Page</title>
    </head>
    <body>
        <%
            CustomerAccount customerList = (CustomerAccount) session.getAttribute("customerList");
            Customer customer = customerList.getLoggedCustomer();
            String login = request.getParameter("login");
            String redirectURL = "http://localhost:8080/IOTBay/welcome.jsp";
            
            boolean isCustomerEmpty = customer == null? true : false;
            boolean isLoginButtonClicked = login != null? true : false;
            boolean loginSuccessful = false;
            
            if(!isCustomerEmpty) {
                response.sendRedirect(redirectURL);
            }else {
                if(login != null) {
                    String name = request.getParameter("uname");
                    String password = request.getParameter("upassword");
                    /*
                    loginSuccessful = customerList.setCustomerLogged(name, password);
                    
                    if(loginSuccessful) {
                        session.setAttribute("customerList", customerList);
                        response.sendRedirect(redirectURL);
                    }
                    */
                    PreparedStatement preparedStmt = null;
                    Connection connection = null;
                    ResultSet resultSet = null;
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
                        String query = "SELECT * FROM USERS WHERE USERNAME=? AND PASSWORD=?";
                        //Store values into each column
                        preparedStmt = connection.prepareStatement(query);
                        preparedStmt.setString(1, name);
                        preparedStmt.setString(2, password);
                                                                
                        //Execute the query and get a reponse from database
                        resultSet = preparedStmt.executeQuery();
                                
                        if(resultSet.next()) {
                            System.out.println("Get account data.");
                            Customer getCustomer = new Customer(
                                    resultSet.getString(1),
                                    resultSet.getString(2), 
                                    resultSet.getString(3), 
                                    resultSet.getString(4), 
                                    resultSet.getString(5), 
                                    resultSet.getString(6), 
                                    resultSet.getString(7), 
                                    resultSet.getString(8));
                            /*
                            System.out.println(resultSet.getString(1));
                            System.out.println(resultSet.getString(2));
                            System.out.println(resultSet.getString(3));
                            System.out.println(resultSet.getString(4));
                            System.out.println(resultSet.getString(5));
                            System.out.println(resultSet.getString(6));
                            System.out.println(resultSet.getString(7));
                            System.out.println(resultSet.getString(8));
                            */
                            loginSuccessful = true;
                            session.setAttribute("customer", getCustomer);
                            response.sendRedirect(redirectURL);
                        }
                                
                                
                                
                                
                        //Close the connection
                        connection.close();
                        resultSet.close();
                        
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
                            }catch(SQLException se){
                                se.printStackTrace();
                            }//end finally try
                        }//end try
                    }
            }
            
        %>
       
        
        <form class="box" action="login.jsp" method="get" id="login">
            <h1>Login</h1>
            <input type="text" id="uname" name="uname" autocomplete="off" placeholder="Username" required>
            <input type="password" id="upassword" name="upassword" autocomplete="off" placeholder="Password" required>
            <input type="submit" form="login" name="login" value="Login">
            <input type="button" value="Back" onclick="location.href='http://localhost:8080/IOTBay/'">
            <p> Not a Customer? <a href="register.jsp">Register</a></p>
            <p class="errorinfo"><%= isLoginButtonClicked? loginSuccessful? "": "Invalid password. Please try again" :"" %></p>
        </form>
        
    </body>
</html>
