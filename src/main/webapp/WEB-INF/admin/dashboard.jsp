<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 30/12/2025
  Time: 7:35 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>

<h2>Admin Dashboard</h2>

<ul>
    <li><a href="<%= request.getContextPath() %>/admin/add-product">Add Product</a></li>
    <li><a href="<%= request.getContextPath() %>/products">View Products</a></li>
</ul>

</body>
</html>

