<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 31/12/2025
  Time: 8:32 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="model.Product" %>
<%
    Product p = (Product) request.getAttribute("product");
%>

<h2><%= p.getName() %></h2>

<img src="images/<%= p.getImageMain() %>" width="300">
<img src="images/<%= p.getImageSecond() %>" width="100">

<p><%= p.getDescription() %></p>
<p><b>RM <%= p.getPrice() %></b></p>
<p>Stock: <%= p.getStock() %></p>

<form action="cart" method="post">
    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
    Quantity:
    <input type="number" name="qty" value="1" min="1" max="<%= p.getStock() %>">
    <button type="submit">Add to Cart</button>
</form>
