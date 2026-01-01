package servlet;

import util.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "INSERT INTO USERS (username, password, role) VALUES (?, ?, 'USER')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.executeUpdate();

            response.sendRedirect("login.jsp");

            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", "USER");

            String redirect =
                    (String) session.getAttribute("redirectAfterLogin");

            if (redirect != null) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect(redirect);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=true");
        }
    }
}
