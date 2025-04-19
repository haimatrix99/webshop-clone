package model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import config.ConnectionSQL;
import model.entities.AttendanceRecord;
import model.entities.Booking;

public class BookingDAO {

	public static boolean insert(String customerName, String phone, String courtName, String bookingDate,
			String timeSlot, Integer clientId) {
		try {
			Connection conn = ConnectionSQL.getConnection();
			// check trùng lịch
			String query = "SELECT * FROM bookings where booking_date = ? and time_slot = ?";
			try (PreparedStatement stmt = conn.prepareStatement(query)) {
				stmt.setString(1, bookingDate);
				stmt.setString(2, timeSlot);
				ResultSet rs = stmt.executeQuery();
				if (rs.next()) {
					System.out.println("Lịch đã có người đặt");
					return false;
				}
			}

			// insert
			String sql = "INSERT INTO bookings (customer_name, phone, court_name, booking_date, time_slot, client_id) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerName);
			stmt.setString(2, phone);
			stmt.setString(3, courtName);
			stmt.setString(4, bookingDate);
			stmt.setString(5, timeSlot);
			if (clientId != null) {
				stmt.setInt(6, clientId);
			} else {
				stmt.setNull(6, java.sql.Types.INTEGER);
			}

			int rowsInserted = stmt.executeUpdate();
			System.out.println("Add booking into database successed!");
			return rowsInserted > 0;
		} catch (SQLException e) {
			System.out.println("Add new cart into database failed!");
			e.printStackTrace();
		}
		return false;
	}

	public static ArrayList<Booking> findAll(String courtName, String bookingDate, String timeSlot) {
		try {
			ArrayList<Booking> bookingList = new ArrayList<Booking>();
			Connection conn = ConnectionSQL.getConnection();
			String query = "SELECT id, customer_name, phone, court_name, booking_date, time_slot, client_id FROM bookings "
					+
					"WHERE (court_name = ? OR ? IS NULL) " +
					"AND (booking_date = ? OR ? IS NULL) " +
					"AND (time_slot = ? OR ? IS NULL) " +
					"ORDER BY booking_date DESC, time_slot ASC";
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, courtName);
			stmt.setString(2, (courtName == null || courtName.isEmpty()) ? null : courtName);
			stmt.setString(3, bookingDate);
			stmt.setString(4, (bookingDate == null || bookingDate.isEmpty()) ? null : bookingDate);
			stmt.setString(5, timeSlot);
			stmt.setString(6, (timeSlot == null || timeSlot.isEmpty()) ? null : timeSlot);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Booking booking = new Booking(
						rs.getString("customer_name"),
						rs.getString("phone"),
						rs.getString("court_name"),
						rs.getString("booking_date"),
						rs.getString("time_slot"),
						rs.getObject("client_id") != null ? rs.getInt("client_id") : null);
				booking.setId(rs.getInt("id"));
				bookingList.add(booking);
			}
			return bookingList;
		} catch (SQLException e) {
			System.out.println("Get item in bookings database failed!");
			e.printStackTrace();
		}

		return null;
	}

	public static ArrayList<Booking> findByClientId(int clientId) {
		try {
			ArrayList<Booking> bookingList = new ArrayList<Booking>();
			Connection conn = ConnectionSQL.getConnection();
			String query = "SELECT id, customer_name, phone, court_name, booking_date, time_slot, client_id FROM bookings "
					+
					"WHERE client_id = ? " +
					"ORDER BY booking_date DESC, time_slot ASC";
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setInt(1, clientId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Booking booking = new Booking(
						rs.getString("customer_name"),
						rs.getString("phone"),
						rs.getString("court_name"),
						rs.getString("booking_date"),
						rs.getString("time_slot"),
						rs.getInt("client_id"));
				booking.setId(rs.getInt("id"));
				bookingList.add(booking);
			}
			return bookingList;
		} catch (SQLException e) {
			System.out.println("Get bookings by client ID failed!");
			e.printStackTrace();
		}

		return null;
	}

	public static boolean cancelBooking(int bookingId, int clientId) {
		try {
			Connection conn = ConnectionSQL.getConnection();
			// First check if the booking belongs to the client
			String checkQuery = "SELECT * FROM bookings WHERE id = ? AND client_id = ?";
			PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
			checkStmt.setInt(1, bookingId);
			checkStmt.setInt(2, clientId);
			ResultSet rs = checkStmt.executeQuery();
			if (!rs.next()) {
				// Booking doesn't exist or doesn't belong to this client
				return false;
			}

			// If the booking belongs to the client, delete it
			String deleteQuery = "DELETE FROM bookings WHERE id = ?";
			PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
			deleteStmt.setInt(1, bookingId);
			int rowsDeleted = deleteStmt.executeUpdate();
			return rowsDeleted > 0;
		} catch (SQLException e) {
			System.out.println("Cancel booking failed!");
			e.printStackTrace();
			return false;
		}
	}

	public static boolean cancelBookingByOwner(int bookingId) {
		try {
			Connection conn = ConnectionSQL.getConnection();
			String deleteQuery = "DELETE FROM bookings WHERE id = ?";
			PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
			deleteStmt.setInt(1, bookingId);
			int rowsDeleted = deleteStmt.executeUpdate();
			return rowsDeleted > 0;
		} catch (SQLException e) {
			System.out.println("Cancel booking by owner failed!");
			e.printStackTrace();
			return false;
		}
	}
}
