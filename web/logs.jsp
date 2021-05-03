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
        <%
            User user = (User) session.getAttribute("user");
            String redirectURL = "http://localhost:8080/IOTBay/unathorised.jsp";
            boolean isUserNull = user == null? true : false;
            LogList logList = new LogList();
            boolean isUserAdmin = false;
            String search = request.getParameter("filter");
            boolean isSearchButtonClicked = search != null? true: false;
            
            String userType = "";
            if(!isUserNull) {
                DBConnector connector = new DBConnector();
                LOGManager logManager = new LOGManager(connector.getConnection());
                isUserAdmin = user.getUsertype().equals("0");
                userType = isUserAdmin? "root" : user.getUsertype().equals("1")? "staff" : "customer";
                if(isSearchButtonClicked) {
                    String month = request.getParameter("month");
                    String day = request.getParameter("days");
                    if(isUserAdmin) {
                        logList = logManager.getAllLogs().getListByDate(month, day);
                    }else {
                        logList = logManager.getLogsByNameAndDate(user.getUsername(), month, day);
                        //logList = logManager.
                    }
                }else {
                    if(isUserAdmin) {
                        logList = logManager.getAllLogs();
                    }else {
                        //userType = user.getUsertype().equals("1")? "staff": "customer";
                        logList = logManager.getLogsByUsername(user.getUsername());
                    }
                }
                
                
                
            }
            else {
                response.sendRedirect(redirectURL);
            }
            
        %>
        <nav class="<%=userType%>">
                <input type="checkbox" id="check">
                <label for="check" class="checkbtn">
                    <i class="fas fa-bars"></i>
                </label>
                <label class="logo">User Logs</label>
                <ul>
                    <li><a href="welcome.jsp">BACK</a></li>
                </ul>
        </nav>
        
        
    
        <center>
            
            <div>
                <form class="keyword" method="post" action="logs.jsp">
                        <input type="text" class="search" name="month" autocomplete="off" placeholder="Month">
                        <input type="text" class="search" name="days" autocomplete="off" placeholder="Days">
                        <button type="submit" class="submit" name="filter" value="search" onclick="location.href='http://localhost:8080/IOTBay/logs.jsp'">Search</button>
                </form>
            
        
        
            
                <table class="table-style">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Username</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Time</th>
                            </tr>
                        </thead>
                        <tbody>

                            <% for(int i = 0; i < logList.listSize(); i++) {%>
                                <tr>
                                    <td><%= i + 1%></td>
                                    <td><%= logList.getLogByIndex(i).getUsername()%></td>
                                    <td><%= logList.getLogByIndex(i).getType()%></td>
                                    <td><%= logList.getLogByIndex(i).getDate()%></td>
                                    <td><%= logList.getLogByIndex(i).getTime()%></td>
                                </tr>
                            <%}%>

                        </tbody>
                </table>
            </div>
            
        </center>
            
        
        
               
        
        
        
    </body>
</html>
