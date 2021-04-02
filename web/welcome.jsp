<%-- 
    Document   : welcome
    Created on : 
    Author     : Jung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/welcome.css">
        <title>Welcome Page</title>
    </head>
    <body>
        <center>
            <%  
                //Get customer linked from session
                CustomerAccount customerList = (CustomerAccount)session.getAttribute("customerList");
                
                //Get the logged customer from the list
                Customer customer = customerList.getLoggedCustomer();
                
                //Check a logged customer is received or not
                boolean isCustomerEmpty = customer == null? true : false;
            %>
                   
        </center>
        <%if(isCustomerEmpty) {%>
            <h1>Unauthorized action</h1>
            <button onclick="location.href='http://localhost:8080/assignment/index.jsp'" class="button">Back to index page</button>
        <%}else {%>
            <h2>Welcome, <%out.println(customer.getUsername());%></h2>
            <button onclick="location.href='http://localhost:8080/assignment/profile.jsp'" class="button">My profile</button>
            <button onclick="location.href='http://localhost:8080/assignment/logout.jsp'" class="button">Logout</button>
        <%}%>
        
        
    </body>
</html>
