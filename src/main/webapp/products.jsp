<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 29/12/2025
  Time: 7:32 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<html>
<head>
    <title>Products - Wooden Haven</title>
</head>
<body>

<h2>Wooden Products</h2>

<table border="1" cellpadding="8">
    <tr>
        <th>Image</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price (RM)</th>
    </tr>

    <%
        List<Product> products = (List<Product>) request.getAttribute("products");
        if (products != null) {
            for (Product p : products) {
    %>
    <tr>
        <td>
            <img
                    src="<%= request.getContextPath() %>/images/<%= p.getImage() %>">
        width= "120"
            onerror="this.src='<%= request.getContextPath() %>/images/default.jpg'">
        </td>

        <td><%= p.getName() %></td>
        <td><%= p.getDescription() %></td>
        <td><%= p.getPrice() %></td>
    </tr>
    <%
            }
        }else {
    %>
    <tr>
        <td colspan="4">No products available.</td>
    </tr>
    <%
        }
    %>

</table>

</body>
</html>