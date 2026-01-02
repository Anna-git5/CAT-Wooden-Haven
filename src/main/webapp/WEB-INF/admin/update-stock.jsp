<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 2/1/2026
  Time: 7:58 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Stock</title>
    <style>
        body {
            font-family: Arial;
            background:#f8f8f8;
            margin:0;
        }
        .container {
            max-width:900px;
            margin:40px auto;
            background:white;
            padding:30px;
            border-radius:8px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        table {
            width:100%;
            border-collapse:collapse;
        }
        th, td {
            padding:12px;
            border-bottom:1px solid #ddd;
            text-align:center;
        }
        th {
            background:#eee;
        }
        input[type=number] {
            width:80px;
            padding:6px;
        }
        .btn {
            padding:6px 12px;
            background:#3e2d24;
            color:white;
            border:none;
            border-radius:4px;
            cursor:pointer;
        }
        .btn:hover {
            background: #563e30;
        }
        .back {
            display: inline-block;
            margin-bottom: 15px;
            text-decoration: none;
            color: #3e2d24;
            font-weight: bold;
        }
        .msg {
            text-align: center;
            color: green;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<div class="container">
    <!-- Back to dashboard -->
    <a class="back-link" href="<%= request.getContextPath() %>/admin/dashboard">
        ◀ Back to Dashboard
    </a>

        <h2>Update Product Stock</h2>

    <!-- Success message -->
    <% if ("true".equals(request.getParameter("success"))) { %>
    <div class="msg">Stock updated successfully!</div>
    <% } %>

    <table>
        <tr>
            <th>ID</th>
            <th>Product</th>
            <th>Current Stock</th>
            <th>New Stock</th>
            <th>Action</th>
        </tr>

        <%
            List<Product> products = (List<Product>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
            for (Product p : products) {
        %>
        <tr>
            <td colspan="5">
            <form action="<%= request.getContextPath() %>/admin/stock" method="post"
                  style="display:grid;
                          grid-template-columns: 80px 1fr 140px 140px 120px;
                          align-items:center;
                          gap:10px;">

            <span><%=p.getProductId() %></span>
            <span><%= p.getName() %></span>
            <span><%= p.getStock() %></span>

                    <input type="hidden" name="productId"
                           value="<%= p.getProductId() %>">
                    <input type="number" name="stock"
                           value="<%= p.getStock() %>" min="0">

                <button type="submit" class ="btn" >Update</button>
            </form>
        </tr>
        <% }
        } else {
        %>
        <tr>
            <td colspan="5">No products found.</td>
        </tr>
            <%
        }
        %>
    </table>

</div>

</body>
</html>
