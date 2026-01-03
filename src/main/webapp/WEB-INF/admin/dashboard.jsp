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
            margin-bottom: 10px;
        }

        li {
            margin-bottom: 15px;
        }

        .dashboard-btn {
            display: block;
            width: 100%;
            padding: 12px;
            background: #3e2d24;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
            font-size: 16px;
            border: none;
            cursor: pointer;
            box-sizing: border-box;
        }

        .dashboard-btn:hover {
            background: #563e30;
        }

        /* Delete form */
        .delete-form {
            display: none;
            margin-top: 15px;
        }

        .delete-form input {
            width: 100%;
            padding: 12px;
            margin-bottom: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            font-size: 14px;
        }

        .confirm-btn {
            width: 100%;
            background: #b71c1c;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            box-sizing: border-box;
        }

        .confirm-btn:hover {
            background: #c62828;
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
    </style>
</head>

<body>

<a class="back-link" href="<%= request.getContextPath() %>/home">
    ◀ Back to Homepage
</a>

<div class="container">
    <h2>Admin Dashboard</h2>

    <ul>
        <li>
            <a class="dashboard-btn" href="<%= request.getContextPath() %>/admin/stock">
                Update Stock
            </a>
        </li>
        <li>
            <a class="dashboard-btn" href="<%= request.getContextPath() %>/admin/add-product">
                Add New Product
            </a>
        </li>
        <li>
            <a class="dashboard-btn" href="<%= request.getContextPath() %>/admin/edit-product">
                Edit Product
            </a>
        </li>
    </ul>

    <!-- DELETE PRODUCT BUTTON -->
    <button class="dashboard-btn" type="button" onclick="showDeleteForm()">
        Delete Product
    </button>

    <!-- DELETE FORM -->
    <form id="deleteForm" class="delete-form" action="<%= request.getContextPath() %>/admin/delete-product" method="post" onsubmit="return confirm('Are you sure you want to delete this product?');">
        <input type="number" name="productId" placeholder="Enter Product ID to delete" required>
        <button type="submit" class="confirm-btn">
            Confirm Delete
        </button>
    </form>

</div>

<script>
    function showDeleteForm() {
        document.getElementById("deleteForm").style.display = "block";
    }
</script>

</body>
</html>

