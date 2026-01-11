<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 11/1/2026
  Time: 3:09 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;

            background-image:
                    linear-gradient(
                            rgba(245,237,231,0.6),
                            rgba(245,237,231,0.6)
                    ),
                    url("<%= request.getContextPath() %>/images/woodenHavenBG.jpg");

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }


        .container {
            max-width: 900px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
        }

        h2, h3 {
            margin-bottom: 20px;
        }

        /* CART TABLE */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background: #f1f1f1;
        }

        img.product {
            width: 70px;
            border-radius: 6px;
        }

        .total {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            margin: 20px 0;
        }

        /* DELIVERY INFORMATION */
        .delivery-section input,
        .delivery-section textarea {
            width: 100%;
            padding: 14px;
            margin-bottom: 16px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 15px;
        }

        /* PAYMENT TABS */
        .payment-tabs {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }

        .payment-tabs button {
            padding: 10px 20px;
            border-radius: 6px;
            border: 1px solid #ccc;
            background: #fff;
            cursor: pointer;
            font-weight: bold;
            transition: 0.2s;
        }

        .payment-tabs button.active {
            border-color: #3e2d24;
            background: #f5f1ee;
        }

        .payment-tabs button:hover {
            border-color: #3e2d24;
            background: #faf6f3;
        }

        /* BANK LIST */
        .bank-list {
            display: none;
        }

        .bank-option {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 12px;
            cursor: pointer;
        }

        .bank-option input {
            transform: scale(1.2);
        }

        .bank-option img {
            width: 40px;
            height: 40px;
            border-radius: 6px;
            border: 1px solid #eee;
            padding: 5px;
        }

        .bank-option input:checked + img {
            outline: 2px solid #3e2d24;
        }

        /* PLACE ORDER */
        .place-order button {
            width: 100%;
            padding: 14px;
            font-size: 16px;
            background: #3e2d24;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 30px;
        }

        .place-order button:hover {
            background: #563e30;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            color: #3e2d24;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        /* SUCCESS OVERLAY */
        .success-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.45);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        /* SUCCESS BOX */
        .success-box {
            background: white;
            width: 520px;
            padding: 50px 40px;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 20px 50px rgba(0,0,0,0.25);
        }

        /* GREEN CHECK */
        .success-icon {
            width: 90px;
            height: 90px;
            background: #27ae60;
            color: white;
            font-size: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
        }

        /* BUTTON */
        .success-btn {
            display: inline-block;
            margin-top: 30px;
            padding: 14px 30px;
            background: #3e2d24;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }

        .success-btn:hover {
            background: #563e30;
        }

    </style>
</head>

<body>

<div class="container">

    <a href="<%= request.getContextPath() %>/cart"
       class="back-link">
        ◀ Back to Shopping Cart
    </a>

    <h2>Checkout</h2>

    <%
        List<CartItem> checkoutItems =
                (List<CartItem>) session.getAttribute("checkoutItems");
        double total = 0;
    %>

    <% if (checkoutItems == null || checkoutItems.isEmpty()) { %>
    <p>No items selected.</p>
    <% } else { %>

    <!-- CART -->
    <table>
        <tr>
            <th>Image</th>
            <th>Product</th>
            <th>Qty</th>
            <th>Price</th>
            <th>Subtotal</th>
        </tr>

        <% for (CartItem item : checkoutItems) {
            double subtotal = item.getTotalPrice();
            total += subtotal;
        %>
        <tr>
            <td>
                <img class="product"
                     src="<%= request.getContextPath() %>/images/<%= item.getProduct().getImageMain() %>">
            </td>
            <td><%= item.getProduct().getName() %></td>
            <td><%= item.getQuantity() %></td>
            <td>RM <%= item.getProduct().getPrice() %></td>
            <td>RM <%= subtotal %></td>
        </tr>
        <% } %>
    </table>

    <p class="total">Total: RM <%= total %></p>

    <!-- FORM -->
    <form action="<%= request.getContextPath() %>/place-order" method="post">

        <!-- DELIVERY INFO -->
        <div class="delivery-section">
            <h3>Delivery Information</h3>
            <input type="text" name="fullname" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <textarea name="address" rows="4" placeholder="Delivery Address" required></textarea>
        </div>

        <!-- PAYMENT METHOD -->
        <h3>Payment Method</h3>

        <div class="payment-tabs">
            <button id="btnOnline" type="button" class="active" onclick="showOnline()">
                Online Banking
            </button>
            <button id="btnCOD" type="button" onclick="showCOD()">
                Cash on Delivery
            </button>
        </div>

        <!-- ONLINE BANKING -->
        <div id="onlineBanking" class="bank-list" style="display:block;">
            <label class="bank-option">
                <input type="radio" name="paymentMethod" value="Maybank2u" required>
                <img src="<%= request.getContextPath() %>/images/Maybank.jpeg">
                <span>Maybank2u</span>
            </label>

            <label class="bank-option">
                <input type="radio" name="paymentMethod" value="RHB Bank" required>
                <img src="<%= request.getContextPath() %>/images/RHBBank.jpeg">
                <span>RHB Bank</span>
            </label>

            <label class="bank-option">
                <input type="radio" name="paymentMethod" value="CIMB Bank" required>
                <img src="<%= request.getContextPath() %>/images/CIMBBank.jpeg">
                <span>CIMB Bank</span>
            </label>

            <label class="bank-option">
                <input type="radio" name="paymentMethod" value="Public Bank" required>
                <img src="<%= request.getContextPath() %>/images/PublicBank.jpeg">
                <span>Public Bank</span>
            </label>

            <label class="bank-option">
                <input type="radio" name="paymentMethod" value="AmBank" required>
                <img src="<%= request.getContextPath() %>/images/AmBank.jpeg">
                <span>AmBank</span>
            </label>

            <label class="bank-option">
                <input type="radio" name="paymentMethod" value="Bank Islam" required>
                <img src="<%= request.getContextPath() %>/images/BankIslam.jpeg">
                <span>Bank Islam</span>
            </label>
        </div>

        <!-- CASH ON DELIVERY -->
        <div id="cod" class="bank-list">
            <label class="bank-option">
                <input type="radio" name="paymentMethod" value="COD">
                <span>Cash on Delivery</span>
            </label>
        </div>

        <div class="place-order">
            <button type="submit">Place Order</button>
        </div>

    </form>

    <% } %>

</div>

<script>
    function showOnline() {
        document.getElementById("onlineBanking").style.display = "block";
        document.getElementById("cod").style.display = "none";

        document.getElementById("btnOnline").classList.add("active");
        document.getElementById("btnCOD").classList.remove("active");
    }

    function showCOD() {
        document.getElementById("onlineBanking").style.display = "none";
        document.getElementById("cod").style.display = "block";

        document.getElementById("btnCOD").classList.add("active");
        document.getElementById("btnOnline").classList.remove("active");
    }
</script>

<% Boolean orderSuccess = (Boolean) request.getAttribute("orderSuccess"); %>

<% if (orderSuccess != null && orderSuccess) { %>
<div class="success-overlay">
    <div class="success-box">
        <div class="success-icon">✔</div>

        <h2>Order has been placed!</h2>

        <p>
            Thank you for your purchase.<br>
            Your order is being processed.
        </p>

        <a href="<%= request.getContextPath() %>/home" class="success-btn">
            Back to Homepage
        </a>
    </div>
</div>
<% } %>

</body>
</html>