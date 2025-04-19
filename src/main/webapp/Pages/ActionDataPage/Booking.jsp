<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.entities.Booking"%>
<%@ page import="model.entities.Client"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đặt Sân Bóng Rổ</title>
<link rel="icon" href="/style/assets/images/logoShop/LOGO CAMSPORT.png" type="image/png">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/style/assets/css/booking.css">
<style>
.cancel-btn {
    background-color: #e74c3c;
    color: white;
    border: none;
    border-radius: 4px;
    padding: 4px 8px;
    cursor: pointer;
    font-size: 12px;
}
.cancel-btn:hover {
    background-color: #c0392b;
}
.booking-status {
    margin: 10px 0;
    padding: 10px;
    border-radius: 4px;
}
.success {
    background-color: #dff0d8;
    color: #3c763d;
}
.error {
    background-color: #f2dede;
    color: #a94442;
}
.my-bookings {
    margin-top: 20px;
    padding: 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background-color: #f9f9f9;
}
</style>
</head>
<%@ include file="/Pages/MasterPage/Header.jsp"%>
<body>
	<%
	Client loggedInClient = (Client) session.getAttribute("user");
	%>
	<div class="container" style="padding-top: 100px">
		<div style="display: flex; flex-direction: column; align-items: center; text-align: center;">
    <div style="display: flex; align-items: center;">
        <div>
            <img src="/style/assets/images/logoShop/LOGO CAMSPORT.png" alt="" style="width: 80px; border-radius: 50%;">
        </div>
        <div style ="margin-left: 10px">
            <h1 style="font-size: 30px;">CAMSPORT</h1>
        </div>
    </div>
