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

		ArrayList<Booking> bookingList = BookingBO.findAll(courtName, bookingDate, timeSlot);
		req.setAttribute("bookingList", bookingList);

		HttpSession session = req.getSession();
		Boolean isBooked = (Boolean) session.getAttribute("isBooked");
		System.out.println("block: " + isBooked);
		req.setAttribute("isBooked", isBooked);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/Pages/ActionDataPage/Booking.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		String customerName = request.getParameter("customerName");
		String phone = request.getParameter("phone");
		String courtName = request.getParameter("courtName");
		String bookingDate = request.getParameter("bookingDate");
		String timeSlot = request.getParameter("timeSlot");
		boolean result = BookingBO.addBooking(customerName, phone, courtName, bookingDate, timeSlot);
		HttpSession session = request.getSession();
		session.setAttribute("isBooked", !result);
		resp.sendRedirect(request.getContextPath() + "/Trangchu/DatSan");
	}
}
