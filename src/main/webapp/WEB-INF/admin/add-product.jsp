<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 30/12/2025
  Time: 7:32 am
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Add Product</title>
</head>
<body>

<h2>Add New Product</h2>

<form method="post" action="<%= request.getContextPath() %>/admin/add-product">
    <label>Product Name:</label><br>
    <input type="text" name="name" required><br><br>

    <label>Description:</label><br>
    <textarea name="description" row="4" required></textarea><br><br>

    <label>Price (RM):</label><br>
    <input type="number" step="0.01" name="price" required><br><br>

    <label>Image File Name :</label><br>
    <input type="text" name="image" placeholder="example: chair.jpg"><br><br>

    <button type="submit">Add Product</button>
</form>

</body>
</html>

