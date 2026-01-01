<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 1/1/2026
  Time: 8:21 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>

    <style>
        body { font-family: Arial; background:#f8f8f8; }
        .container { max-width:900px; margin:40px auto; background:white;
            padding:30px; border-radius:8px; }
        table { width:100%; border-collapse:collapse; }
        th, td { padding:12px; border-bottom:1px solid #ddd; text-align:center; }
        th { background:#f1f1f1; }
        img { width:80px; }
        .total { font-size:18px; font-weight:bold; text-align:right; }
        .btn { padding:8px 14px; background:#3e2d24; color:white;
            text-decoration:none; border-radius:4px; }
    </style>
</head>

<body>

<div class="container">
    <h2>Your Cart</h2>

    <%
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double total = 0;
    %>

    <% if (cart == null || cart.isEmpty()) { %>
    <p>Your cart is empty.</p>
    <% } else { %>

    <table>
        <tr>
            <th>Image</th>
            <th>Product</th>
            <th>Qty</th>
            <th>Price</th>
            <th>Subtotal</th>
        </tr>

        <% for (CartItem item : cart) {
            total += item.getSubtotal();
        %>
        <tr>
            <td>
                <img src="<%= request.getContextPath() %>/images/<%= item.getProduct().getImageMain() %>">
            </td>
            <td><%= item.getProduct().getName() %></td>
            <td><%= item.getQuantity() %></td>
            <td>RM <%= item.getProduct().getPrice() %></td>
            <td>RM <%= item.getSubtotal() %></td>
        </tr>
        <% } %>

    </table>

    <p class="total">Total: RM <%= total %></p>

    <a href="<%= request.getContextPath() %>/products" class="btn">
        Continue Shopping
    </a>

    <% } %>

</div>

</body>
</html>
