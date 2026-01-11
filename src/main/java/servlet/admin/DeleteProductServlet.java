package servlet.admin;

import dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpSession;


@WebServlet("/admin/delete-product")
public class DeleteProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/admin/delete-product.jsp")
                .forward(request, response);
        }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. Get product ID
        int productId = Integer.parseInt(request.getParameter("productId"));

        // 2. Get image filenames
        String[] images = ProductDAO.getProductImages(productId);

        // 3. Delete image files
        if (images != null) {
            String uploadPath = getServletContext().getRealPath("/images");

            if (images[0] != null && !images[0].isEmpty()) {
                File mainImg = new File(uploadPath, images[0]);
                if (mainImg.exists()) {
                    mainImg.delete();
                }
            }
        }

        // 4. Delete product from database
        ProductDAO.deleteProduct(productId);

        // 5. Redirect with success message
        request.getSession().setAttribute(
                "successMessage",
                "✅ Product has been deleted successfully."
        );

        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
