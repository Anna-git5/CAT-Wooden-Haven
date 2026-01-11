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

            //CHECK IF USERNAME ALREADY EXISTS
            String checkSql = "SELECT user_id FROM USERS WHERE username = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, username);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                response.sendRedirect(
                        request.getContextPath() + "/login.jsp?exists=1"
                );
                return;
            }

            // INSERT NEW USER
            String sql = "INSERT INTO USERS (username, password, role) VALUES (?, ?, 'USER')";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);
            ps.executeUpdate();

            // response.sendRedirect(request.getContextPath() + "/login.jsp?registered=1");

            String getIdSql = "SELECT user_id FROM USERS WHERE username = ?";
            PreparedStatement idPs = conn.prepareStatement(getIdSql);
            idPs.setString(1, username);
            ResultSet idRs = idPs.executeQuery();

            int user_id = 0;
            if (idRs.next()) {
                user_id = idRs.getInt("user_id");
            }

            HttpSession session = request.getSession();
            session.setAttribute("userId", user_id);
            session.setAttribute("username", username);
            session.setAttribute("role", "USER");

            response.sendRedirect(request.getContextPath() + "/home");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/register.jsp?error=1"
            );
        }
    }
}
