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
        body { font-family: Arial; background:#f8f8f8; margin:0 }
        .container { max-width:900px; margin:40px auto; background:white;
            padding:30px; border-radius:8px;box-shadow:0 4px 10px rgba(0,0,0,0.1); }
        table { width:100%; border-collapse:collapse; }
        th, td { padding:12px; border-bottom:1px solid #ddd; text-align:center; }
        th { background:#f1f1f1; }
        img { width:80px;border-radius:4px; }
        .total { font-size:18px; font-weight:bold; text-align:right;margin-top:20px; }
        .btn { padding:8px 14px; background:#3e2d24; color:white;
            text-decoration:none; border-radius:4px;border:none;cursor:pointer; }
        .btn:hover {
            background:#563e30;
        }
        .actions {
            display:flex;
            justify-content:space-between;
            margin-top:25px;
        }
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
            <th>Action</th>
        </tr>

        <% for (CartItem item : cart) {
            total += item.getTotalPrice();
        %>
        <tr>
            <td>
                <img src="<%= request.getContextPath() %>/images/<%= item.getProduct().getImageMain() %>">
            </td>
            <td><%= item.getProduct().getName() %></td>
            <td><%= item.getQuantity() %></td>
            <td>RM <%= item.getProduct().getPrice() %></td>
            <td>RM <%= item.getTotalPrice() %></td>
            <td>
                <form action="<%= request.getContextPath() %>/cart" method="post">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="productId"
                           value="<%= item.getProduct().getProductId() %>">
                    <button class="btn" type="submit">Remove</button>
                </form>
            </td>
        </tr>
        <% } %>

    </table>

    <p class="total">Total: RM <%= total %></p>

    <div class="actions">
        <a class="btn" href="<%= request.getContextPath() %>/products">
            Continue Shopping
        </a>
        <a class="btn" href="#">
            Checkout
        </a>
    </div>

    <% } %>

</div>

</body>
</html>
