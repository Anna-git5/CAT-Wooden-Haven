package dao;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddProductDAO {
    /* Insert new product into database */
    public static void addProduct(int categoryId, String name, String description, double price, int stock, String imageMain, String imageSecond) {
        String sql = "INSERT INTO products " + "(name, description, price, stock, image_main,image_second, category_id) " + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn =DBConnection.getConnection();

            if (conn == null) {
                throw new SQLException("Database connection is NULL");
            }

            ps = conn.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setInt(4, stock);
            ps.setString(5, imageMain);
            ps.setString(6, imageSecond);
            ps.setInt(7, categoryId);

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("❌ Error inserting product");
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
