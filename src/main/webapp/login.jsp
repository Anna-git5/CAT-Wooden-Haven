<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 28/12/2025
  Time: 9:22 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Wooden Haven</title>
</head>
<body>

<h2>Login</h2>

<form action="<%= request.getContextPath() %>/login" method="post">
    Username: <input type="text" name="username" required /><br><br>
    Password: <input type="password" name="password" required /><br><br>
    <button type="submit">Login</button>
</form>

<p style="color:red">
    <%
        if (request.getParameter("error") != null) {
            System.out.println("Invalid username or password");
        }
    %>
</p>

<p>
    Don’t have an account?
    <a href="<%= request.getContextPath() %>/register.jsp">
        Register here
    </a>
</p>


</body>
</html>
