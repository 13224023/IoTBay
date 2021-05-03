<%-- 
    Document   : logs
    Created on : 27/04/2021, 6:47:45 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<%@page import="uts.isd.model.dao.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGS Page</title>
        <link rel="stylesheet" href="CSS/logs.css">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <h1>LOGS Page</h1>
        <%
            User user = (User) session.getAttribute("user");
            String redirectURL = "http://localhost:8080/IOTBay/unathorised.jsp";
            boolean isUserNull = user == null? true : false;
            LogList logList = new LogList();
            boolean isUserAdmin = false;
            if(!isUserNull) {
                DBConnector connector = new DBConnector();
                LOGManager logManager = new LOGManager(connector.getConnection());
                isUserAdmin = user.getUsertype().equals("0");
                if(isUserAdmin) {
                    logList = logManager.getAllLogs();
                }else {
                    logList = logManager.getLogsByUsername(user.getUsername());
                }
            }
            else {
                response.sendRedirect(redirectURL);
            }
            
        %>
        
        <%if(isUserAdmin) {%>
            <% for(int i = 0; i < logList.listSize(); i++) {%>
                <h2><%= "" + (i + 1) + " " + logList.getLogByIndex(i)%></h2>
            <%}%>
        <%}else {%>
            <% for(int i = 0; i < logList.listSize(); i++) {%>
                <h2><%= "" + (i + 1) + " " + logList.getLogByIndex(i).displayLogWithoutUsername()%></h2>
            <%}%>
        <%}%>
        
               
        
        
        
    </body>
</html>
