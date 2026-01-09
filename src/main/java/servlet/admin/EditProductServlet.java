package servlet.admin;

import dao.ProductDAO;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/edit-product")
public class EditProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println(">>> EditProductServlet doGet HIT <<<");

        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String id = request.getParameter("productId");

        if (id != null && !id.isEmpty()) {
            int productId = Integer.parseInt(id);
            Product product = ProductDAO.getProductById(productId);

            if (product != null) {
                request.setAttribute("product", product);
            } else {
                request.setAttribute("error", "Product not found");
            }
        }

        request.getRequestDispatcher("/WEB-INF/admin/edit-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Product p = new Product();
        p.setProductId(Integer.parseInt(request.getParameter("productId")));
        p.setName(request.getParameter("name"));
        p.setDescription(request.getParameter("description"));
        p.setPrice(Double.parseDouble(request.getParameter("price")));
        p.setStock(Integer.parseInt(request.getParameter("stock")));

        ProductDAO.updateProduct(p);

        request.getSession().setAttribute("successMessage", "Product updated successfully.");

        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
