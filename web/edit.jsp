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
        <title>Edit Profile Page</title>
        <link rel="stylesheet" href="CSS/edit.css">
    </head>
    <body>
        <%
            //Get data from session
            //CustomerAccount customerList= (CustomerAccount) session.getAttribute("customerList");
            
            //Get data from the object
            Customer customer = (Customer)session.getAttribute("customer");
            
            String redirectURL = "http://localhost:8080/IOTBay/unauthorised.jsp";
            
            //Store user info into variables
            //String pName = customer.getUsername();
            String pFirstName = customer.getUserFirstName();
            String pLastName = customer.getUserLastName();
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
            String successInfo = "Successfully update";
            String failureInfo = "Update Failure! Check the code";
            
            if(isUpdateOn) {
                    //get data from html form
                    String firstName = request.getParameter("fname");
                    String lastName = request.getParameter("lname");
                    String email = request.getParameter("email");
                    String birthday = request.getParameter("birthday");
                    String phone = request.getParameter("phone");
                    
                    //update variables
                    pFirstName = firstName;
                    pLastName = lastName;
                    pEmail = email;
                    pBirthday = birthday;
                    pPhone = phone;
                    
                    
                    //create an object to initialise customer fields
                    Customer updatedCustomer = new Customer(customer.getUsername(), customer.getPassword(), customer.getEmail());
                    
                    //enable the customer logging condition
                    updatedCustomer.setIsLogged(true);
                    
                    //update customer profile
                    isUpdateSuccessful = updatedCustomer.setProfile(firstName, lastName , email, birthday, phone);
                    
                    //update customer to list and check the functionality is successful or not
                    //isUpdateSuccessful = customerList.updateCustomer(customer, updatedCustomer);
                    
                    //update session
                    session.setAttribute("customer", updatedCustomer);
                    
            }
        
            if(isCustomerEmpty) {
                response.sendRedirect(redirectURL);
        
            }else {%>
            <form class="box" action="edit.jsp" method="post" id="update">
                <h1>Edit Profile</h1>
                <input type="text" id="fname" name="fname" autocomplete="off" placeholder="First Name" value="<%=pFirstName%>">
                <input type="text" id="lname" name="lname" autocomplete="off" placeholder="Last Name" value="<%=pLastName%>">
                <input type="mail" id="email" name="email" autocomplete="off" placeholder="Email" value="<%=pEmail%>" required>
                <input type="date" id="birthday" name="birthday" autocomplete="off" value="<%=pBirthday%>" required>
                <input type="tel" id="phone" name="phone" autocomplete="off" placeholder="Phone Number" value="<%=pPhone%>">
                <input type="submit" form="update" name="updated" value="Update">
                <input type="button" value="Back" onclick="location.href='http://localhost:8080/IOTBay/profile.jsp'">
                <%
                if(isUpdateOn) {
                    if(isUpdateSuccessful) {%>
                        <p><%=successInfo%></p>
                    <%}else {%>
                        <p class="errorinfo"><%=failureInfo%></p>
                    <%}%>
                <%}%>
            </form>
        <%}%>
            
    </body>
</html>
