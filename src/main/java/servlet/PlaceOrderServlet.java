package servlet;

import dao.CartDAO;
import dao.ProductDAO;
import model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<CartItem> checkoutItems =
                (List<CartItem>) session.getAttribute("checkoutItems");

        if (checkoutItems == null || checkoutItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        for (CartItem item : checkoutItems) {

            int productId = item.getProduct().getProductId();
            int qty = item.getQuantity();

            // 1️⃣ Reduce stock
            ProductDAO.reduceStock(productId, qty);

            // 2️⃣ Remove from cart
            CartDAO.removeMultipleFromCart(userId, productId);
        }


        // Clear checkout session
        session.removeAttribute("checkoutItems");

        // Show success popup
        request.setAttribute("orderSuccess", true);
        request.getRequestDispatcher("/WEB-INF/checkout.jsp")
                .forward(request, response);
    }
}
