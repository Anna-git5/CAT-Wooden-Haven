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

        List<Product> productList = new ArrayList<>();
        String categoryParam = request.getParameter("category");
        String searchParam = request.getParameter("search");

        StringBuilder sql = new StringBuilder("SELECT * FROM PRODUCTS WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (categoryParam != null && !categoryParam.isEmpty()) {
            sql.append(" AND CATEGORY_ID = ?");
            params.add(Integer.parseInt(categoryParam));
        }
        if (searchParam != null && !searchParam.trim().isEmpty()) {
            sql.append(" AND (LOWER(NAME) LIKE ? OR LOWER(DESCRIPTION) LIKE ?)");
            String keyword = "%" + searchParam.toLowerCase() + "%";
            params.add(keyword);
            params.add(keyword);
        }
            // String sql = "SELECT PRODUCT_ID, NAME, DESCRIPTION, PRICE, STOCK, IMAGE_MAIN FROM PRODUCTS";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("PRODUCT_ID"));
                p.setName(rs.getString("NAME"));
                p.setDescription(rs.getString("DESCRIPTION"));
                p.setPrice(rs.getDouble("PRICE"));
                p.setStock(rs.getInt("STOCK"));
                p.setImageMain(rs.getString("IMAGE_MAIN"));
                p.setCategoryId(rs.getInt("CATEGORY_ID"));

                productList.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("products", productList);
        request.setAttribute("selectedCategory", categoryParam);
        request.setAttribute("search", searchParam);

        request.getRequestDispatcher("/products.jsp")
                .forward(request, response);
    }
}
