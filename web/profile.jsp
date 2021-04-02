<%-- 
    Document   : main
    Created on : 31/03/2021, 5:15:23 PM
    Author     : Administrator
--%>
<%@page import="uts.isd.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
    </head>
    <body>
        <%
            //Get a customer list from the customer list
            CustomerAccount customerList = (CustomerAccount)session.getAttribute("customerList");
            
            //Get a logged customer
            Customer customer = customerList.getLoggedCustomer();
            
            //Check a logged customer is received or not
            boolean isCustomerEmpty = customer == null? true : false;
        %>
        
        <%if(isCustomerEmpty) {%>
            <h1>Unauthorized action</h1>
            <button onclick="location.href='http://localhost:8080/assignment/index.jsp'" class="button">Back to index page</button>
        <%}else{%>
            <h1>Customer Profile Page</h1>
            <h2><%= customer%></h2>
            <button onclick="location.href='http://localhost:8080/assignment/edit.jsp'" class="button">Edit</button>
            <button onclick="location.href='http://localhost:8080/assignment/changepassword.jsp'" class="button">Change Password</button>
            <button onclick="location.href='http://localhost:8080/assignment/welcome.jsp'" class="button">Back To Welcome page</button>
        <%}%>
        
        
       
    </body>
</html>
