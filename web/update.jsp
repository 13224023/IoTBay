<%-- 
    Document   : update
    Created on : 30/04/2021, 12:11:20 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<%@page import="java.sql.*"%>
<%@page import="uts.isd.model.dao.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="CSS/update.css">
    </head>
    <body>
        <%String username = request.getParameter("username");%>
        <h1><%=username%></h1>
    </body>
</html>
