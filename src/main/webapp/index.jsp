<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html>
<head>
    <title>WoodenHaven</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f8f8f8;
        }

        /* ===== TOP HEADER ===== */
        .top-header {
            background: #3e2d24;
            color: white;
            padding: 12px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
        }

        .search-bar {
            flex: 1;
            margin: 0 30px;
        }

        .search-bar input {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: none;
            font-size: 14px;
        }

        .nav-links a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
            font-weight: bold;
        }

        .nav-links a:hover {
            text-decoration: underline;
        }

        /* ===== HERO ===== */
        .hero {
            background: url("<%= request.getContextPath() %>/images/hero.jpg") center/cover no-repeat;
            height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 32px;
            font-weight: bold;
        }

        /* ===== CONTENT ===== */
        .container {
            padding: 40px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        /* ===== PRODUCTS GRID ===== */
        .products {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .card {
            background: white;
            padding: 15px;
            width: 220px;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            text-align: center;
        }

        .card img {
            width: 100%;
            height: 140px;
            object-fit: cover;
            border-radius: 4px;
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
            margin-top: 8px;
            color: #3e2d24;
        }

        .view-btn {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 12px;
            background: #3e2d24;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 13px;
        }

        .view-btn:hover {
            background: #563e30;
        }
    </style>
</head>

<body>

<!-- ===== HEADER ===== -->
<div class="top-header">
    <div class="logo">WoodenHaven</div>

    <div class="search-bar">
        <input type="text" placeholder="Search for products...">
    </div>

    <div class="nav-links">
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
        <a href="#">🛒 Cart</a>
    </div>
</div>

<!-- ===== HERO ===== -->
<div class="hero">
    Timeless Craft. Modern Comfort.
</div>

<!-- ===== CONTENT ===== -->
<div class="container">

    <h2>Top Products </h2>

    <div class="products">
        <%
            List<Product> featuredProducts =
                    (List<Product>) request.getAttribute("featuredProducts");

            if (featuredProducts != null && !featuredProducts.isEmpty()) {
                for (Product p : featuredProducts) {
        %>
        <div class="card">

            <img src="<%= request.getContextPath() %>/images/<%= p.getImageMain() %>"
                 onerror="this.src='<%= request.getContextPath() %>/images/default.jpg'">

            <h3><%= p.getName() %></h3>
            <p><%= p.getDescription() %></p>

            <div class="price">RM <%= p.getPrice() %></div>

            <a href="product?id=<%= p.getProductId() %>" class="view-btn">
                View Product
            </a>
        </div>
        <%
            }
        } else {
        %>
        <p style="text-align:center;">No featured products available.</p>
        <%
            }
        %>
    </div>

</div>

</body>
</html>
