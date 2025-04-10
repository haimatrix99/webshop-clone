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
			String timeSlot) {
		try {
			Connection conn = ConnectionSQL.getConnection();
			//check trùng lịch
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
			
			//insert
			String sql = "INSERT INTO bookings (customer_name, phone, court_name, booking_date, time_slot) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerName);
			stmt.setString(2, phone);
			stmt.setString(3, courtName);
			stmt.setString(4, bookingDate);
			stmt.setString(5, timeSlot);

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
    		ArrayList<Booking> bookingList=new ArrayList<Booking>();
    		Connection conn=ConnectionSQL.getConnection();
    		  String query = "SELECT customer_name, phone, court_name, booking_date, time_slot FROM bookings " +
                      "WHERE (court_name = ? OR ? IS NULL) " +
                      "AND (booking_date = ? OR ? IS NULL) " +
                      "AND (time_slot = ? OR ? IS NULL) " +
                      "ORDER BY booking_date DESC, time_slot ASC";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, courtName);
            stmt.setString(2, (courtName==null || courtName.isEmpty()) ? null : courtName);
            stmt.setString(3, bookingDate);
            stmt.setString(4, (bookingDate==null || bookingDate.isEmpty()) ? null : bookingDate);
            stmt.setString(5, timeSlot);
            stmt.setString(6, (timeSlot==null || timeSlot.isEmpty()) ? null : timeSlot);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                bookingList.add(new Booking(
                    rs.getString("customer_name"),
                    rs.getString("phone"),
                    rs.getString("court_name"),
                    rs.getString("booking_date"),
                    rs.getString("time_slot")
                ));
            }
			return bookingList;
		} catch (SQLException e) {
			System.out.println("Get item in bookings database failed!");
			e.printStackTrace();
		}
    	
		return null;
    }
}
