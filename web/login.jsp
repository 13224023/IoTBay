<%-- 
    Document   : login
    Created on : 
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/login.css">
        <title>Login</title>
    </head>
    <body>
        <%
            CustomerAccount customerList = (CustomerAccount) session.getAttribute("customerList");
            Customer customer = customerList.getLoggedCustomer();
            String login = request.getParameter("login");
            String redirectURL = "http://localhost:8080/assignment/welcome.jsp";
            
            boolean isCustomerEmpty = customer == null? true : false;
            boolean isLoginButtonClicked = login != null? true : false;
            
            boolean loginSuccessful = false;
            
            if(!isCustomerEmpty) {
                response.sendRedirect(redirectURL);
            }else {
                if(login != null) {
                    String name = request.getParameter("uname");
                    String password = request.getParameter("upassword");
                    loginSuccessful = customerList.setCustomerLogged(name, password);
                    if(loginSuccessful) {
                        session.setAttribute("customerList", customerList);
                        response.sendRedirect(redirectURL);
                    }
                }
            }
            
        %>
        <center>
            <div>
                <h1>IoTBay Login Page</h1> 
                <form action="login.jsp" method="get" id="login">
                    <table>
                        <!-- ask user to input username-->
                        <tr>
                            <td>
                                <label for="uname">Username</label>
                            </td>
                            <td>
                                <input type="text" id="uname" name="uname" pattern="[A-Za-z]{5,}" title="Five or more [A-Z,a-z]">
                            </td>
                        <!-- ask user to input password-->
                        <tr>
                            <td>
                                <label for="upassword">Password</label>
                            </td>
                            <td>
                                <input type="password" id="upassword" name="upassword" pattern=".{5,}" title="Five or more characters">
                            </td>
                        </tr>

                        <tr>
                            <!-- submit button-->
                            <td>
                                <button type="submit" form="login" class="button" name="login" value="login">Login</button>
                            </td>
                            <!-- a link to register.jsp page-->
                            <td>
                                Not yet a Customer? <a href="register.jsp">Register</a>
                            </td>
                        </tr>
                    </table>
                </form>
                <p><%= isLoginButtonClicked? loginSuccessful? "": "Error: Username and password wrong." :"" %></p>
            </div>
        <center>
    </body>
</html>
