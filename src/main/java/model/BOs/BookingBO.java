package model.BOs;

import java.util.ArrayList;

import model.DAOs.BookingDAO;
import model.entities.Booking;

public class BookingBO {
	public static boolean addBooking(String customerName, String phone, String courtName, String bookingDate,
			String timeSlot) {
		return BookingDAO.insert(customerName, phone, courtName, bookingDate, timeSlot);
	}

	public static ArrayList<Booking> findAll(String courtName, String bookingDate, String timeSlot) {
		return BookingDAO.findAll(courtName, bookingDate, timeSlot);
	}
}
