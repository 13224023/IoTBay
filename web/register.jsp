<%-- 
    Document   : register
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
        <link rel="stylesheet" href="CSS/register.css">
        <title>Register Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    </head>
    <body class="back">
        <%
            
            //CustomerAccount customerList= (CustomerAccount) session.getAttribute("customerList");
            //Customer customer = customerList.getLoggedCustomer();
            
            Customer customer = (Customer) session.getAttribute("customer");
            
            String register = request.getParameter("register");
            
            String redirectURL = "http://localhost:8080/IOTBay/welcome.jsp";
            
            boolean isRegisterButtonClicked = register != null ? true : false;
            
            boolean registerSuccessful = false;
            
            boolean isCustomerNameExist = false;
            String customerNameExistInfo = "Sorry, user name already exists";
            
            boolean passwordsDifferent = false;
            String passwordDiffInfo = "Sorry, passwords are different";
            
            if(customer != null) {
                response.sendRedirect(redirectURL);
            }else {
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
                            preparedStmt.setString(3, "2");
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
                            isCustomerNameExist = true;
                            se.printStackTrace();
                        }
                        catch(Exception e){
                            //Handle errors for Class.forName
                            isCustomerNameExist = true;
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
                                isCustomerNameExist = true;
                                se.printStackTrace();
                            }//end finally try
                        }//end try
                    }
                    else {
                        passwordsDifferent = true;
                    }
                    
                    if(registerSuccessful) {
                        //session.setAttribute("customerList", customerList);
                        Customer newCustomer = new Customer(name, uPassword, email);
                        newCustomer.setIsLogged(true);
                        session.setAttribute("customer", newCustomer);
                        response.sendRedirect(redirectURL);
                    }
                }
            }
            
        %>
        <form class="box" action="register.jsp" method="post" id="register">
            <h1>Register</h1>
            <input type="text" id="uname" name="uname" autocomplete="off" placeholder="Username" required>
            <input type="password" id="upassword" name="upassword" autocomplete="off" placeholder="Password" required>
            <input type="password" id="cupassword" name="cupassword" autocomplete="off" placeholder="Confirm Password" required>
            <input type="mail" id="email" name="email" autocomplete="off" placeholder="xxx@xxx.xxx" required>
            <!--
            <input type="date" id="birthday" name="birthday" autocomplete="off" placeholder="DD/MM/YYYY" required>
            <input type="tel" id="phone" name="phone" autocomplete="off" placeholder="1234567890" required>
            -->
            <input type="submit" form="register" name="register" value="Register">
            <input type="button" value="Back" onclick="location.href='http://localhost:8080/IOTBay/'">
            <p> Already a Customer? <a href="login.jsp">Login</a></p>
            <%
            if(isRegisterButtonClicked) {
                if(!registerSuccessful) {
                    if(isCustomerNameExist) {%>
                        <p class="errorinfo"><%= customerNameExistInfo%></p>
                    <%}else if(passwordsDifferent) {%>
                        <p class="errorinfo"><%= passwordDiffInfo%></p>
                    <%}else {%>
                        <p class="errorinfo">Should check the code logic</p>
                    <%}
                }
            }
            %>
        </form>
        
    </body>
</html>

