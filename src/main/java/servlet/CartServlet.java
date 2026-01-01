package servlet;

import model.CartItem;
import model.Product;
import util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));

        if ("remove".equals(action)) {
            Iterator<CartItem> iterator = cart.iterator();
            while (iterator.hasNext()) {
                CartItem item = iterator.next();
                if (item.getProduct().getProductId() == productId) {
                    iterator.remove();
                    break;
                }
            }
            session.setAttribute("cart", cart);
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        int qty = Integer.parseInt(request.getParameter("qty"));
        Product product = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT * FROM PRODUCTS WHERE PRODUCT_ID = ?")) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("PRODUCT_ID"));
                product.setName(rs.getString("NAME"));
                product.setPrice(rs.getDouble("PRICE"));
                product.setImageMain(rs.getString("IMAGE_MAIN"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProduct().getProductId() == productId) {
                item.setQuantity(item.getQuantity() + qty);
                found = true;
                break;
            }
        }

        if (!found && product != null) {
            cart.add(new CartItem(product, qty));
        }

        session.setAttribute("cart", cart);
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.getRequestDispatcher("/cart.jsp")
                .forward(request, response);
    }
}
