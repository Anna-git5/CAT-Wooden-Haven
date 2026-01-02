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

<!DOCTYPE html>
<html>
<head>
    <title>Products - Wooden Haven</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f8f8;
            margin: 0;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: #3e2d24;
            font-weight: bold;
        }

        .products {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 25px;
        }

        .card {
            background: white;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            text-align: center;
        }
        .card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
            border-radius: 6px;
        }

        .card h3 {
            margin: 10px 0 5px;
            font-size: 16px;
        }

        .card p {
            font-size: 13px;
            color: #555;
        }

        .price {
            font-weight: bold;
            color: #3e2d24;
            margin: 8px 0;
        }

        .btn {
            display: inline-block;
            padding: 8px 12px;
            background: #3e2d24;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 13px;
        }

        .btn:hover {
            background: #563e30;
        }

        .back-link {
            text-decoration: none;
            color: #3e2d24;
            font-weight: bold;
            font-size: 14px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>

<div class="container">

    <div style="display:flex;
    justify-content: space-between;
    margin-bottom:20px;">
    <a href="<%= request.getContextPath() %>/home" class="back-link">
        ◀  Back to Home
    </a>

        <a href="<%= request.getContextPath() %>/products"
           class="back-link">
            View All Products
        </a>
    </div>

<h2>Products</h2>
    <div class="products" >

    <%
        List<Product> products = (List<Product>) request.getAttribute("products");
        if (products != null && !products.isEmpty()) {
            for (Product p : products) {
    %>
        <div class="card ">
            <img src="<%= request.getContextPath() %>/images/<%= p.getImageMain() %>"
        width= "120"
                 onerror="this.src='<%= request.getContextPath() %>/images/default.jpg'">

            <h3><%= p.getName() %></h3>
            <p><%= p.getDescription() %></p>

            <div class="price">RM <%= p.getPrice() %></div>

            <a href="<%= request.getContextPath() %>/product?id=<%= p.getProductId() %>"
               class="btn">View Product</a>

            </div>
    <%
            }
        } else {
    %>
        <p>No products found.</p>
    <%
        }
    %>

        </div>
        </div>

<jsp:include page="footer.jsp" />

</body>
</html>