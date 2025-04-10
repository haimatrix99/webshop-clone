package model.entities;

import java.sql.Timestamp;

public class AttendanceRecord {
	private String date;
	private Timestamp checkinTime;
	private Timestamp checkoutTime;
	private String status;
	private String location;

	public AttendanceRecord(String date, Timestamp checkinTime, Timestamp checkoutTime, String status,
			String location) {
		this.date = date;
		this.checkinTime = checkinTime;
		this.checkoutTime = checkoutTime;
		this.status = status;
		this.location = location;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getDate() {
		return date;
	}

	public Timestamp getCheckinTime() {
		return checkinTime;
	}

	public Timestamp getCheckoutTime() {
		return checkoutTime;
	}

	public String getStatus() {
		return status;
	}
}
