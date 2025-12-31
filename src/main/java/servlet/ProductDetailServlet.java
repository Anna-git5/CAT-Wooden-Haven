package servlet;

import model.Product;
import util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        int productId = Integer.parseInt(idParam);
        Product product = null;

        String sql =
                "SELECT PRODUCT_ID, NAME, DESCRIPTION, PRICE, STOCK, IMAGE_MAIN, IMAGE_SECOND " +
                        "FROM PRODUCTS WHERE PRODUCT_ID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("PRODUCT_ID"));
                product.setName(rs.getString("NAME"));
                product.setDescription(rs.getString("DESCRIPTION"));
                product.setPrice(rs.getDouble("PRICE"));
                product.setStock(rs.getInt("STOCK"));
                product.setImageMain(rs.getString("IMAGE_MAIN"));
                product.setImageSecond(rs.getString("IMAGE_SECOND"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        request.setAttribute("product", product);
        request.getRequestDispatcher("/product-detail.jsp")
                .forward(request, response);
    }
}
