<%-- 
    Document   : cart
    Created on : 27/04/2021, 2:35:34 PM
    Author     : Administrator
--%>

<%@page import="uts.isd.model.ProductList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/cart.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <title>My Cart</title>
    </head>
    <body>
        <%  
            ProductList availableProductList = (ProductList) session.getAttribute("availableProductList");
            ProductList cartProductList = (ProductList) session.getAttribute("cartProductList");
            if(cartProductList == null) cartProductList = new ProductList();
            //if(cartProductList == null) cartProductList = new ProductList();
            //String productStockErr = (String) session.getAttribute("productStockErr");
            //String successInfo = (String) session.getAttribute("successInfo");
        %>
        <nav class="customer">
            <input type="checkbox" id="check">
            <label for="check" class="checkbtn">
                <i class="fas fa-bars"></i>
            </label>
            <label class="logo">My Cart</label>
            <ul>
                <li><a href="">Record To Order</a></li>
                <li><a href="WelcomeController">Back</a></li>
            </ul>
        </nav>
        <section>
            
            <div>
                <form class="keyword" method="post" action="">
                    <input type="text" class="search" name="keyword" autocomplete="off" placeholder="Product name or type">
                    <button type="submit" class="submit" name="filter" value="search">Search</button>
                </form>
            </div>
            
            <%if(cartProductList.listSize() == 0) {%>
                <div>
                    <h1>No Product in Cart</h1>
                </div>
            <%}else {%>
                <%for (int i = 0; i < cartProductList.listSize(); i++) {
                int productNo = cartProductList.getProductByIndex(i).getProductNo();
                String name = cartProductList.getProductByIndex(i).getName();
                String type = cartProductList.getProductByIndex(i).getType();
                int price = cartProductList.getProductByIndex(i).getPrice();
                int stock = cartProductList.getProductByIndex(i).getStock();
                %>
                <div>
                    <div class="<%=type.toLowerCase()%>">
                        <h1><%=type.toUpperCase()%></h1>
                    </div>
                    <div class="<%=type.toLowerCase()%>">
                        <h3>Product Name: <%=name%></h3>
                        <h3>Product Price: <%=price%></h3>
                        <h3>Maximum Available Quantity: <%=stock + availableProductList.getQuantityByProductNo(productNo)%></h3>
                    </div>
                    <div class="<%=type.toLowerCase()%>">
                        <form method="post" action="">
                            <label class="inline" for="<%=productNo%>"><h3>Order: </h3></label>
                            <input class="inline" type="text" id="<%=productNo%>" name="quantity" value="<%=stock%>" placeholder="Number">
                            <button class="edit inline" type="submit" name="add" value="<%=i%>">Update</button>
                            <button class="delete inline" type="submit" name="delete" value="<%=i%>">Delete</button>
                        </form>
                    </div>
                </div>
                <%}%>
            <%}%>
            
            
        </section>
    </body>
</html>
