<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 28/12/2025
  Time: 9:23 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - Wooden Haven</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f8f8;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            background: white;
            width: 380px;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
        }

        .register-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #3e2d24;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #3e2d24;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .form-group input:focus {
            outline: none;
            border-color: #3e2d24;
        }

        .register-btn {
            width: 100%;
            padding: 12px;
            background: #3e2d24;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }

        .register-btn:hover {
            background: #563e30;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 18px;
            text-decoration: none;
            color: #3e2d24;
            font-size: 14px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>

<div class="register-container">
    <h2>Create Account</h2>

    <form action="register" method="post">

        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <button type="submit" class="register-btn">Register</button>
    </form>

    <a href="<%= request.getContextPath() %>/login.jsp" class="back-link">
        Already have an account? Login
    </a>

</body>
</html>

