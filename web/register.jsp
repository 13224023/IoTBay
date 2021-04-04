<%-- 
    Document   : register
    Created on : 
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/register.css">
        <title>Register Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    </head>
    <body class="back">
        <%
            CustomerAccount customerList= (CustomerAccount) session.getAttribute("customerList");
            Customer customer = customerList.getLoggedCustomer();
            
            String register = request.getParameter("register");
            String redirectURL = "http://localhost:8080/assignment1/welcome.jsp";
            
            boolean isRegisterButtonClicked = register != null ? true : false;
            
            boolean registerSuccessful = false;
            
            boolean isCustomerNameExist = false;
            String customerNameExistInfo = "Sorry, user name already exists";
            
            boolean passwordsDifferent = false;
            String passwordDiffInfo = "Sorry, passwords are different";
            
            if(customer != null) {
                response.sendRedirect(redirectURL);
            }else {
                if(register != null) {
                    String name = request.getParameter("uname");
                    String uPassword = request.getParameter("upassword");
                    String cPassword = request.getParameter("cupassword");
                    String email = request.getParameter("email");
                    /*
                    String birthday = request.getParameter("birthday");
                    String phone = request.getParameter("phone");
                    */
                    if(uPassword.equals(cPassword)) {
                        if(!customerList.isCustomerNameExist(name)) {
                            //Create a new customer
                            Customer newCustomer = new Customer(name, uPassword, email);
                            
                            //Set the customer is logged.
                            newCustomer.setIsLogged(true);
                            
                            //store the result of the registration into variable
                            registerSuccessful = customerList.setAnCustomer(newCustomer);
                        }
                        else {
                            isCustomerNameExist = true;
                        }
                    }
                    else {
                        passwordsDifferent = true;
                    }
                    
                    if(registerSuccessful) {
                        session.setAttribute("customerList", customerList);
                        response.sendRedirect(redirectURL);
                    }
                }
            }
            
        %>
        <form class="box" action="register.jsp" method="post" id="register">
            <h1>Register</h1>
            <input type="text" id="uname" name="uname" autocomplete="off" placeholder="Username" required>
            <input type="password" id="upassword" name="upassword" autocomplete="off" placeholder="Password" required>
            <input type="password" id="cupassword" name="cupassword" autocomplete="off" placeholder="Confirm Password" required>
            <input type="mail" id="email" name="email" autocomplete="off" placeholder="xxx@xxx.xxx" required>
            <!--
            <input type="date" id="birthday" name="birthday" autocomplete="off" placeholder="DD/MM/YYYY" required>
            <input type="tel" id="phone" name="phone" autocomplete="off" placeholder="1234567890" required>
            -->
            <input type="submit" form="register" name="register" value="Register">
            <input type="button" value="Back" onclick="location.href='http://localhost:8080/assignment1/'">
            <p> Already a Customer? <a href="login.jsp">Login</a></p>
            <%
            if(isRegisterButtonClicked) {
                if(!registerSuccessful) {
                    if(isCustomerNameExist) {%>
                        <p class="errorinfo"><%= customerNameExistInfo%></p>
                    <%}else if(passwordsDifferent) {%>
                        <p class="errorinfo"><%= passwordDiffInfo%></p>
                    <%}else {%>
                        <p class="errorinfo">Should check the code logic</p>
                    <%}
                }
            }
            %>
        </form>
        <!--
        <nav>
            <label class="logo">Register</label>
        </nav>
            
        <center>
            <section>
                <div>
                    <form action="register.jsp" method="post" id="register">
                        <table>
                            <tr>
                                <td>
                                    <label for="uname">Username</label>
                                </td>
                                <td>
                                    <input type="text" id="uname" name="uname" autocomplete="off" required>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="upassword">Password</label>
                                </td>
                                <td>
                                    <input type="password" id="upassword" name="upassword">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="cupassword">Confirm Password</label>
                                </td>
                                <td>
                                    <input type="password" id="cupassword" name="cupassword">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="email">Email</label>
                                </td>
                                <td>
                                    <input type="mail" id="email" name="email">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="birthday">Date of birth:</label>
                                </td>
                                <td>
                                    <input type="date" id="birthday" name="birthday">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="phone">Phone Number:</label>
                                </td>
                                <td>
                                    <input type="tel" id="phone" placeholder="1234567890" name="phone" pattern="[0-9]{10}" title="Ten numbers">
                                </td>
                            </tr>
                        </table>
                    </form>

                    <button type="submit" form="register" class="button" name="register" value="register">Submit</button>
                    <button onclick="location.href='http://localhost:8080/assignment1/'" class="button1">Cancel</button>
                    <div><p>Already a customer? <a href="login.jsp">Login</a></p></div>
                </div>
                
            </section>
            
            
        
            
        </center>
        -->
    </body>
</html>

