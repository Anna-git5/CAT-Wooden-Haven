package dao;

import model.CartItem;
import model.Product;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public static void addToCart(int userId, int productId, int qty) {

        String sql =
            "MERGE INTO CART c " +
            "USING dual " +
            "ON (c.user_id = ? AND c.product_id = ?) " +
            "WHEN MATCHED THEN " +
            "UPDATE SET quantity = quantity + ? " +
            "WHEN NOT MATCHED THEN " +
            "INSERT (user_id, product_id, quantity) " +
            "VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setInt(3, qty);
            ps.setInt(4, userId);
            ps.setInt(5, productId);
            ps.setInt(6, qty);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<CartItem> getCartByUser(int userId) {

        List<CartItem> cart = new ArrayList<>();

        String sql =
            "SELECT p.product_id, p.name, p.price, p.image_main, c.quantity " +
            "FROM CART c " +
            "JOIN PRODUCTS p ON c.product_id = p.product_id " +
            "WHERE c.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setImageMain(rs.getString("image_main"));

                CartItem item = new CartItem(
                        product,
                        rs.getInt("quantity")
                );

                cart.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cart;
    }

    public static void removeFromCart(int userId, int productId) {

        String sql = "DELETE FROM CART WHERE user_id = ? AND product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
