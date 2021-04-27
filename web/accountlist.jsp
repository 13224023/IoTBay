<%-- 
    Document   : accountlist
    Created on : 01/04/2021, 5:38:15 PM
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
        <title>Account List Page</title>
        <link rel="stylesheet" href="CSS/accountlist.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            //CustomerAccount customerList = (CustomerAccount)session.getAttribute("customerList");
            //int customerListSize = customerList.getCustomerAccountNumber();
            
            
            
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
                    String query = "SELECT * FROM USERS";
                    //Store values into each column
                    preparedStmt = connection.prepareStatement(query);
                                                                                    
                    //Execute the query and get a reponse from database
                    resultSet = preparedStmt.executeQuery();
                    
                    System.out.println("Get account data.");
                    while(resultSet.next()) {
                        Customer getCustomer = new Customer(
                                    resultSet.getString(1),
                                    resultSet.getString(2), 
                                    resultSet.getString(3), 
                                    resultSet.getString(4), 
                                    resultSet.getString(5), 
                                    resultSet.getString(6), 
                                    resultSet.getString(7), 
                                    resultSet.getString(8));
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
        %>
        <nav>
            <input type="checkbox" id="check">
            <label for="check" class="checkbtn">
                <i class="fas fa-bars"></i>
            </label>
            <label class="logo">Customer List</label>
            <ul>
                <li><a href="index.jsp">Back</a></li>
            </ul>
        </nav>
        
        <section>
            
                    <center>
                        <table class="table-style">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Username</th>
                                <th>Password</th>
                                <th>Email</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < customerListSize; i++) {%>
                            <tr>
                                <td><%=i + 1%></td>
                                <td><%=customerList.getCustomerByNumber(i).getUsername()%></td>
                                <td><%=customerList.getCustomerByNumber(i).getPassword()%></td>
                                <!--
                                <td><%=customerList.getCustomerByNumber(i).getUserFirstName()%></td>
                                <td><%=customerList.getCustomerByNumber(i).getUserLastName()%></td>
                                -->
                                <td><%=customerList.getCustomerByNumber(i).getEmail()%></td>
                                <!--
                                <td><%=customerList.getCustomerByNumber(i).getBirthday()%></td>
                                <td><%=customerList.getCustomerByNumber(i).getPhone()%></td>
                                -->
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </center>
                
            
        </section>
        
    </body>
</html>
