<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 28/12/2025
  Time: 9:22 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | Wooden Haven</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f1ee;
            margin: 0;
            padding: 0;
        }
        .login-container {
            width: 380px;
            margin: 100px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #3e2d24;
        }
        label {
            font-weight: bold;
            color: #3e2d24;
            font-size: 14px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            margin-bottom: 18px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #3e2d24;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            cursor: pointer;
            box-sizing: border-box
        }
        button:hover {
            background-color: #5a4032;
        }
        .error-message {
            margin-top: 15px;
            padding: 10px;
            background-color: #fdecea;
            border-left: 4px solid #d32f2f;
            color: #d32f2f;
            font-size: 13px;
            border-radius: 4px;
        }
        .register-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
        .register-link a {
            color: #3e2d24;
            font-weight: bold;
            text-decoration: none;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-container">

    <h2>Login</h2>

    <form action="<%= request.getContextPath() %>/login" method="post">

        <label>Username: </label>
        <input type="text" name="username" required>

        <label>Password: </label>
        <input type="password" name="password" required>

        <button type="submit">Login</button>

    </form>

    <% if (request.getParameter("error") != null) { %>
        <div
                class="error-message"> ❌ Invalid username or password.
        </div>
    <% } %>

    <div class="register-link">
        Don’t have an account?
        <a href="<%= request.getContextPath() %>/register.jsp">
            Register here
        </a>
    </div>

</div>
</body>
</html>
