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
import com.restfb.types.User;
import common.RestFB;
import model.BOs.ClientBO;
import model.BOs.OwnerShopBO;
import model.entities.Client;
import model.entities.Product;
import model.entities.Shop;
import model.entities.Cart;

@WebServlet(urlPatterns = "/Trangchu/SignUpIn")
public class SignUpInServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	ArrayList<Product> productList = new ArrayList<Product>();
	private String userAdmin = "Admin";
	private String passAdmin = "0123456789";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession ses = req.getSession();

		// Check if we need to keep the cart
		String keepCart = req.getParameter("keepCart");
		if (keepCart != null && keepCart.equals("true")) {
			// Don't clear the session cart if we're keeping it
		} else {
			// Only clear access information, not cart
			ses.setAttribute("accesser", "unknow");
			ses.setAttribute("eror", null);
		}

		String code = req.getParameter("code");
		if (code == null || code.isEmpty()) {
			RequestDispatcher dispatcher = req.getRequestDispatcher("/Pages/SignUp-In/SignUpIn.jsp");
			dispatcher.forward(req, resp);
		} else {
			// login by facebook
			String accessToken = RestFB.getToken(code);
			User user = RestFB.getUserInfo(accessToken);
			Client client = new Client(0, user.getId(), null, "0", user.getName(), null, null, null, null, "0");
			int idClient = ClientBO.addClientToData(client);
			client.setId(idClient);
			ses.setAttribute("accesser", "user");
			ses.setAttribute("user", client);
			resp.sendRedirect(req.getContextPath() + "/Trangchu");
		}

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		String account = (String) req.getParameter("account");
		String user = null, pass = null, accesser = null;
		HttpSession ses = req.getSession();
		switch (account) {
			case "client":
				user = (String) req.getParameter("user");
				pass = (String) req.getParameter("password");
				String name = (String) req.getParameter("fullName");
				String address = (String) req.getParameter("address");
				String phone = (String) req.getParameter("phone");
				String birthday = (String) req.getParameter("birthday");
				Client client = new Client(0, user, pass, "1000000000", name, birthday, address, phone, null, "0");
				ClientBO.addClientToData(client);
				ses.setAttribute("accesser", "user");
				ses.setAttribute("user", client);

				// Handle cart merge for new registered user
				mergeSessionCartWithUserCart(ses, client.getId());

				resp.sendRedirect(req.getContextPath() + "/Trangchu");
				break;
			case "shop":
				user = (String) req.getParameter("user");
				pass = (String) req.getParameter("password");
				String nameShop = (String) req.getParameter("nameShop");
				String urlAvatar = (String) req.getParameter("urlAvatar");
				Shop shop = new Shop(0, user, pass, nameShop, urlAvatar);
				OwnerShopBO.addShopToData(shop);
				ses.setAttribute("accesser", "shop");
				ses.setAttribute("shop", shop);
				resp.sendRedirect(req.getContextPath() + "/Trangchu/OwnerShop");
				break;
			case "login":
				user = (String) req.getParameter("user");
				pass = (String) req.getParameter("password");
				Client object1 = ClientBO.getAccesser(user, pass);
				if (object1 != null) {
					ses.setAttribute("accesser", "user");
					ses.setAttribute("user", object1);

					// Handle cart merge for login user
					mergeSessionCartWithUserCart(ses, object1.getId());

					break;
				}
				Shop object2 = OwnerShopBO.getAccesser(user, pass);
				if (object2 != null) {
					ses.setAttribute("accesser", "shop");
					ses.setAttribute("shop", object2);
					break;
				}
		}
		accesser = (String) ses.getAttribute("accesser");
		if (account.equals("login")) {
			if (user.equals(userAdmin) && pass.equals(passAdmin)) {
				ses.setAttribute("eror", null);
				ses.setAttribute("accesser", "admin");
				resp.sendRedirect(req.getContextPath() + "/Admin");
			} else if (accesser.equals("user")) {
				ses.setAttribute("eror", null);
				resp.sendRedirect(req.getContextPath() + "/Trangchu");
			} else if (accesser.equals("shop")) {
				ses.setAttribute("eror", null);
				resp.sendRedirect(req.getContextPath() + "/Trangchu/OwnerShop");
			} else {
				ses.setAttribute("eror", "Sai tài khoản hoặc mật khẩu!");
				RequestDispatcher dispatcher = req.getRequestDispatcher("/Pages/SignUp-In/SignUpIn.jsp");
				dispatcher.forward(req, resp);
			}
		}
	}

	/**
	 * Helper method to merge session cart with user cart after login
	 * 
	 * @param session  The HttpSession
	 * @param clientId The logged in client's ID
	 */
	private void mergeSessionCartWithUserCart(HttpSession session, int clientId) {
		// Get session cart
		@SuppressWarnings("unchecked")
		List<Cart> sessionCart = (List<Cart>) session.getAttribute("sessionCart");

		// If there are items in the session cart, add them to the user's cart
		if (sessionCart != null && !sessionCart.isEmpty()) {
			for (Cart cartItem : sessionCart) {
				// Create a new cart item for the user
				Cart userCartItem = new Cart(0, cartItem.getQuantity(), "", clientId, cartItem.getProductID());
				model.BOs.CartBO.addCartToData(userCartItem);
			}

			// Clear session cart after transferring items
			session.removeAttribute("sessionCart");
		}
	}
}
