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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        //System.out.println("=== PRODUCT SERVLET CALLED ===");

        List<Product> productList = new ArrayList<>();

        String sql = "SELECT PRODUCT_ID, NAME, DESCRIPTION, PRICE, STOCK, IMAGE_MAIN FROM PRODUCTS";

        try (Connection conn = DBConnection.getConnection())
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("PRODUCT_ID"));
                p.setName(rs.getString("NAME"));
                p.setDescription(rs.getString("DESCRIPTION"));
                p.setPrice(rs.getDouble("PRICE"));
                p.setStock(rs.getInt("STOCK"));
                p.setImageMain(rs.getString("IMAGE_MAIN"));

                productList.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("products", productList);
        request.getRequestDispatcher("/products.jsp")
                .forward(request, response);
    }
}
