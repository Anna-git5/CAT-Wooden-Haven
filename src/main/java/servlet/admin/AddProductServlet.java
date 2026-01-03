package servlet.admin;

import dao.AddProductDAO;
import util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/admin/add-product")
@MultipartConfig
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/admin/add-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. Acquire data from form //
        int categoryId = Integer.parseInt(request.getParameter("category"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        // 2. Acquire images //
        Part imageMainPart = request.getPart("imageMain");
        Part imageSecondPart = request.getPart("imageSecond");

        // 3. Generate file name //
        String mainImageName = System.currentTimeMillis() + "_" + Paths.get(imageMainPart.getSubmittedFileName()).getFileName().toString();
        String secondImageName = null;
        if (imageSecondPart != null && imageSecondPart.getSize() > 0) {
            secondImageName = System.currentTimeMillis() + "_" + Paths.get(imageSecondPart.getSubmittedFileName()).getFileName().toString();
        }

        // 4. Determine the folder to store images //
        String uploadPath =getServletContext().getRealPath("/images");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 5. Save image file //
        imageMainPart.write(uploadPath + File.separator + mainImageName);

        if (secondImageName != null) {
            imageSecondPart.write(uploadPath + File.separator + secondImageName);

        }

        // 6. Save data in SQL //
        AddProductDAO.addProduct(categoryId, name, description, price, stock, mainImageName, secondImageName);

        // 7. Redirect //
        request.getSession().setAttribute("successMessage", "✅ Product added successfully!");
        response.sendRedirect(request.getContextPath() + "/admin/add-product");
    }
}
