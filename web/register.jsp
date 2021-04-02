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
            String redirectURL = "http://localhost:8080/assignment/welcome.jsp";
            
            boolean isRegisterButtonClicked = register != null ? true : false;
            
            boolean registerSuccessful = false;
            
            boolean isCustomerNameExist = false;
            String customerNameExistInfo = "Sorry, customer name already exists.";
            
            boolean passwordsDifferent = false;
            String passwordDiffInfo = "Error, passwords are different";
            
            if(customer != null) {
                response.sendRedirect(redirectURL);
            }else {
                if(register != null) {
                    String name = request.getParameter("uname");
                    String uPassword = request.getParameter("upassword");
                    String cPassword = request.getParameter("cupassword");
                    String email = request.getParameter("email");
                    String gender = request.getParameter("gender");
                    String birthday = request.getParameter("birthday");
                    String phone = request.getParameter("phone");
                    
                    if(uPassword.equals(cPassword)) {
                        if(!customerList.isCustomerNameExist(name)) {
                            //Create a new customer
                            Customer newCustomer = new Customer(name, uPassword, email, gender, birthday, phone);
                            
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
        <center> 
            <div>
                <h1>IoTBay Registration Page</h1> 
                <form action="register.jsp" method="post" id="register">
                    <table>
                        <tr>
                            <td>
                                <label for="uname">Username</label>
                            </td>
                            <td>
                                <input type="text" id="uname" name="uname" pattern="[A-Za-z]{5,}" title="Five or more [A-Z,a-z]">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="upassword">Password</label>
                            </td>
                            <td>
                                <input type="password" id="upassword" name="upassword" pattern=".{5,}" title="Five or more characters">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="cupassword">Confirm Password</label>
                            </td>
                            <td>
                                <input type="password" id="cupassword" name="cupassword" pattern=".{5,}" title="Five or more characters">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="email">Email</label>
                            </td>
                            <td>
                                <input type="mail" id="email" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="characters@characters.domain">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Gender
                            </td>
                            <td>
                                <input type="radio" id="male" name="gender" value="male">
                                <label for="male">Male</label>
                                <input type="radio" id="female" name="gender" value="female">
                                <label for="female">Female</label>
                                <input type="radio" id="other" name="gender" value="other">
                                <label for="other">Other</label>
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
                <button onclick="location.href='http://localhost:8080/assignment/'" class="button1">Cancel</button>
                <div><p>Already a customer? <a href="login.jsp">Login</a></p></div>
            </div>
            
            <!--the information of result of registration -->
            <%
            if(isRegisterButtonClicked) {
                if(!registerSuccessful) {
                    if(isCustomerNameExist) {%>
                        <p><%= customerNameExistInfo%></p>
                    <%}else if(passwordsDifferent) {%>
                        <p><%= passwordDiffInfo%></p>
                    <%}else {%>
                        <p>Should check the code logic</p>
                    <%}
                }
            }
            %>
                                   
        </center>

    </body>
</html>