</div>
		
		<%
		Boolean isBooked = (Boolean) request.getAttribute("isBooked");
		Boolean cancelResult = (Boolean) request.getAttribute("cancelResult");
		if (isBooked != null && isBooked) {
		%>
		<div class="booking-status error">
			<p>Sân đã được đặt trước rồi!</p>
		</div>
		<%
		} else if (isBooked != null && !isBooked) {
		%>
		<div class="booking-status success">
			<p>Đặt sân thành công!</p>
		</div>
		<%
		}
		
		if (cancelResult != null) {
			if (cancelResult) {
		%>
		<div class="booking-status success">
			<p>Hủy đặt sân thành công!</p>
		</div>
		<%
			} else {
		%>
		<div class="booking-status error">
			<p>Không thể hủy đặt sân!</p>
		</div>
		<%
			}
		}
		%>
		
		<!-- Show client's bookings if logged in -->
		<%
		if (loggedInClient != null) {
			List<Booking> clientBookings = (List<Booking>) request.getAttribute("clientBookings");
			if (clientBookings != null && !clientBookings.isEmpty()) {
		%>
		<div class="my-bookings">
			<h2>Lịch Đặt Sân Của Bạn</h2>
			<div class="table-container">
				<table class="booking-table">
					<thead>
						<tr>
							<th>Sân</th>
							<th>Ngày</th>
							<th>Khung giờ</th>
							<th>Hành động</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Booking booking : clientBookings) {
						%>
						<tr>
							<td><%=booking.getCourtName()%></td>
							<td><%=booking.getBookingDate()%></td>
							<td><%=booking.getTimeSlot()%></td>
							<td>
								<a href="<%=request.getContextPath()%>/Trangchu/DatSan?action=cancel&bookingId=<%=booking.getId()%>" 
								   class="cancel-btn" 
								   onclick="return confirm('Bạn có chắc chắn muốn hủy đặt sân này không?')">
									Hủy đặt sân
								</a>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<%
			}
		}
		%>

		<!-- Form tra cứu lịch sử đặt sân -->
		<div class="search-form">
			<h2>Tra Cứu Lịch Sử Đặt Sân</h2>
			<form method="get"
				action="<%=request.getContextPath()%>/Trangchu/DatSan">
				<div class="form-group">
					<label for="courtName">Sân:</label> <select id="courtName"
						name="courtName">
						<option value="">Tất cả</option>
						<option value="Sân 1">Sân 1</option>
						<option value="Sân 2">Sân 2</option>
						<option value="Sân 3">Sân 3</option>
					</select> <label for="bookingDate">Ngày:</label> <input type="date"
						id="bookingDate" name="bookingDate"> <label for="timeSlot">Giờ:</label>
					<select id="timeSlot" name="timeSlot">
						<option value="">Tất cả</option>
						<option value="08:00 - 10:00">08:00 - 10:00</option>
						<option value="10:00 - 12:00">10:00 - 12:00</option>
						<option value="14:00 - 16:00">14:00 - 16:00</option>
						<option value="16:00 - 18:00">16:00 - 18:00</option>
					</select>

					<button type="submit">Tìm Kiếm</button>
				</div>
			</form>
		</div>


		<div class="layout">
			<!-- Cột trái: Lịch sử đặt sân -->
			<div class="column">
				<h2 style="font-size: 30px">Lịch Sử Đặt Sân Gần Đây</h2>
				<div class="table-container">
					<table class="booking-table">
						<thead>
							<tr>
								<th>Khách hàng</th>
								<th>SĐT</th>
								<th>Sân</th>
								<th>Ngày</th>
								<th>Khung giờ</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<Booking> bookingList = (List<Booking>) request.getAttribute("bookingList");
							if (bookingList != null && !bookingList.isEmpty()) {
								for (Booking booking : bookingList) {
							%>
							<tr>
								<td><%=booking.getCustomerName()%></td>
								<td><%=booking.getPhone()%></td>
								<td><%=booking.getCourtName()%></td>
								<td><%=booking.getBookingDate()%></td>
								<td><%=booking.getTimeSlot()%></td>
							</tr>
							<%
							}
							} else {
							%>
							<tr>
								<td colspan="5">Không có lịch sử đặt sân</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

			<!-- Cột phải: Form đặt sân -->
			<div class="column"
				style="margin-top: -140px; width: 50%; margin-left: auto; margin-right: auto;">
				<h2 style="font-size: 30px;">Đặt Sân</h2>
				
				<form method="post"
					style="display: flex; flex-direction: column; width: 100%;">
					<%
					if (loggedInClient == null) {
					%>
					<label for="customerName" style="margin-top: 10px;">Họ tên:</label>
					<input type="text" id="customerName" name="customerName" required
						style="width: 100%; padding: 8px; margin-top: 5px;"> 
					<label for="phone" style="margin-top: 10px;">Số điện thoại:</label> 
					<input type="text" id="phone" name="phone" required
						style="width: 100%; padding: 8px; margin-top: 5px;">
					<%
					} else {
					%>
					<div style="margin: 10px 0; padding: 10px; background-color: #f8f9fa; border-radius: 4px;">
						<p>Đặt sân với tên: <strong><%=loggedInClient.getFullName()%></strong></p>
						<p>Số điện thoại: <strong><%=loggedInClient.getPhone()%></strong></p>
					</div>
					<%
					}
					%>
					<label for="courtName" style="margin-top: 10px;">Chọn sân:</label> 
					<select id="courtName" name="courtName"
						style="width: 100%; padding: 8px; margin-top: 5px;">
						<option value="Sân 1">Sân 1</option>
						<option value="Sân 2">Sân 2</option>
						<option value="Sân 3">Sân 3</option>
					</select> 
					<label for="bookingDate" style="margin-top: 10px;">Ngày đặt:</label> 
					<input type="date" id="bookingDate" name="bookingDate"
						required style="width: 100%; padding: 8px; margin-top: 5px;">

					<label for="timeSlot" style="margin-top: 10px;">Khung giờ:</label>
					<select id="timeSlot" name="timeSlot"
						style="width: 100%; padding: 8px; margin-top: 5px;">
						<option value="08:00 - 10:00">08:00 - 10:00</option>
						<option value="10:00 - 12:00">10:00 - 12:00</option>
						<option value="14:00 - 16:00">14:00 - 16:00</option>
						<option value="16:00 - 18:00">16:00 - 18:00</option>
					</select>

					<button type="submit"
						style="background-color: orange; color: white; border: none; cursor: pointer; padding: 10px; margin-top: 10px;">Đặt
						sân</button>
				</form>
			</div>
		</div>

		<!-- Hình ảnh các sân -->
		<div class="court-images">
			<h3 style="font-size: 30px">Hình ảnh các sân</h3>
			<div class="image-gallery">
				Sân 1<img
					src="https://wikisport.vn/uploads/2022/kich-thuoc-san-bong-ro-tieu-chuan.jpg"
					alt="Sân 1"> Sân 2<img
					src="https://www.sanbongro.com.vn/uploads/supply/2019/12/20/san_tong_hop_bong_ro.png"
					alt="Sân 2"> Sân 3<img
					src="https://munichgroup.vn/wp-content/uploads/2024/11/san-bong-ro-dep-18.webp"
					alt="Sân 3">
			</div>
		</div>
	</div>
	<div
		style="width: 100%; background-color: #ee4d2d; height: 6px; margin-top: 10px; margin-bottom: 40px;"></div>
</body>
</html>
