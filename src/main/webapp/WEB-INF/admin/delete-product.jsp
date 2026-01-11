<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 11/1/2026
  Time: 2:26 pm
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
    <title>Delete Product</title>

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

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .delete-btn {
            width: 100%;
            padding: 12px;
            background: #b71c1c;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }
        .delete-btn:hover {
            background: #c62828;
        }
        .back-link {
            position: absolute;
            top: 20px;
            left: 20px;
            text-decoration: none;
            font-weight: bold;
            color: #3e2d24;
        }
    </style>
</head>
<body>

<a class="back-link" href="<%= request.getContextPath() %>/admin/dashboard">
    ◀ Back to Dashboard
</a>
<div class="container">
    <h2>Delete Product</h2>

    <form action="<%= request.getContextPath() %>/admin/delete-product"
          method="post"
          onsubmit="return confirm('Are you sure you want to delete this product?');">

        <input type="number" name="productId" placeholder="Enter Product ID" required>

        <button type="submit" class="delete-btn">
            Confirm Delete
        </button>
    </form>
</div>

</body>
</html>
