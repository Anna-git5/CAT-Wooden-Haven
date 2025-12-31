<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 31/12/2025
  Time: 8:32 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Product" %>
<%
    Product p = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f8f8;
            margin: 0;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            display: flex;
            gap: 40px;
        }

        .image img {
            width: 350px;
            border-radius: 6px;
            margin-bottom: 10px;
        }

        .details h2 {
            margin-top: 0;
        }

        .price {
            font-size: 22px;
            color: #3e2d24;
            font-weight: bold;
            margin: 15px 0;
        }

        .stock {
            margin-bottom: 15px;
            color: #555;
        }

        .btn {
            padding: 10px 18px;
            background: #3e2d24;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }

        .btn:hover {
            background: #563e30;
        }

        .qty {
            width: 60px;
            padding: 6px;
        }
    </style>
</head>

<body>

<div class="container">

    <!-- IMAGE SECTION -->
    <div class="image">
        <img src="<%= request.getContextPath() %>/images/<%= p.getImageMain() %>"
             onerror="this.src='<%= request.getContextPath() %>/images/default.jpg'">

        <% if (p.getImageSecond() != null) { %>
        <img src="<%= request.getContextPath() %>/images/<%= p.getImageSecond() %>"
             onerror="this.src='<%= request.getContextPath() %>/images/default.jpg'">
        <% } %>
    </div>

    <!-- DETAILS SECTION -->
    <div class="details">
        <h2><%= p.getName() %></h2>

        <div class="price">RM <%= p.getPrice() %></div>

        <div class="stock">
            Stock Available: <strong><%= p.getStock() %></strong>
        </div>

    <p><%= p.getDescription() %></p>

<form action="cart" method="<%= request.getContextPath() %>/cart" method="post">
    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
    Quantity:
    <input type="number" name="qty" value="1" min="1" max="<%= p.getStock() %>">

    <br><br>

    <button type="submit" class="btn">Add to Cart</button>
    </form>

        <br>
        <a href="<%= request.getContextPath() %>/products" class="btn">
            ← Back to Products
        </a>
    </div>

</div>

</body>
</html>
