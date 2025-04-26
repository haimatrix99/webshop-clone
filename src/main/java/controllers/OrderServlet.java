package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BOs.OrderBO;
import model.entities.Client;
import model.entities.Order;
import model.entities.OrderDetail;

@WebServlet("/Trangchu/Orders")
public class OrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        HttpSession ses = req.getSession();
        Client client = (Client) ses.getAttribute("user");

        // If not logged in, redirect to login page
        if (client == null) {
            resp.sendRedirect(req.getContextPath() + "/Trangchu/SignUpIn");
            return;
        }

        // Get the order ID parameter if available
        String orderIdParam = req.getParameter("orderId");

        if (orderIdParam != null) {
            // Show order details for a specific order
            int orderId = Integer.parseInt(orderIdParam);
            ArrayList<OrderDetail> orderDetails = OrderBO.getOrderDetails(orderId);
            req.setAttribute("orderDetails", orderDetails);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/Pages/ActionDataPage/OrderDetails.jsp");
            dispatcher.forward(req, resp);
        } else {
            // Show all orders for the logged-in user
            ArrayList<Order> orders = OrderBO.getOrdersByClient(client.getId());
            req.setAttribute("orders", orders);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/Pages/ActionDataPage/Orders.jsp");
            dispatcher.forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        HttpSession ses = req.getSession();
        Client client = (Client) ses.getAttribute("user");

        // If not logged in, redirect to login page
        if (client == null) {
            resp.sendRedirect(req.getContextPath() + "/Trangchu/SignUpIn");
            return;
        }

        // Handle order cancellation
        String orderId = req.getParameter("orderId");
        String action = req.getParameter("action");

        if (orderId != null && action != null && action.equals("cancel")) {
            OrderBO.updateOrderStatus(Integer.parseInt(orderId), "cancelled");
            resp.sendRedirect(req.getContextPath() + "/Trangchu/Orders");
            return;
        }

        // Default: redirect back to orders list
        resp.sendRedirect(req.getContextPath() + "/Trangchu/Orders");
    }
}