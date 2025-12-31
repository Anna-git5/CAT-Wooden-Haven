package servlet;

import model.Product;
import util.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> featuredProducts = new ArrayList<>();

        String sql = "SELECT PRODUCT_ID, NAME, DESCRIPTION, PRICE, IMAGE_MAIN " +
                "FROM PRODUCTS WHERE ROWNUM <= 4";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("PRODUCT_ID"));
                p.setName(rs.getString("NAME"));
                p.setDescription(rs.getString("DESCRIPTION"));
                p.setPrice(rs.getDouble("PRICE"));
                p.setImageMain(rs.getString("IMAGE_MAIN"));

                featuredProducts.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("featuredProducts", featuredProducts);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
