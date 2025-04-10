package model.entities;

public class Booking {
    private int id;
    private String customerName;
    private String phone;
    private String courtName;
    private String bookingDate;
    private String timeSlot;

    public Booking() {
    }

    public Booking(String customerName, String phone, String courtName, String bookingDate, String timeSlot) {
        this.customerName = customerName;
        this.phone = phone;
        this.courtName = courtName;
        this.bookingDate = bookingDate;
        this.timeSlot = timeSlot;
    }

	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCourtName() {
        return courtName;
    }

    public void setCourtName(String courtName) {
        this.courtName = courtName;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }
}