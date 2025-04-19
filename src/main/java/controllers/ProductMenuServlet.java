package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BOs.ProductBO;
import model.BOs.CartBO;
import model.entities.Cart;
import model.entities.Client;
import model.entities.Product;

@WebServlet(urlPatterns = "/Trangchu/ProductMenu")
public class ProductMenuServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	ArrayList<Product> productList = new ArrayList<Product>();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		ArrayList<Product> productList = new ArrayList<Product>();
		String search = req.getParameter("search");
		String categoryID = req.getParameter("categoryID");
		if (search == null) {
			if (categoryID == null) {
				productList = ProductBO.getProductFromData();
			} else {
				productList = ProductBO.getProductsByCategory(Integer.parseInt(categoryID));
			}
		} else {
			productList = ProductBO.searchProducts(search);
		}
		req.setAttribute("productList", productList);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/ProductMenu.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		int productID = Integer.parseInt(req.getParameter("productID"));

		HttpSession ses = req.getSession();
		Client client = (Client) ses.getAttribute("user");

		if (client != null) {
			// Logged-in user - add to database
			int clientID = Integer.parseInt(req.getParameter("clientID"));
			Cart cart = new Cart(0, 1, "", clientID, productID);
			CartBO.addCartToData(cart);
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

		// Redirect back to the product menu page with the same parameters as the
		// request
		String redirectUrl = req.getContextPath() + "/Trangchu/ProductMenu";
		String search = req.getParameter("search");
		String categoryID = req.getParameter("categoryID");

		if (search != null) {
			redirectUrl += "?search=" + search;
		} else if (categoryID != null) {
			redirectUrl += "?categoryID=" + categoryID;
		}

		resp.sendRedirect(redirectUrl);
	}
}
