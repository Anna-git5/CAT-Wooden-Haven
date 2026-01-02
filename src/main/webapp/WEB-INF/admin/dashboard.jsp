<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 30/12/2025
  Time: 7:35 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"ADMIN".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f8f8;
            margin: 0;
            padding: 0;
            position: relative;
        }

        .top-bar a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .top-bar a:hover {
            text-decoration: underline;
        }

        .container {
            max-width: 600px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        li {
            margin-bottom: 15px;
        }

        a {
            display: block;
            padding: 12px;
            background: #3e2d24;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
        }

        a:hover {
            background: #563e30;
        }

    </style>

        <a href="<%= request.getContextPath() %>/home"
           style="
           position: absolute;
           top: 20px;
           left: 20px;
           text-decoration: none;
           font-weight: bold;
           color: #3e2d24;
           font-size: 14px;
           background: none;
       ">
            ◀ Back to Homepage
        </a>
    </div>

    </head>

<body>

<div class="container">
    <h2>Admin Dashboard</h2>
    <ul>
        <li><a  href="<%= request.getContextPath() %>/admin/stock">Update Stock</a></li>
        <li><a href="<%= request.getContextPath() %>/admin/add-product">Add New Product</a></li>
        <li><a href="<%= request.getContextPath() %>/admin/edit-product">Edit Product</a></li>
        <li><a href="<%= request.getContextPath() %>/admin/delete-product">Delete Product</a></li>
    </ul>

</div>

</body>
</html>

