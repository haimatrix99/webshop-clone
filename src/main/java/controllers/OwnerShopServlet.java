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

import model.BOs.BookingBO;
import model.BOs.CategoryBO;
import model.BOs.OrderBO;
import model.BOs.ProductBO;
import model.entities.Booking;
import model.entities.Order;
import model.entities.Product;
import model.entities.Shop;

@WebServlet(urlPatterns = "/Trangchu/OwnerShop")
public class OwnerShopServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	ArrayList<Product> productList = new ArrayList<Product>();
	ArrayList<Booking> bookingList = new ArrayList<Booking>();
	ArrayList<Order> orderList = new ArrayList<Order>();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession ses = req.getSession();
		Shop shop = (Shop) ses.getAttribute("shop");
		productList = ProductBO.getProductsByShop(shop.getId());
		req.setAttribute("productList", productList);
		req.setAttribute("categoryList", CategoryBO.getCategorysInData());
		String courtName = req.getParameter("courtName");
		String bookingDate = req.getParameter("bookingDate");
		String timeSlot = req.getParameter("timeSlot");
		bookingList = BookingBO.findAll(courtName, bookingDate, timeSlot);
		req.setAttribute("bookingList", bookingList);

		// Get orders for this shop
		orderList = OrderBO.getOrdersByShop(shop.getId());
		req.setAttribute("orderList", orderList);

		RequestDispatcher dispatcher = req.getRequestDispatcher("/Pages/ManegerPage/OwnerShop.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		int productID;
		String product;
		String priceO;
		String priceS;
		String url;
		int categoryID;
		int shopID;
		String method = (String) req.getParameter("type");
		System.out.println(method);
		switch (method) {
			case "ADD":
				product = (String) req.getParameter("product");
				priceO = (String) req.getParameter("priceO");
				priceS = (String) req.getParameter("priceS");
				url = (String) req.getParameter("url");
				shopID = Integer.parseInt(req.getParameter("shopID"));

				// Add validation for categoryID
				String categoryIDStr = req.getParameter("categoryID");
				if (categoryIDStr != null && !categoryIDStr.trim().isEmpty()) {
					categoryID = Integer.parseInt(categoryIDStr);
				} else {
					categoryID = 4;
				}

				ProductBO.addProductToData(new Product(0, product, priceO, priceS, url, shopID, categoryID));
				break;
			case "DELETE":
				productID = Integer.parseInt(req.getParameter("pID"));
				ProductBO.deleteProductInData(productID);
				break;
			case "PUT":
				productID = Integer.parseInt((String) req.getParameter("id"));
				product = (String) req.getParameter("product");
				priceO = (String) req.getParameter("priceO");
				priceS = (String) req.getParameter("priceS");
				url = (String) req.getParameter("url");
				shopID = Integer.parseInt(req.getParameter("shopID"));
				try {
					System.out.println(req.getParameter("categoryID"));
					categoryID = Integer.parseInt(req.getParameter("categoryID"));
				} catch (Exception e) {
					categoryID = Integer.parseInt(req.getParameter("category0-ID"));
				}
				ProductBO.updateProductInData(new Product(productID, product, priceO, priceS, url, shopID, categoryID));
				break;
			case "CANCEL":
				int bookingId = Integer.parseInt(req.getParameter("bookingID"));
				boolean canceled = BookingBO.cancelBookingByOwner(bookingId);
				HttpSession session = req.getSession();
				session.setAttribute("cancelResult", canceled);
				break;
			case "COMPLETE_ORDER":
				int orderID = Integer.parseInt(req.getParameter("orderID"));
				OrderBO.updateOrderStatus(orderID, "completed");
				break;
			default:
				break;
		}
		resp.sendRedirect(req.getContextPath() + "/Trangchu/OwnerShop");
	}
}
