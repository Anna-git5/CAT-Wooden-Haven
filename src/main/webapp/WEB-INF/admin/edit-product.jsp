<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 9/1/2026
  Time: 8:35 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f8f8;
            margin: 0;
        }

        .container {
            max-width: 600px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
        }

        input, textarea, button {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 4px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .back-link {
            position: absolute;
            top: 20px;
            left: 20px;
            text-decoration: none;
            font-weight: bold;
            color: #3e2d24;
            font-size: 14px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        button {
            background: #3e2d24;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background: #563e30;
        }

        .error {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<a class="back-link" href="<%= request.getContextPath() %>/admin/dashboard">
    ◀ Back to Dashboard
</a>

<div class="container">
    <h2>Edit Product</h2>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <%
        Product p = (Product) request.getAttribute("product");
        if (p == null) {
    %>
        <form method="get" action="<%= request.getContextPath() %>/admin/edit-product">
            <input type="number" name="productId" placeholder="Enter Product ID" required>
            <button type="submit">Load Product</button>
        </form>
    <%
        } else {
    %>
        <form method="post">
            <input type="hidden" name="productId" value="<%= p.getProductId() %>">
            <input type="text" name="name" value="<%= p.getName() %>" required>
            <textarea name="description" rows="4" required><%=
                p.getDescription() != null ? p.getDescription().trim() : ""
            %></textarea>

            <input type="number" step="0.01" name="price" value="<%= p.getPrice() %>" required>
            <input type="number" name="stock" value="<%= p.getStock() %>" required>
            <button type="submit">Save Changes</button>
        </form>
    <%
        }
    %>
</div>

</body>
</html>
