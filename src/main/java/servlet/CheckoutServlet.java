package servlet;

import model.CartItem;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Make sure cart is not empty
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("cart") == null) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        String[] selectedIds = request.getParameterValues("selectedProductIds");

        if (cart == null || selectedIds == null || selectedIds.length == 0) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        List<CartItem> selectedItems = new ArrayList<>();

        for (CartItem item : cart) {
            for (String id : selectedIds) {
                if (item.getProduct().getProductId() == Integer.parseInt(id)) {
                    selectedItems.add(item);
                }
            }
        }

        session.setAttribute("checkoutItems", selectedItems);

        request.getRequestDispatcher("/WEB-INF/checkout.jsp")
                .forward(request, response);
    }
}

