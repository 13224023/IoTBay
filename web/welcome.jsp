<%-- 
    Document   : welcome
    Created on : 
    Author     : Jung
--%>

<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/welcome.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <title>Welcome Page</title>
    </head>
    <body>
        <%  
            User user = (User) session.getAttribute("user");
            String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            boolean isUserNull = user == null;
            if(isUserNull) response.sendRedirect(redirectURL);
            String usertype = user.getUsertype();
        %>
        
        <%if(usertype.equals("0")) {%>
            <nav class="root">
                <input type="checkbox" id="check">
                <label for="check" class="checkbtn">
                    <i class="fas fa-bars"></i>
                </label>
                <label class="logo">Hi, <%=user.getUserFirstName().equals("")? user.getUsername(): user.getUserFirstName()%></label>
                <ul>
                    <li><a href="ProfileController">My Profile</a></li>
                    <li><a href="AccountListController">AccountList</a></li>
                    <li><a href="LogsController">LOGS</a></li>
                    <li><a href="LogoutController">Logout</a></li>
                </ul>
            </nav>
        <%}else if(usertype.equals("1")) {%>
            <nav class="staff">
                <input type="checkbox" id="check">
                <label for="check" class="checkbtn">
                    <i class="fas fa-bars"></i>
                </label>
                <label class="logo">Hi, <%=user.getUserFirstName().equals("")? user.getUsername(): user.getUserFirstName()%></label>
                <ul>
                    <li><a href="<%="ProfileController"%>">My Profile</a></li>
                    <li><a href="ProductListController">Product</a></li>
                    <li><a>Order</a></li>
                    <li><a href="LogsController">LOGS</a></li>
                    <li><a href="LogoutController">Logout</a></li>
                </ul>
            </nav>
        <%} else {%>
            <nav class="customer">
                <input type="checkbox" id="check">
                <label for="check" class="checkbtn">
                    <i class="fas fa-bars"></i>
                </label>
                <label class="logo">Hi, <%=user.getUserFirstName().equals("")? user.getUsername(): user.getUserFirstName()%></label>
                <ul>
                    <li><a href="<%="ProfileController"%>">My Profile</a></li>
                    <li><a href="cart.jsp">Cart</a></li>
                    <li><a href="LogsController">LOGS</a></li>
                    <li><a href="LogoutController">Logout</a></li>
                </ul>
            </nav>
        <%}%>
        
        
    </body>
        
        
        
    

