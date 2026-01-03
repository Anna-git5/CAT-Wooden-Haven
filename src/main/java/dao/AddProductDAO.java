package dao;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;


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

    public static boolean productExists(String name, int categoryId) {

        String sql = "SELECT COUNT(*) FROM products WHERE LOWER(name) = LOWER(?) AND category_id = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, name.trim());
            ps.setInt(2, categoryId);

            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }

}

