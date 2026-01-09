package servlet;

import dao.CartDAO;
import model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        int productId = Integer.parseInt(request.getParameter("productId"));
        if ("remove".equals(action)) {
            CartDAO.removeFromCart(userId, productId);
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        int qty = Integer.parseInt(request.getParameter("qty"));

        CartDAO.addToCart(userId, productId, qty);

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        //Load cart content from the DB
        List<CartItem> cart = CartDAO.getCartByUser(userId);
        request.setAttribute("cart", cart);

        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}
