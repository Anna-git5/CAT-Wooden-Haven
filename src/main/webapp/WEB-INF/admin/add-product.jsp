<%--
  Created by IntelliJ IDEA.
  User: adam2
  Date: 30/12/2025
  Time: 7:32 am
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 40px;
        }

        .form-container {
            max-width: 520px;
            margin: auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        h2 {
            margin-bottom: 25px;
            color: #3e2d24;
            text-align: center;
        }

        label {
            font-weight: bold;
            color: #3e2d24;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            margin-bottom: 18px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
        }

        input[type="file"] {
            margin-top: 6px;
            margin-bottom: 18px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #3e2d24;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            cursor: pointer;
        }

        button:hover {
            background-color: #5a4032;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add New Product</h2>

    <form method="post" action="<%= request.getContextPath() %>/admin/add-product" enctype="multipart/form-data">

        <label>Category:</label>
        <select name="category" required>
            <option value="">-- Select Category --</option>
            <option value="1">Living Room</option>
            <option value="2">Kitchen</option>
            <option value="3">Bedroom</option>
            <option value="4">Home Decor & Handicrafts</option>
        </select>

        <label>Product Name:</label>
        <input type="text" name="name" required>

        <label>Description:</label>
        <textarea name="description" rows="4" required></textarea>

        <label>Price (RM):</label>
        <input type="number" step="0.01" name="price" required>

        <label>Stock:</label>
        <input type="number" name="stock" required>

        <label>Main Image:</label>
        <div>
            <input type="file" name="imageMain" accept="image/*" required>
        </div>

        <label>Second Image:</label>
        <div>
            <input type="file" name="imageSecond" accept="image/*">
        </div>

        <button type="submit">Add Product</button>
    </form>
</div>

</body>
</html>

