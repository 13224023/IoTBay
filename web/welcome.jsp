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
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <title>Welcome Page</title>
    </head>
    <body>
        
            <%  
                //Get customer linked from session
                CustomerAccount customerList = (CustomerAccount)session.getAttribute("customerList");
                
                //Get the logged customer from the list
                Customer customer = customerList.getLoggedCustomer();
                
                //Check a logged customer is received or not
                boolean isCustomerEmpty = customer == null? true : false;
            %>
                   
        
        <%if(isCustomerEmpty) {%>
            <h1>Unauthorized action</h1>
            <button onclick="location.href='http://localhost:8080/assignment1/index.jsp'" class="button">Back to index page</button>
        <%}else {%>
        
            
            <nav>
                <input type="checkbox" id="check">
                <label for="check" class="checkbtn">
                    <i class="fas fa-bars"></i>
                </label>
                <label class="logo">Hi, <%=customer.getUsername()%></label>
                <ul>
                    <li><a href="profile.jsp">My Profile</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
            <!--
            <header>
                <div class="container">
                    <h1>Welcome, <%out.println(customer.getUsername());%></h1>
                    <nav>
                        <ul>
                            <li><button onclick="location.href='http://localhost:8080/assignment1/profile.jsp'" class="button">My profile</button></li>
                            <li><button onclick="location.href='http://localhost:8080/assignment1/logout.jsp'" class="button">Logout</button></li>
                            
                        </ul>
                    </nav>
                </div>
            </header>
            -->
            
            <!--
            <h2>Welcome, <%out.println(customer.getUsername());%></h2>
            <button onclick="location.href='http://localhost:8080/assignment1/profile.jsp'" class="button">My profile</button>
            <button onclick="location.href='http://localhost:8080/assignment1/logout.jsp'" class="button">Logout</button>
            -->
        <%}%>
        
        
    </body>
</html>
