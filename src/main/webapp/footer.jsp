<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 2/1/2026
  Time: 3:26 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>E-Commerce Page</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        /* PAGE CONTENT */
        .content {
            flex: 1;
            padding: 40px;
        }
        /* FOOTER */
        footer {
            background-color: #f3e6d6;
            color: #5a3e30;
            padding: 26px 0 6px;
        }
        .footer-container {
            max-width: 1100px;
            margin: auto;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        .footer-section {
            width: 250px;
            margin-bottom: 20px;
        }
        .footer-section h3,
        .footer-section h4 {
            margin-bottom: 10px;
            color: #3e2d24;
        }
        .footer-section p,
        .footer-section a {
            color: #6b4f3f;
            font-size: 14px;
            text-decoration: none;
            transition: background-color 0.2s ease;
        }
        .logistics-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .logistics-list li {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
            font-size: 14px;
            color: #6b4f3f;
        }
        .logistics-list img {
            height: 40px;
            width: auto;
            object-fit: contain;
            opacity: 0.85;
        }
        .logistics-item {
            background-color: #f5f3ef;
            border-radius: 5px;
            width: 45px;
            height: 30px;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;

            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
            margin-right: 6px;
        }

        .footer-section ul {
            list-style: none;
            padding: 0;
        }
        .footer-section ul li {
            margin-bottom: 8px;
        }
        .footer-section a:hover {
            color: #3e2d24;
            text-decoration: none;
            background-color: rgba(62, 45, 36, 0.1);
        }
        .footer-bottom {
            text-align: center;
            border-top: 1px solid #4a372d;
            padding-top: 10px;
            font-size: 13px;
            color: #7a6a5f;
        }
    </style>
</head>

<body>
<div class="content">
    <h1>Welcome to Wooden Haven</h1>
    <p>Your premium wooden furniture store.</p>
</div>
<footer>
    <div class="footer-container">
        <div class="footer-section">
            <h3>Wooden Haven</h3>
            <p>Handcrafted wooden furniture made with passion and quality.</p>
        </div>
        <div class="footer-section">
            <h4>Shop</h4>
            <ul>
                <li><a href="<%= request.getContextPath() %>/products?category=1">Living Room</a></li>
                <li><a href="<%= request.getContextPath() %>/products?category=2">Kitchen</a></li>
                <li><a href="<%= request.getContextPath() %>/products?category=3">Bedroom</a></li>
                <li><a href="<%= request.getContextPath() %>/products?category=4">Home Decor & Handicrafts</a></li>
            </ul>
        </div>
        <div class="footer-section">
            <h4>Logistic</h4>
            <ul class="logistics-list">
                <li>
                    <div class="logistics-item">
                        <img src="images/havenExpress.png" alt="havenExpress">
                    </div>
                    havenExpress
                </li>
            </ul>

        </div>
        <div class="footer-section">
            <h4>Support</h4>
            <p>Shipping Policy</p>
            <p>Return Policy</p>
            <p>Contact Us</p>
        </div>
    </div>

    <div class="footer-bottom">
        © 2026 Wooden Haven. All Rights Reserved.
    </div>
</footer>
</body>
</html>
