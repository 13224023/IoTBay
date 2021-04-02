<%-- 
    Document   : accountlist
    Created on : 01/04/2021, 5:38:15 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account List</title>
    </head>
    <body>
        <%
            CustomerAccount customerList = (CustomerAccount)session.getAttribute("customerList");
            int customerListSize = customerList.getCustomerAccountNumber();
        %>
        <center>
            <table>
                <tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Email</th>
                    <th>Gender</th>
                    <th>Birthday</th>
                    <th>Phone</th>
                </tr>
                <%for (int i = 0; i < customerListSize; i++) {%>
                    <tr>
                        <td><%=customerList.getCustomerByNumber(i).getUsername()%></td>
                        <td><%=customerList.getCustomerByNumber(i).getPassword()%></td>
                        <td><%=customerList.getCustomerByNumber(i).getEmail()%></td>
                        <td><%=customerList.getCustomerByNumber(i).getGender()%></td>
                        <td><%=customerList.getCustomerByNumber(i).getBirthday()%></td>
                        <td><%=customerList.getCustomerByNumber(i).getPhone()%></td>
                    </tr>
                <%}%>
            </table>
        </center>
        
    </body>
</html>
