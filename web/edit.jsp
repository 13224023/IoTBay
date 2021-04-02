<%-- 
    Document   : edit
    Created on : 31/03/2021, 6:51:57 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Page</title>
    </head>
    <body>
        <%
            //Get data from session
            CustomerAccount customerList= (CustomerAccount) session.getAttribute("customerList");
            
            //Get data from the object
            Customer customer = customerList.getLoggedCustomer();
            
            //Store user info into variables
            String pName = customer.getUsername();
            String pEmail = customer.getEmail();
            String pBirthday = customer.getBirthday();
            String pPhone = customer.getPhone();
            
            //The variable is to check user presses update button or not 
            String updated = request.getParameter("updated");
            
            //The variables is to check to disply the update result
            boolean isCustomerEmpty = customer == null? true: false;
            boolean isUpdateSuccessful = false;
            boolean isUpdateOn = updated != null? true : false;
            
            //The variables is store the inforamtion of success or failure update
            String successInfo = "Update success.";
            String failureInfo = "Update Failure! Username already exists";
            
            if(isUpdateOn) {
                    String name = request.getParameter("uname");
                    String email = request.getParameter("email");
                    String gender = request.getParameter("gender");
                    String birthday = request.getParameter("birthday");
                    String phone = request.getParameter("phone");
                    
                    //create an object to initialise customer fields
                    Customer updatedCustomer = new Customer(name, customer.getPassword(), email, gender, birthday, phone);
                    
                    //enable the customer logging condition
                    updatedCustomer.setIsLogged(true);
                    
                    //update customer to list and check the functionality is successful or not
                    isUpdateSuccessful = customerList.updateCustomer(customer, updatedCustomer);
                    
                    //update session
                    session.setAttribute("customerList", customerList);
                    
            }
        %>
        <%if(isCustomerEmpty) {%>
            <h1>Unauthorized action</h1>
            <button onclick="location.href='http://localhost:8080/assignment/index.jsp'" class="button">Back to index page</button>
        <%}else {%>
            <center>
                <h1>Edit page </h1>
                <form action="edit.jsp" method="post" id="update">
                    <table>
                        <tr>
                            <td>
                                <label for="uname">Username</label>
                            </td>
                            <td>
                                    <input type="text" id="uname" name="uname" placeholder="Your username" pattern="[A-Za-z]{5}" title="Five or more [A-Z,a-z]" value="${pName}">
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <label for="email">Email</label>
                            </td>
                            <td>
                                <input type="mail" id="email" name="email" placeholder="Your email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="characters@characters.domain" value="${pEmail}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Gender
                            </td>
                            <td>
                                <input type="radio" id="male" name="gender" value="male" checked="checked">
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
                                <input type="date" id="birthday" name="birthday" value="${pBirthday}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="phone">Phone Number:</label>
                            </td>
                            <td>
                                <input type="tel" id="phone" placeholder="1234567890" name="phone" pattern="[0-9]{10}" title="Ten numbers" value="${pPhone}">
                            </td>
                        </tr>
                    </table>
                </form>
                <div>
                    <button type="submit" form="update" class="button" name="updated" value="updated">Update</button>
                    <button onclick="location.href='http://localhost:8080/assignment/profile.jsp'" class="button1">Cancel</button>
                </div>
                <div>
                    <p><span><%=isUpdateOn? isUpdateSuccessful? successInfo: failureInfo : ""%></span></p>
                </div>
            </center>
        <%}%>
            
    </body>
</html>
