<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 1/1/2026
  Time: 8:21 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>

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

        .container { max-width:900px; margin:40px auto; background:white;
            padding:30px; border-radius:8px;box-shadow:0 4px 10px rgba(0,0,0,0.1); }
        table { width:100%; border-collapse:collapse; }
        th, td { padding:12px; border-bottom:1px solid #ddd; text-align:center; }
        th { background:#f1f1f1; }
        img { width:80px;border-radius:4px; }
        .total { font-size:18px; font-weight:bold; text-align:right;margin-top:20px; }
        .btn { padding:8px 14px; background:#3e2d24; color:white;
            text-decoration:none; border-radius:4px;border:none;cursor:pointer; }
        .btn:hover {
            background:#563e30;
        }
        .actions {
            display:flex;
            justify-content:space-between;
            margin-top:25px;
        }
    </style>
</head>

<body>

<div class="container">

    <a href="<%= request.getContextPath() %>/home" style=" position: absolute; top: 20px; left: 20px; text-decoration: none; font-weight: bold; color: #3e2d24; font-size: 14px; background: none;">
        ◀ Back to Homepage
    </a>

    <h2>Your Cart</h2>

    <%
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        double total = 0;
    %>

    <% if (cart == null || cart.isEmpty()) { %>

        <div class="empty">
            <p>Your cart is empty.</p>
        </div>

    <% } else { %>

    <form method="get">

        <table>
            <tr>
                <th><input type="checkbox" id="selectAll"></th>
                <th>Image</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Price</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>

            <% for (CartItem item : cart) {
                double subtotal = item.getTotalPrice();
                total += subtotal;
            %>

            <tr>
                <td>
                    <input type="checkbox"
                           name="selectedProductIds"
                           value="<%= item.getProduct().getProductId() %>"
                           class="item-checkbox"
                           checked>
                </td>

                <td>
                    <img src="<%= request.getContextPath() %>/images/<%= item.getProduct().getImageMain() %>">
                </td>

                <td><%= item.getProduct().getName() %></td>
                <td><%= item.getQuantity() %></td>
                <td>RM <%= item.getProduct().getPrice() %></td>
                <td>RM <%= subtotal %></td>

                <td>
                    <!-- REMOVE BUTTON -->
                    <button type="submit"
                            class="btn"
                            formaction="<%= request.getContextPath() %>/cart"
                            formmethod="post"
                            name="action"
                            value="remove"
                            onclick="this.form.productId.value='<%= item.getProduct().getProductId() %>'">
                        Remove
                    </button>
                </td>
            </tr>
            <% } %>
        </table>

        <!-- hidden productId holder -->
        <input type="hidden" name="productId">

        <p class="total">Total: RM <%= total %></p>

        <div class="actions">
            <a class="btn" href="<%= request.getContextPath() %>/products">
                Continue Shopping
            </a>

            <button type="submit"
                    class="btn"
                    formaction="<%= request.getContextPath() %>/checkout">
                Checkout
            </button>
        </div>

    </form>

    <% } %>

</div>

<jsp:include page="footer.jsp" />

<script>
    document.getElementById("selectAll")?.addEventListener("change", function () {
        document.querySelectorAll(".item-checkbox")
            .forEach(cb => cb.checked = this.checked);
    });
</script>

</body>
</html>
