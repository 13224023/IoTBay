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
                //Get customer linked from session
                //CustomerAccount customerList = (CustomerAccount)session.getAttribute("customerList");
                
                //Get the logged customer from the list
                User user = (User)session.getAttribute("user");
                
                //Check a logged customer is received or not
                boolean isUserEmpty = user == null? true : false;
                
                String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            %>
                   
        
        <%if(isUserEmpty) {
            response.sendRedirect(redirectURL);
        %>
        <%}else if(user.getUsertype().equals("2")) {%>
            <nav>
                <input type="checkbox" id="check">
                <label for="check" class="checkbtn">
                    <i class="fas fa-bars"></i>
                </label>
                <label class="logo">Hi, <%=user.getUserFirstName().equals("")? user.getUsername(): user.getUserFirstName()%></label>
                <ul>
                    <li><a href="profile.jsp">My Profile</a></li>
                    <li><a href="cart.jsp">Cart</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
        <%}%>
        
        
    

