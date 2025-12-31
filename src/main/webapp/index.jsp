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

        /* ===== CATEGORIES ===== */
        .categories {
            max-width: 1100px;
            margin: 60px auto;
            padding: 0 20px;
            display: flex;
            flex-direction: column;
            align-items: center;

        }

        .categories h2 {
            margin-bottom: 35px;
            font-size: 26px;
        }

        .category-grid {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
        }

        /*Category card*/
        .category-card {
            background: white;
            width: 220px;
            height: 260px;
            border-radius: 14px;
            text-align: center;
            box-shadow: 0 6px 16px rgba(0,0,0,0.08);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            cursor: pointer;
            height:220px;

            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .category-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 26px rgba(0,0,0,0.14);
        }

        .category-card img {
            width: 130px;
            height: 90px;
            object-fit:cover;
            margin-bottom: 10px;
            border-radius: 18px;
        }

        .category-card p {
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            line-height: 1.3;
        }

        /* ===== PRODUCTS ===== */
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

<!-- ===== CATEGORIES ===== -->
<div class="categories">
    <h2>Categories</h2>

    <div class="category-grid">
        <div class="category-card">
            <img src="<%= request.getContextPath() %>/images/category-1.jpg">
            <p>Living Room</p>
        </div>

        <div class="category-card">
            <img src="<%= request.getContextPath() %>/images/category-2.jpg">
            <p>Kitchen</p>
        </div>

        <div class="category-card">
            <img src="<%= request.getContextPath() %>/images/category-3.jpg">
            <p>Bedroom</p>
        </div>

        <div class="category-card">
            <img src="<%= request.getContextPath() %>/images/category-4.jpg">
            <p>Home Decor & Handicrafts</p>
        </div>
    </div>
</div>

<!-- ===== FEATURED PRODUCT ===== -->
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
