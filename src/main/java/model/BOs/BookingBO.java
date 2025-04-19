package model.BOs;

import java.util.ArrayList;

import model.DAOs.BookingDAO;
import model.entities.Booking;

public class BookingBO {
	public static boolean addBooking(String customerName, String phone, String courtName, String bookingDate,
			String timeSlot, Integer clientId) {
		return BookingDAO.insert(customerName, phone, courtName, bookingDate, timeSlot, clientId);
	}

	public static ArrayList<Booking> findAll(String courtName, String bookingDate, String timeSlot) {
		return BookingDAO.findAll(courtName, bookingDate, timeSlot);
	}

	public static ArrayList<Booking> findByClientId(int clientId) {
		return BookingDAO.findByClientId(clientId);
	}

	public static boolean cancelBooking(int bookingId, int clientId) {
		return BookingDAO.cancelBooking(bookingId, clientId);
	}

	public static boolean cancelBookingByOwner(int bookingId) {
		return BookingDAO.cancelBookingByOwner(bookingId);
	}
}
