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

        System.out.println("=== PRODUCT SERVLET CALLED ===");

        List<Product> productList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            // DEBUG: confirm database connection
            System.out.println("Connected to DB: " + conn.getMetaData().getURL());

            // DEBUG: check product count
            String countSql = "SELECT COUNT(*) FROM PRODUCTS";
            PreparedStatement countPs = conn.prepareStatement(countSql);
            ResultSet countRs = countPs.executeQuery();
            if (countRs.next()) {
                System.out.println("DB COUNT = " + countRs.getInt(1));
            }

            // Actual query
            String sql = "SELECT PRODUCT_ID, NAME, DESCRIPTION, PRICE FROM PRODUCTS";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("PRODUCT_ID"));
                p.setName(rs.getString("NAME"));
                p.setDescription(rs.getString("DESCRIPTION"));
                p.setPrice(rs.getDouble("PRICE"));

                productList.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("Product list size = " + productList.size());

        request.setAttribute("products", productList);
        request.getRequestDispatcher("/products.jsp")
                .forward(request, response);
    }
}
