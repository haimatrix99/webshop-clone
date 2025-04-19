package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;

import model.BOs.BookingBO;
import model.entities.Booking;
import model.entities.Client;

@WebServlet("/Trangchu/DatSan")
public class BookingServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		String courtName = req.getParameter("courtName");
		String bookingDate = req.getParameter("bookingDate");
		String timeSlot = req.getParameter("timeSlot");

		// Get the action parameter (if any)
		String action = req.getParameter("action");

		HttpSession session = req.getSession();
		Client client = (Client) session.getAttribute("user");

		// Handle cancel booking action
		if ("cancel".equals(action) && client != null) {
			int bookingId = Integer.parseInt(req.getParameter("bookingId"));
			boolean canceled = BookingBO.cancelBooking(bookingId, client.getId());
			session.setAttribute("cancelResult", canceled);
			resp.sendRedirect(req.getContextPath() + "/Trangchu/DatSan");
			return;
		}

		ArrayList<Booking> bookingList = BookingBO.findAll(courtName, bookingDate, timeSlot);
		req.setAttribute("bookingList", bookingList);

		// If user is logged in, get their bookings
		if (client != null) {
			ArrayList<Booking> clientBookings = BookingBO.findByClientId(client.getId());
			req.setAttribute("clientBookings", clientBookings);
		}

		Boolean isBooked = (Boolean) session.getAttribute("isBooked");
		Boolean cancelResult = (Boolean) session.getAttribute("cancelResult");

		req.setAttribute("isBooked", isBooked);
		req.setAttribute("cancelResult", cancelResult);

		// Clear session attributes after use
		session.setAttribute("isBooked", null);
		session.setAttribute("cancelResult", null);

		RequestDispatcher dispatcher = req.getRequestDispatcher("/Pages/ActionDataPage/Booking.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		// Get booking information from the request
		String customerName = request.getParameter("customerName");
		String phone = request.getParameter("phone");
		String courtName = request.getParameter("courtName");
		String bookingDate = request.getParameter("bookingDate");
		String timeSlot = request.getParameter("timeSlot");

		// Get client ID if user is logged in
		HttpSession session = request.getSession();
		Client client = (Client) session.getAttribute("user");
		Integer clientId = null;

		if (client != null) {
			clientId = client.getId();
			// If client is logged in, use their information
			customerName = client.getFullName();
			phone = client.getPhone();
		}

		// Add the booking with client ID if available
		boolean result = BookingBO.addBooking(customerName, phone, courtName, bookingDate, timeSlot, clientId);

		session.setAttribute("isBooked", !result);

		resp.sendRedirect(request.getContextPath() + "/Trangchu/DatSan");
	}
}
