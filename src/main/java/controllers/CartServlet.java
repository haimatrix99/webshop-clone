package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BOs.CartBO;
import model.BOs.OrderBO;
import model.BOs.OrderDetailBO;
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

		HttpSession ses = req.getSession();
		Client client = (Client) ses.getAttribute("user");

		String actionCart = (String) req.getParameter("actionCart");
		if (actionCart != null) {
			int cartID = Integer.parseInt(req.getParameter("cartID"));
			int quantity;

			if (client != null) {
				// Logged-in user - use database
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
			} else {
				// Non-logged in user - use session
				@SuppressWarnings("unchecked")
				List<Cart> sessionCart = (List<Cart>) ses.getAttribute("sessionCart");
				if (sessionCart != null) {
					switch (actionCart) {
						case "remove":
							for (int i = 0; i < sessionCart.size(); i++) {
								if (sessionCart.get(i).getCartID() == cartID) {
									sessionCart.remove(i);
									break;
								}
							}
							break;
						case "plus":
							quantity = Integer.parseInt(req.getParameter("quantity"));
							for (Cart cart : sessionCart) {
								if (cart.getCartID() == cartID) {
									cart.setQuantity(quantity + 1);
									break;
								}
							}
							break;
						case "minus":
							quantity = Integer.parseInt(req.getParameter("quantity"));
							for (Cart cart : sessionCart) {
								if (cart.getCartID() == cartID) {
									if (quantity > 1) {
										cart.setQuantity(quantity - 1);
									}
									break;
								}
							}
							break;
						default:
							break;
					}
					ses.setAttribute("sessionCart", sessionCart);
				}
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

		// Check if this is an order submission (with customer info)
		String fullName = req.getParameter("fullName");
		String address = req.getParameter("address");
		String phoneNumber = req.getParameter("phoneNumber");
		String totalMoneyStr = req.getParameter("totalMoney");
		String createOrder = req.getParameter("createOrder");

		if (fullName != null && address != null && phoneNumber != null && totalMoneyStr != null
				&& createOrder != null) {
			// This is a checkout form submission
			long totalMoney = Long.parseLong(totalMoneyStr);

			// Get cart items from form
			String itemCountStr = req.getParameter("itemCount");
			int itemCount = Integer.parseInt(itemCountStr);

			// Prepare a map to store product IDs and quantities
			HashMap<Integer, Integer> cartItems = new HashMap<>();

			// Collect all cart items
			for (int i = 0; i < itemCount; i++) {
				int productID = Integer.parseInt(req.getParameter("productID_" + i));
				int quantity = Integer.parseInt(req.getParameter("quantity_" + i));
				long price = Long.parseLong(req.getParameter("price_" + i));

				cartItems.put(productID, quantity);
			}

			// Create order with cart items for logged-in user
			if (client != null) {
				// Create order and store delivery information with all products
				int orderID = OrderBO.createOrderWithProducts(fullName, address, phoneNumber, client.getId(),
						totalMoney, cartItems);

				if (orderID != -1) {
					// Process payment and clear cart
					CartBO.paymentInCart(client.getId(), totalMoney);
				}
			} else {
				// For guest checkout
				// Create order with a guest client ID (-1)
				int orderID = OrderBO.createOrderWithProducts(fullName, address, phoneNumber, -1, totalMoney,
						cartItems);

				// Clear session cart after successful order
				if (orderID != -1) {
					ses.removeAttribute("sessionCart");
				}
			}

			// Redirect to a success or thank you page
			resp.sendRedirect(req.getContextPath() + "/Trangchu");
			return;
		}

		// Original cart payment logic (without customer info)
		if (totalMoneyStr != null && client != null && createOrder == null) {
			long totalMoney = Long.parseLong(totalMoneyStr);
			CartBO.paymentInCart(client.getId(), totalMoney);
		}

		// Original add to cart logic
		String productIDStr = req.getParameter("productID");
		if (productIDStr != null) {
			int productID = Integer.parseInt(req.getParameter("productID"));

			if (client != null) {
				// Logged-in user - add to database
				String clientIDStr = req.getParameter("clientID");
				if (clientIDStr != null) {
					int clientID = Integer.parseInt(clientIDStr);
					Cart cart = new Cart(0, 1, "", clientID, productID);
					CartBO.addCartToData(cart);
				}
			} else {
				// Non-logged in user - add to session
				@SuppressWarnings("unchecked")
				List<Cart> sessionCart = (List<Cart>) ses.getAttribute("sessionCart");

				if (sessionCart == null) {
					sessionCart = new ArrayList<>();
				}

				// Check if product already exists in cart
				boolean productExists = false;
				for (Cart cart : sessionCart) {
					if (cart.getProductID() == productID) {
						cart.setQuantity(cart.getQuantity() + 1);
						productExists = true;
						break;
					}
				}

				// If product doesn't exist, add it with a unique temporary ID
				if (!productExists) {
					int tempID = (int) (System.currentTimeMillis() % 100000);
					Cart newCart = new Cart(tempID, 1, "", -1, productID);
					sessionCart.add(newCart);
				}

				ses.setAttribute("sessionCart", sessionCart);
			}
		}

		resp.sendRedirect(req.getContextPath() + "/Trangchu/GioHang");
	}
}
