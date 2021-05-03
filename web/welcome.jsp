<%-- 
    Document   : welcome
    Created on : 
    Author     : Jung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/welcome.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <title>Welcome Page</title>
    </head>
    
        
            <%  
                //Get the logged customer from the list
                User user = (User)session.getAttribute("user");
                
                //Check a logged customer is received or not
                boolean isUserEmpty = user == null? true : false;
                                
                String usertype = !isUserEmpty? user.getUsertype(): "";
                String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
                
            %>
                   
        
        <%if(isUserEmpty) {
            response.sendRedirect(redirectURL);
        %>
        <%}else if(usertype.equals("2")) {%>
            <nav class="customer">
                <input type="checkbox" id="check">
                <label for="check" class="checkbtn">
                    <i class="fas fa-bars"></i>
                </label>
                <label class="logo">Hi, <%=user.getUserFirstName().equals("")? user.getUsername(): user.getUserFirstName()%></label>
                <ul>
                    <li><a href="profile.jsp">My Profile</a></li>
                    <li><a href="cart.jsp">Cart</a></li>
                    <li><a href="logs.jsp">LOGS</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
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
                    <li><a href="profile.jsp">My Profile</a></li>
                    <li><a>Product</a></li>
                    <li><a>Order</a></li>
                    <li><a href="logs.jsp">LOGS</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
        <%}else {%>
             <nav class="root">
                <input type="checkbox" id="check">
                <label for="check" class="checkbtn">
                    <i class="fas fa-bars"></i>
                </label>
                <label class="logo">Hi, <%=user.getUserFirstName().equals("")? user.getUsername(): user.getUserFirstName()%></label>
                <ul>
                    <li><a href="profile.jsp">My Profile</a></li>
                    <li><a href="accountlist.jsp">AccountList</a></li>
                    <li><a href="logs.jsp">LOGS</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
        <%}%>
        
        
    

