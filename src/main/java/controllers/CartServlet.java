package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BOs.CartBO;
import model.entities.Cart;
import model.entities.Client;

@WebServlet("/Trangchu/GioHang")
public class CartServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		String actionCart = (String) req.getParameter("actionCart");
		if (actionCart != null) {
			int cartID = Integer.parseInt(req.getParameter("cartID"));
			int quantity;
			switch (actionCart) {
			case "remove":
				CartBO.deleteItemInCart(cartID);
				break;
			case "plus":
				quantity = Integer.parseInt(req.getParameter("quantity"));
				CartBO.increaseItemInCart(cartID, quantity);
				break;
			case "minus":
				quantity = Integer.parseInt(req.getParameter("quantity"));
				CartBO.decreaseItemInCart(cartID, quantity);
				break;
			default:
				break;
			}
		}
		RequestDispatcher dispatcher = req.getRequestDispatcher("/Pages/ActionDataPage/Cart.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("Do post method cart is called!");
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession ses = req.getSession();
		Client client = (Client) ses.getAttribute("user");
		String totalMoneyStr = req.getParameter("totalMoney");
		if (totalMoneyStr != null) {
			long totalMoney = Long.parseLong(totalMoneyStr);
			CartBO.paymentInCart(client.getId(), totalMoney);
		}
		String productIDStr = req.getParameter("productID");
		String clientIDStr = req.getParameter("clientID");
		if (productIDStr != null && clientIDStr != null) {
			int productID = Integer.parseInt(req.getParameter("productID"));
			int clientID = Integer.parseInt(req.getParameter("clientID"));
			Cart cart = new Cart(0, 1, "", clientID, productID);
			CartBO.addCartToData(cart);
		}
		resp.sendRedirect(req.getContextPath() + "/Trangchu/GioHang");
	}
}
