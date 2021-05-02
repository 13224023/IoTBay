<%-- 
    Document   : accountlist
    Created on : 01/04/2021, 5:38:15 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<%--//STEP 1. Import required packages --%>
<%@page import="java.sql.*"%>
<%@page import="uts.isd.model.dao.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account List Page</title>
        <link rel="stylesheet" href="CSS/accountlist.css">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            User user = (User)session.getAttribute("user");
            UserAccount userList = new UserAccount();
            String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            int userListSize = 0;
            boolean isUserNull = user == null? true: false;
            
            String username = request.getParameter("delete");
            boolean isDeleteButtonClicked = username != null ? true : false;
            
            String status = request.getParameter("status");
            boolean isStatusButtonClicked = status != null? true: false;
                        
            
            String search = request.getParameter("filter1");
            boolean isSearchButtonClicked = search != null? true: false;
            
            String usertype = request.getParameter("filter2");
            boolean isUserTypeButtonClicked = usertype != null? true: false;
            
            boolean isUserAdmin = false;
            if(!isUserNull) {
                if(user.getUsertype().equals("0")) {
                    isUserAdmin = true;
                }
            }
            
            if(isUserAdmin) {
                DBConnector connector = new DBConnector();
                DBManager dbManager = new DBManager(connector.getConnection());
                if(isDeleteButtonClicked) {
                     dbManager.deleteUser(username);
                     userList = dbManager.getAllUsers();
                     userListSize = userList.getUserAccountNumber();
                }else if(isSearchButtonClicked) {
                    String keyword = request.getParameter("keyword");
                    userList = dbManager.getAllUsersByUsername(keyword);
                    userListSize = userList.getUserAccountNumber();
                }else if(isUserTypeButtonClicked) {
                    userList = dbManager.getAllUsersByUsertype(usertype);
                    userListSize = userList.getUserAccountNumber();
                }else if(isStatusButtonClicked) {
                    username = request.getParameter("username");
                    dbManager.updateUserStatus(username, status);
                    userList = dbManager.getAllUsers();
                    userListSize = userList.getUserAccountNumber();
                }else {
                    userList = dbManager.getAllUsers();
                    userListSize = userList.getUserAccountNumber();
                }
                connector.closeConnection();
            
            }
            
            
        %>
        <%if(!isUserAdmin){
            response.sendRedirect(redirectURL);
        }else {%>
            <nav class="root">
                <input type="checkbox" id="check">
                <label for="check" class="checkbtn">
                    <i class="fas fa-bars"></i>
                </label>
                <label class="logo">User List</label>
                <ul>
                    <li><a href="adduser.jsp">ADD USER</a></li>
                    <li><a href="welcome.jsp">BACK</a></li>
                </ul>
            </nav>
            <section>
                <div>
                    <form class="keyword" method="post" action="accountlist.jsp">
                        <input type="text" class="search" name="keyword" autocomplete="off" placeholder="username">
                        <button type="submit" class="submit" name="filter1" value="search" onclick="location.href='http://localhost:8080/IOTBay/accountlist.jsp'">Search</button>
                        <button type="submit" class="submit2" name="filter2" value="2" onclick="location.href='http://localhost:8080/IOTBay/accountlist.jsp'">Customer</button>
                        <button type="submit" class="submit3" name="filter2" value="1" onclick="location.href='http://localhost:8080/IOTBay/accountlist.jsp'">Staff</button>
                    </form>
                </div>
                            
                
                    <%for (int i = 0; i < userListSize; i++) {
                        String eachUsername = userList.getUserByNumber(i).getUsername();
                        String eachUsertype = userList.getUserByNumber(i).getUsertype();
                        String eachUserstatus = userList.getUserByNumber(i).getStatus();
                        String eachFirstname = userList.getUserByNumber(i).getUserFirstName();
                        String eachLastname = userList.getUserByNumber(i).getUserLastName();
                        String eachUserPassword = userList.getUserByNumber(i).getPassword();
                        String eachUserphone = userList.getUserByNumber(i).getPhone();
                        String eachUserbirth = userList.getUserByNumber(i).getBirthday();
                        String eachUsermail = userList.getUserByNumber(i).getEmail();
                        if(!eachUsertype.equals("0")) {%>
                            <div>
                                <div class="<%=eachUsertype.equals("1")? "staff": "customer"%>">
                                    <h1><%=eachUsertype.equals("1")? "Staff": "Customer"%></h1>
                                    <h3>Account status: <span class="<%=eachUserstatus.equals("1")? "unlocked": "locked"%>"><%=eachUserstatus.equals("1")? "Active": "Locked"%></span></h3>
                                    <h3>User name: <%=eachUsername%> Password: <%=eachUserPassword%></h3>
                                    <h3>First name: <%=eachFirstname%> Last name: <%=eachLastname%></h3>
                                    <h3>Mail: <%=eachUsermail%></h3>
                                    <h3>Phone: <%=eachUserphone%></h3>
                                    <h3>Birth: <%=eachUserbirth%></h3>
                                </div>
                                <div class="<%=eachUsertype.equals("1")? "staff": "customer"%>">
                                    <form class="inline" method="post" action="update.jsp">
                                        <button type="submit" class="edit" name="username" value="<%=eachUsername%>" onclick="location.href='http://localhost:8080/IOTBay/update.jsp'">Edit</button>
                                    </form>
                                    <form class="inline" method="post" action="accountlist.jsp">
                                        <button type="submit" class="delete" name="delete" value="<%=eachUsername%>" onclick="location.href='http://localhost:8080/IOTBay/accountlist.jsp'">Delete</button>
                                    </form>
                                    <form class="inline" method="post" action="accountlist.jsp">
                                        <input type="hidden"  name ="username" value="<%=eachUsername%>">
                                        <button type="submit" class="<%=eachUserstatus.equals("1")? "lock": "actived"%>" name="status" value="<%=eachUserstatus%>" onclick="location.href='http://localhost:8080/IOTBay/accountlist.jsp'"><%=eachUserstatus.equals("1")? "Lock": "Active"%></button>
                                    </form>
                                </div>
                            </div>
                        <%}
                    }%>
                
            </section>
        <%}%>
    </body>
</html>
