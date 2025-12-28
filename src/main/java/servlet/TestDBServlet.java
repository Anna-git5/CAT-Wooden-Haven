package servlet;

import util.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/testdb")
public class TestDBServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("text/html");

        Connection conn = DBConnection.getConnection();

        if (conn != null) {
            response.getWriter().println("<h2>Oracle DB Connected!</h2>");
        } else {
            response.getWriter().println("<h2>DB Connection Failed</h2>");
        }
    }
}
