package model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import config.ConnectionSQL;
import model.entities.OrderDetail;
import model.entities.Product;

public class OrderDetailDAO {

    public static void insert(int orderID, int productID, int quantity, long price) {
        try {
            Connection connection = ConnectionSQL.getConnection();
            String sql = "INSERT INTO order_details (order_orderID, product_productID, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setInt(1, orderID);
            stmt.setInt(2, productID);
            stmt.setInt(3, quantity);
            stmt.setLong(4, price);

            stmt.executeUpdate();
            connection.close();
            System.out.println("Insert order detail into database successful!");
        } catch (SQLException e) {
            System.out.println("Insert order detail into database failed!");
            e.printStackTrace();
        }
    }

    public static ArrayList<OrderDetail> findByOrderId(int orderID) {
        try {
            ArrayList<OrderDetail> orderDetailList = new ArrayList<>();
            Connection connection = ConnectionSQL.getConnection();
            String sql = "SELECT * FROM order_details WHERE order_orderID = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt("orderDetailID"),
                        rs.getInt("order_orderID"),
                        rs.getInt("product_productID"),
                        rs.getInt("quantity"),
                        rs.getLong("price"));
                orderDetailList.add(orderDetail);
            }

            connection.close();
            return orderDetailList;
        } catch (SQLException e) {
            System.out.println("Get order details by order ID failed!");
            e.printStackTrace();
        }

        return null;
    }

    public static ArrayList<OrderDetail> findByProductId(int productID) {
        try {
            ArrayList<OrderDetail> orderDetailList = new ArrayList<>();
            Connection connection = ConnectionSQL.getConnection();
            String sql = "SELECT * FROM order_details WHERE product_productID = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, productID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt("orderDetailID"),
                        rs.getInt("order_orderID"),
                        rs.getInt("product_productID"),
                        rs.getInt("quantity"),
                        rs.getLong("price"));
                orderDetailList.add(orderDetail);
            }

            connection.close();
            return orderDetailList;
        } catch (SQLException e) {
            System.out.println("Get order details by product ID failed!");
            e.printStackTrace();
        }

        return null;
    }

    public static ArrayList<OrderDetail> findByShopId(int shopID) {
        try {
            ArrayList<OrderDetail> orderDetailList = new ArrayList<>();
            Connection connection = ConnectionSQL.getConnection();
            String sql = "SELECT od.* FROM order_details od " +
                    "JOIN product p ON od.product_productID = p.productID " +
                    "WHERE p.shop_shopID = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, shopID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt("orderDetailID"),
                        rs.getInt("order_orderID"),
                        rs.getInt("product_productID"),
                        rs.getInt("quantity"),
                        rs.getLong("price"));
                orderDetailList.add(orderDetail);
            }

            connection.close();
            return orderDetailList;
        } catch (SQLException e) {
            System.out.println("Get order details by shop ID failed!");
            e.printStackTrace();
        }

        return null;
    }

    public static void deleteByOrderId(int orderID) {
        try {
            Connection connection = ConnectionSQL.getConnection();
            String sql = "DELETE FROM order_details WHERE order_orderID = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, orderID);

            stmt.executeUpdate();
            connection.close();
            System.out.println("Delete order details successful!");
        } catch (SQLException e) {
            System.out.println("Delete order details failed!");
            e.printStackTrace();
        }
    }
}