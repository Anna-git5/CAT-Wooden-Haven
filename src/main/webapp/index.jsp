<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<html>
<head>
    <title>WoodenHaven</title>

    <style>
        body {
            font-family: Arial;
            font-size: 15px;
            margin: 0;
            background: #f8f8f8;
            font-weight: bold;
        }
        .header {
            background: #3e2d24;
            color: white;
            /*padding: 5px;*/
            height: 50px;
            text-align: center;
        }
        .hero {
            background: url("images/hero.jpg") center/cover no-repeat;
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 32px;
            font-weight: bold;
            font-family: "Arial";
        }
        .container {
            padding: 40px;
            text-align: center;
        }

        .products {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .card {
            background: white;
            padding: 20px;
            width: 220px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        .btn {
            padding: 12px 25px;
            background: #3e2d24;
            color: white;
            text-decoration: none;
            margin: 10px;
            display: inline-block;
        }
        .btn:hover {
            background: #563e30;
        }
    </style>
</head>

<body>

<div class="header">
    <h1>WoodenHaven</h1>
</div>

<div class="hero">
    Timeless Craft. Modern Comfort.
</div>

<div class="container">

    <%
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
    %>

    <% if (username == null) { %>

    <h2>Welcome to WoodenHaven</h2>
    <p>Discover premium handcrafted wooden furniture.</p>

    <a href="login.jsp" class="btn">Login</a>
    <a href="register.jsp" class="btn">Register</a>
    <a href="products" class="btn">View Products</a>

    <% } else { %>

    <h2>Welcome, <%= username %> 👋</h2>

    <% if ("ADMIN".equals(role)) { %>
    <a href="<%= request.getContextPath() %>/admin/add-product" class="btn">
        Admin Panel
    </a>
    <% } %>

    <a href="products" class="btn">Browse Products</a>
    <a href="logout" class="btn">Logout</a>

    <% } %>

    <hr>
    <h2 style="text-align: center">Featured Products</h2>

    <div class="products">
        <%
            List<Product> featuredProducts =
                    (List<Product>) request.getAttribute("featuredProducts");

            if (featuredProducts != null && !featuredProducts.isEmpty()) {
                for (Product p : featuredProducts) {
        %>
            <div class="card">
                <%
                    if (p.getImage() != null) {
                %>
                <img src="<%= request.getContextPath() %>/images/<%= p.getImage() %>"
                     width="180" height="120" style="object-fit:cover;">
                <%
                    }
                %>
                <h3><%= p.getName() %></h3>
                <p><%= p.getDescription() %></p>
                <b>RM <%= p.getPrice() %></b>
            </div>
<%
        }
    } else {
%>
    <p>No featured products available.</p>
<%
    }
%>
</div>

</body>
</html>
