package model.BOs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import model.DAOs.OrderDAO;
import model.entities.Order;
import model.entities.OrderDetail;
import model.entities.Product;

public class OrderBO {

    public static int createOrder(String fullName, String address, String phoneNumber, int clientID,
            long totalAmount) {
        return OrderDAO.insert(fullName, address, phoneNumber, clientID, totalAmount);
    }

    public static int createOrderWithProducts(String fullName, String address, String phoneNumber, int clientID,
            long totalAmount, HashMap<Integer, Integer> cartItems) {
        // First create the order
        int orderID = OrderDAO.insert(fullName, address, phoneNumber, clientID, totalAmount);

        if (orderID != -1) {
            // Then add all products to the order
            for (Map.Entry<Integer, Integer> entry : cartItems.entrySet()) {
                int productID = entry.getKey();
                int quantity = entry.getValue();

                // Get product price
                Product product = ProductBO.getProductByID(productID);
                long price = Long.parseLong(product.getSalePrice());

                // Add product to order
                OrderDetailBO.addProductToOrder(orderID, productID, quantity, price);
            }
        }

        return orderID;
    }

    public static ArrayList<Order> getAllOrders() {
        return OrderDAO.findAll();
    }

    public static ArrayList<Order> getOrdersByClient(int clientID) {
        return OrderDAO.findByClientId(clientID);
    }

    public static ArrayList<Order> getOrdersByShop(int shopID) {
        return OrderDAO.findByShopId(shopID);
    }

    public static void updateOrderStatus(int orderID, String status) {
        OrderDAO.updateStatusByOrderId(orderID, status);
    }

    public static void deleteOrder(int orderID) {
        // This will delete order details first, then the order
        OrderDAO.deleteByOrderId(orderID);
    }

    public static ArrayList<OrderDetail> getOrderDetails(int orderID) {
        return OrderDetailBO.getOrderDetailsByOrder(orderID);
    }
}