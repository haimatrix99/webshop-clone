package model.BOs;

import java.util.ArrayList;

import model.DAOs.OrderDetailDAO;
import model.entities.OrderDetail;

public class OrderDetailBO {

    public static void addProductToOrder(int orderID, int productID, int quantity, long price) {
        OrderDetailDAO.insert(orderID, productID, quantity, price);
    }

    public static ArrayList<OrderDetail> getOrderDetailsByOrder(int orderID) {
        return OrderDetailDAO.findByOrderId(orderID);
    }

    public static ArrayList<OrderDetail> getOrderDetailsByProduct(int productID) {
        return OrderDetailDAO.findByProductId(productID);
    }

    public static ArrayList<OrderDetail> getOrderDetailsByShop(int shopID) {
        return OrderDetailDAO.findByShopId(shopID);
    }

    public static void deleteOrderDetails(int orderID) {
        OrderDetailDAO.deleteByOrderId(orderID);
    }
}