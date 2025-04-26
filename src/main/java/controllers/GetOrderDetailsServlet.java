package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import model.BOs.OrderBO;
import model.BOs.ProductBO;
import model.entities.Order;
import model.entities.OrderDetail;
import model.entities.Product;

@WebServlet("/Trangchu/GetOrderDetails")
public class GetOrderDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        String orderIdParam = request.getParameter("orderId");
        PrintWriter out = response.getWriter();

        try {
            if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
                sendErrorResponse(out, "Order ID is required");
                return;
            }

            int orderId = Integer.parseInt(orderIdParam);

            // Get order details
            ArrayList<OrderDetail> orderDetails = OrderBO.getOrderDetails(orderId);

            // Get order information
            ArrayList<Order> orders = OrderBO.getAllOrders();
            Order targetOrder = null;
            for (Order order : orders) {
                if (order.getOrderID() == orderId) {
                    targetOrder = order;
                    break;
                }
            }

            if (targetOrder == null) {
                sendErrorResponse(out, "Order not found");
                return;
            }

            // Create JSON response
            JsonObject jsonResponse = new JsonObject();

            // Add order information
            JsonObject jsonOrder = new JsonObject();
            jsonOrder.addProperty("orderID", targetOrder.getOrderID());
            jsonOrder.addProperty("fullName", targetOrder.getFullName());
            jsonOrder.addProperty("address", targetOrder.getAddress());
            jsonOrder.addProperty("phoneNumber", targetOrder.getPhoneNumber());
            jsonOrder.addProperty("totalAmount", targetOrder.getTotalAmount());
            jsonOrder.addProperty("status", targetOrder.getStatus());
            jsonOrder.addProperty("orderDate", targetOrder.getOrderDate());
            jsonResponse.add("order", jsonOrder);

            // Add order details
            JsonArray jsonOrderDetails = new JsonArray();
            for (OrderDetail detail : orderDetails) {
                JsonObject jsonDetail = new JsonObject();

                // Get product information
                Product product = ProductBO.getProductByID(detail.getProductID());
                String productName = product != null ? product.getFewChar() : "Unknown Product";

                jsonDetail.addProperty("orderDetailID", detail.getOrderDetailID());
                jsonDetail.addProperty("productID", detail.getProductID());
                jsonDetail.addProperty("productName", productName);
                jsonDetail.addProperty("quantity", detail.getQuantity());
                jsonDetail.addProperty("price", detail.getPrice());

                jsonOrderDetails.add(jsonDetail);
            }
            jsonResponse.add("orderDetails", jsonOrderDetails);

            // Send the response
            out.print(jsonResponse.toString());

        } catch (NumberFormatException e) {
            sendErrorResponse(out, "Invalid order ID format");
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(out, "Error processing request: " + e.getMessage());
        } finally {
            out.flush();
        }
    }

    private void sendErrorResponse(PrintWriter out, String message) {
        JsonObject errorResponse = new JsonObject();
        errorResponse.addProperty("error", true);
        errorResponse.addProperty("message", message);
        out.print(errorResponse.toString());
    }
}