package model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import model.entities.Order;
import config.ConnectionSQL;

public class OrderDAO {

    public static int insert(String fullName, String address, String phoneNumber, int clientID, long totalAmount) {
        try {
            Connection connection = ConnectionSQL.getConnection();
            String sql = "INSERT INTO orders (fullName, address, phoneNumber, client_clientID, totalAmount, status, orderDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Generate current date in appropriate format
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String currentDate = formatter.format(new Date());

            stmt.setString(1, fullName);
            stmt.setString(2, address);
            stmt.setString(3, phoneNumber);
            stmt.setInt(4, clientID);
            stmt.setLong(5, totalAmount);
            stmt.setString(6, "pending"); // Default status for new orders
            stmt.setString(7, currentDate);

            stmt.executeUpdate();

            // Get the generated order ID
            ResultSet rs = stmt.getGeneratedKeys();
            int orderID = -1;
            if (rs.next()) {
                orderID = rs.getInt(1);
            }

            connection.close();
            System.out.println("Insert order into database successful!");
            return orderID;
        } catch (SQLException e) {
            System.out.println("Insert order into database failed!");
            e.printStackTrace();
        }
        return -1;
    }

    public static ArrayList<Order> findAll() {
        try {
            ArrayList<Order> orderList = new ArrayList<>();
            Connection connection = ConnectionSQL.getConnection();
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM orders ORDER BY orderDate DESC");

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("orderID"),
                        rs.getString("fullName"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getInt("client_clientID"),
                        rs.getLong("totalAmount"),
                        rs.getString("status"),
                        rs.getString("orderDate"));
                orderList.add(order);
            }

            connection.close();
            return orderList;
        } catch (SQLException e) {
            System.out.println("Get orders from database failed!");
            e.printStackTrace();
        }

        return null;
    }

    public static ArrayList<Order> findByClientId(int clientID) {
        try {
            ArrayList<Order> orderList = new ArrayList<>();
            Connection connection = ConnectionSQL.getConnection();
            String sql = "SELECT * FROM orders WHERE client_clientID = ? ORDER BY orderDate DESC";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, clientID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("orderID"),
                        rs.getString("fullName"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getInt("client_clientID"),
                        rs.getLong("totalAmount"),
                        rs.getString("status"),
                        rs.getString("orderDate"));
                orderList.add(order);
            }

            connection.close();
            return orderList;
        } catch (SQLException e) {
            System.out.println("Get orders by client ID failed!");
            e.printStackTrace();
        }

        return null;
    }

    public static void updateStatusByOrderId(int orderID, String status) {
        try {
            Connection connection = ConnectionSQL.getConnection();
            String sql = "UPDATE orders SET status = ? WHERE orderID = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, orderID);

            stmt.executeUpdate();
            connection.close();
            System.out.println("Update order status successful!");
        } catch (SQLException e) {
            System.out.println("Update order status failed!");
            e.printStackTrace();
        }
    }

    public static void deleteByOrderId(int orderID) {
        try {
            Connection connection = ConnectionSQL.getConnection();

            // First delete order details
            String deleteDetailsSQL = "DELETE FROM order_details WHERE order_orderID = ?";
            PreparedStatement detailsStmt = connection.prepareStatement(deleteDetailsSQL);
            detailsStmt.setInt(1, orderID);
            detailsStmt.executeUpdate();

            // Then delete the order
            String deleteOrderSQL = "DELETE FROM orders WHERE orderID = ?";
            PreparedStatement orderStmt = connection.prepareStatement(deleteOrderSQL);
            orderStmt.setInt(1, orderID);
            orderStmt.executeUpdate();

            connection.close();
            System.out.println("Delete order successful!");
        } catch (SQLException e) {
            System.out.println("Delete order failed!");
            e.printStackTrace();
        }
    }

    public static ArrayList<Order> findByShopId(int shopID) {
        try {
            ArrayList<Order> orderList = new ArrayList<>();
            Connection connection = ConnectionSQL.getConnection();

            // Query orders that contain products from this shop
            String sql = "SELECT DISTINCT o.* FROM orders o " +
                    "JOIN order_details od ON o.orderID = od.order_orderID " +
                    "JOIN product p ON od.product_productID = p.productID " +
                    "WHERE p.shop_shopID = ? " +
                    "ORDER BY o.orderDate DESC";

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, shopID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("orderID"),
                        rs.getString("fullName"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getInt("client_clientID"),
                        rs.getLong("totalAmount"),
                        rs.getString("status"),
                        rs.getString("orderDate"));
                orderList.add(order);
            }

            connection.close();
            return orderList;
        } catch (SQLException e) {
            System.out.println("Get orders by shop ID failed!");
            e.printStackTrace();
        }

        return null;
    }
}