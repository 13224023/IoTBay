<%-- 
    Document   : changepassword
    Created on : 02/04/2021, 10:11:04 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.isd.model.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password Page</title>
    </head>
    <body>
        
    <%
        CustomerAccount customerList= (CustomerAccount) session.getAttribute("customerList");
        Customer customer = customerList.getLoggedCustomer();
        
        String change = request.getParameter("change");
        String username = customer.getUsername();
        
        boolean isCustomerEmpty = customer != null? false : true;
        boolean isChangeButtonClicked = change != null? true : false;
        boolean isPasswordsDifference = false;
        boolean isCurrentPasswordWrong = false;
        boolean isPasswordUpdated = false;
        if(isChangeButtonClicked) {
            String pPassword = request.getParameter("ppassword");
            String nPassword = request.getParameter("npassword"); 
            String cPassword = request.getParameter("cpassword");
            if(customer.getPassword().equals(pPassword)) {
                if(nPassword.equals(cPassword)) {
                    Customer updateCustomer = customer;
                    updateCustomer.setPassword(nPassword);
                    isPasswordUpdated = customerList.updateCustomer(customer, updateCustomer);
                    session.setAttribute("customerList", customerList);
                }else {
                    isPasswordsDifference = true;
                }
            }else {
                isCurrentPasswordWrong = true;
            } 
        }
    %>
    
    <%if(isCustomerEmpty) {%>
        <h1>Unauthorized action</h1>
        <button onclick="location.href='http://localhost:8080/assignment/index.jsp'" class="button">Back to index page</button>
    <%}else {%>
        <center>
            <h1>Change Password</h1>
            <form action="changepassword.jsp" method="post" id="change">
                <table>
                    <tr>
                        <td>
                            <label for="ppassword">Current Password</label>
                        </td>
                        <td>
                            <input type="password" id="ppassword" name="ppassword" pattern=".{5,}" title="Five or more characters">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="npassword">New Password</label>
                        </td>
                        <td>
                            <input type="password" id="npassword" name="npassword" pattern=".{5,}" title="Five or more characters">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="cpassword">Confirm Password</label>
                        </td>
                        <td>
                            <input type="password" id="cpassword" name="cpassword" pattern=".{5,}" title="Five or more characters">
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="change" value="change">
            </form>
            <div>
                    <button type="submit" form="change" class="button" name="change" value="change">Confirm</button>
                    <button onclick="location.href='http://localhost:8080/assignment/profile.jsp'" class="button1">Cancel</button>
            </div>
            <div>
                <%if(isChangeButtonClicked) {
                    if(isCurrentPasswordWrong) {%>
                        <p>Sorry, Your current password is wrong</p>
                    <%}else if(isPasswordsDifference) {%>
                        <p>Sorry, Your new and confirm passwords are not the same</p>
                    <%}else if (isPasswordUpdated) {%>
                        <p>Your password is updated</p>
                    <%}else {%>
                        <p>Unknown error. Need to check code</p>
                    <%}
                }%>
            </div>
        </center>
    <%}%>
    
    </body>
</html>
