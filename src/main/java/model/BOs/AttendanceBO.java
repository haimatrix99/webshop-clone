package model.BOs;

import java.util.ArrayList;

import model.DAOs.AttendanceDAO;
import model.entities.AttendanceRecord;

public class AttendanceBO {
	public static boolean addAttendance(int employeeId, String action, String vitri) {
		return AttendanceDAO.check(employeeId, action, vitri);
	}

	public static ArrayList<AttendanceRecord> findByEmployee(int employeeId) {
		return AttendanceDAO.findByEmployee(employeeId);
	}
}
