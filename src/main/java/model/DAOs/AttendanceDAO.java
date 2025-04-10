package model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import config.ConnectionSQL;
import model.entities.AttendanceRecord;

public class AttendanceDAO {
	public static boolean check(int employeeId, String action, String vitri) {
		LocalDateTime now = LocalDateTime.now();
		String formattedDate = now.toLocalDate().toString();
		String formattedTime = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

		try (Connection conn = ConnectionSQL.getConnection()) {
			if ("checkin".equals(action)) {
				String sql = "INSERT INTO attendance (employee_id, checkin_time, date, status, location) VALUES (?, ?, ?, 'Checked-in',?) "
						+ "ON DUPLICATE KEY UPDATE checkin_time = VALUES(checkin_time), status = 'Checked-in'";
				try (PreparedStatement stmt = conn.prepareStatement(sql)) {
					stmt.setInt(1, employeeId);
					stmt.setString(2, formattedTime);
					stmt.setString(3, formattedDate);
					stmt.setString(4, vitri);
					stmt.executeUpdate();
				}
			} else if ("checkout".equals(action)) {
				String sql = "UPDATE attendance SET checkout_time = ?, status = 'Checked-out' WHERE employee_id = ? AND date = ?";
				try (PreparedStatement stmt = conn.prepareStatement(sql)) {
					stmt.setString(1, formattedTime);
					stmt.setInt(2, employeeId);
					stmt.setString(3, formattedDate);
					stmt.executeUpdate();
				}
			}
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static ArrayList<AttendanceRecord> findByEmployee(int employeeId) {
		try {
			ArrayList<AttendanceRecord> attendanceList = new ArrayList<AttendanceRecord>();
			Connection conn = ConnectionSQL.getConnection();
			String sql = "SELECT date, checkin_time, checkout_time, status, location FROM attendance WHERE employee_id = ? ORDER BY date DESC";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, employeeId);
				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					AttendanceRecord record = new AttendanceRecord(rs.getString("date"),
							rs.getTimestamp("checkin_time"), rs.getTimestamp("checkout_time"), rs.getString("status"), rs.getString("location"));
					attendanceList.add(record);
				}
			}
			return attendanceList;
		} catch (SQLException e) {
			System.out.println("Get item in AttendanceRecord database failed!");
			e.printStackTrace();
		}

		return null;
	}
}
