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
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            text-align: center;

            transition: transform 0.3s ease,
                        box-shadow  0.3s ease;

            will-change: transform;
        }
        .card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
            border-radius: 6px;
            transition:transform 0.35s ease ;
        }

        .card:hover img {
            transform: scale(1.04);
        }

        .card h3 {
            margin: 10px 0 5px;
            font-size: 16px;
        }

        .card p {
            font-size: 13px;
            color: #777;
            line-height: 1.5;

            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
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

        .products-toolbar input:focus {
            outline: none;
            border-color: #3e2d24;
        }

        .products-toolbar button:hover {
            background: #563e30;
        }

        .back-link.light {
            color: #f5ede7;
            font-weight: bold;
        }

        .back-link.light:hover {
            text-decoration: underline;
        }

        .products-page-header {
            max-width: 1200px;
            margin: 30px auto 10px;
            padding: 0 20px;
            order-bottom: 1px solid #eee;
            padding-bottom: 35px;
        }

        .products-top-links {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
        }

        .products-top-links a {
            color: #3e2d24;
            font-weight: 600;
            text-decoration: none;
            font-size: 14px;
        }
        .products-top-links a:hover {
            text-decoration: underline;
        }

        .products-title {
            text-align: center;
            font-size: 26px;
            color: #3e2d24;
            margin-bottom: 20px;
        }
        .products-title span {
            position: relative;
            font-size: 28px;
            font-weight: 700;
            color: #3e2d24;
            padding: 6px 18px;
            z-index: 1;
        }
        .products-title span::before {
            content: "";
            position: absolute;
            left: -10px;
            right: -10px;
            top: 50%;
            transform: translateY(-50%);
            height: 80%;
            background : linear-gradient(
                    to right,
                    rgba(62,45,36,0.18),
                    rgba(62,45,36,0.08)
            );
            border-radius: 999px;
            z-index: -1;
        }

        .products-toolbar {
            display: flex;
            justify-content: center;
            margin-bottom: 8px;
        }

        .products-toolbar form {
            display: flex;
            gap: 10px;
            width: 100%;
            max-width: 520px;
        }

        .products-toolbar input {
            flex: 1;
            padding: 12px 14px;
            border-radius: 999px;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        .products-toolbar input:focus {
            outline: none;
            border-color: #3e2d24;
        }

        .products-toolbar button {
            padding: 12px 18px;
            background: #5a3e30;
            color: white;
            border: none;
            border-radius: 999px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }

        .products-toolbar button:hover {
            background: #6f4a39;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.12);
        }

    </style>
</head>
<body>

<div class="container">
    <div class="products-page-header">

        <div class="products-top-links">
            <a href="<%= request.getContextPath() %>/home">◀ Back to Home</a>
            <a href="<%= request.getContextPath() %>/products">View All Products</a>
        </div>

        <div class="products-title">
            <span>Products</span>
        </div>

        <div class="products-toolbar">
            <form action="<%= request.getContextPath() %>/products" method="get">
                <input type="text" name="search"
                       placeholder="Search products..."
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">

                <% if (request.getParameter("category") != null) { %>
                <input type="hidden" name="category"
                       value="<%= request.getParameter("category") %>">
                <% } %>

                <button type="submit">Search</button>
            </form>
        </div>

    </div>

    <div class="container">
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