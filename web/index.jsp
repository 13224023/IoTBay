<%-- 
    Document   : index
    Created on : 
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/index.css">
    <title>Home Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
        
    </head>
    <body>
        <%
            CustomerAccount customerList = (CustomerAccount)session.getAttribute("customerList");
            if(customerList == null) {
                customerList = new CustomerAccount();
                session.setAttribute("customerList", customerList);
            }
        %>
        <header>
            <div class="container">
                <h1>IoTBay Home Page</h1>
                <nav>
                    <ul>
                        <li><button onclick="location.href='http://localhost:8080/assignment/login.jsp'" class="button">Login</button></li>
                        <li><button onclick="location.href='http://localhost:8080/assignment/register.jsp'" class="button">Register</button></li>
                        <li><button onclick="location.href='http://localhost:8080/assignment/accountlist.jsp'" class="button">Customer List</button></li>

                    </ul>
                </nav>
            </div>
            
        </header>
        
        

    </body>
</html>
