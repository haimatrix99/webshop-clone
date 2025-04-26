<%@page import="model.BOs.CategoryBO"%>
<%@page import="model.entities.Category"%>
<%@page import="model.entities.Shop"%>
<%@page import="model.entities.Product"%>
<%@page import="model.entities.Booking"%>
<%@page import="model.entities.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>SHOP MALL</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
<script
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.6/js/standalone/selectize.min.js"
	integrity="sha256-+C0A5Ilqmu4QcSPxrlGpaZxJ04VjsRjKu+G82kl5UJk="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.6/css/selectize.bootstrap3.min.css"
	integrity="sha256-ze/OEYGcFbPRmvCnrSeKbRTtjG4vGLHXgOqsyLFTRjg="
	crossorigin="anonymous" />
<script type="text/javascript">
	$(document).ready(function() {
		$('select').selectize({
			sortField : 'text'
		});
	});
</script>
<style>
body {
	min-height: 100vh;
	background-color: #FFE53B;
	background-image: linear-gradient(147deg, #FFE53B 0%, #FF2525 100%);
}

@media (min-width: 1200px) {
	.container {
		max-width: 100%;
	}
}
</style>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap')
	;

@import
	url('https://fonts.googleapis.com/css2?family=Arimo:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700&display=swap')
	;

* {
	margin: 0;
	box-sizing: border-box;
}

#contact {
	color: #fff;
	width: 100%;
	height: 100%;
	position: fixed;
	background-color: rgba(0, 0, 0, 0.1);
	display: flex;
	justify-content: center;
	align-items: center;
	top: 0;
	bottom: 0;
}

.contact-box {
	width: clamp(100px, 90%, 1000px);
	margin: 80px 50px;
	display: flex;
	flex-wrap: wrap;
}

.contact-links, .contact-form-wrapper {
	width: 50%;
	padding: 8% 5% 10% 5%;
}

.contact-links {
	padding: 0 !important;
}

.contact-form-wrapper {
	position: relative;
	background-color: #FF4B2B;
	border-radius: 0 10px 10px 0;
}

@media only screen and (max-width: 800px) {
	.contact-links, .contact-form-wrapper {
		width: 100%;
	}
	.contact-links {
		border-radius: 10px 10px 0 0;
	}
	.contact-form-wrapper {
		border-radius: 0 0 10px 10px;
	}
}

@media only screen and (max-width: 400px) {
	.contact-box {
		width: 95%;
		margin: 8% 5%;
	}
}

h2 {
	font-family: 'Arimo', sans-serif;
	color: #fff;
	font-size: clamp(30px, 6vw, 60px);
	letter-spacing: 2px;
	text-align: center;
	transform: scale(.95, 1);
}

.links {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	padding-top: 50px;
}

.link {
	margin: 10px;
	cursor: pointer;
}

img {
	width: 100%;
	height: 100%;
	transition: 0.2s;
	user-select: none;
}

img:hover {
	transform: scale(1.1, 1.1);
}

img:active {
	transform: scale(1.1, 1.1);
	filter: hue-rotate(220deg) drop-shadow(2px 4px 4px #222) sepia(0.3);
}

.form-item {
	position: relative;
}

.form-item>input {
	width: 100%;
	outline: 0;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-bottom: 20px;
	padding: 12px;
	font-size: clamp(15px, 1.5vw, 18px);
}

label, input, textarea {
	font-family: 'Poppins', sans-serif;
}

textarea {
	width: 100%;
	outline: 0;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-bottom: 20px;
	padding: 12px;
	font-size: clamp(15px, 1.5vw, 18px);
}

input:focus+label, input:valid+label, textarea:focus+label, textarea:valid+label
	{
	font-size: clamp(13px, 1.3vw, 16px);
	color: #777;
	top: -20px;
	transition: all .225s ease;
}

.submit-btn {
	filter: drop-shadow(2px 2px 3px #0003);
	color: #FF4B2B;
	font-family: "Poppins", sans-serif;
	font-size: clamp(16px, 1.6vw, 18px);
	display: block;
	padding: 12px 20px;
	margin: 2px auto;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	user-select: none;
	transition: 0.2s;
}

.submit-btn:hover {
	transform: scale(1.1, 1.1);
}

.submit-btn:active {
	transform: scale(1.1, 1.1);
	filter: sepia(0.5);
}

@media only screen and (max-width: 800px) {
	h2 {
		font-size: clamp(40px, 10vw, 60px);
	}
}

@media only screen and (max-width: 400px) {
	h2 {
		font-size: clamp(30px, 12vw, 60px);
	}
	.links {
		padding-top: 30px;
	}
	img {
		width: 38px;
		height: 38px;
	}
}

.close {
	display: none !important;
}

.btn-close:hover {
	opacity: 0.5;
}
</style>
</head>
<body>

	<div class="header-shop">
		<div>
			<img src="/style/assets/images/logoShop/LOGO CAMSPORT.png"
				alt="" style="width: 80px; border-radius: 50%;">
		</div>
		<div>
			<h1 style="font-size: 30px;">CAMSPORT</h1>
		</div>
	</div>
	<div style="display: flex; justify-content: flex-end; align-items: center; margin-top: -100px;">
    <span style="font-size: 40px; margin-right: 10px;">
        <i class="fa fa-registered" aria-hidden="true"></i>
    </span>
    <button style="width: 100px; height: 40px; ">
        <a href="<%=request.getContextPath()%>/Trangchu/Logout" style="text-decoration: none; color: inherit;">Đăng Xuất</a>
    </button>
</div>
	<div class="container py-5" style="max-width: 100%;">
		<header class="text-center text-white">
			<h1 class="display-4">Quản lý cửa hàng</h1>
		</header>
		
		<!-- Tab navigation -->
		<div class="row">
			<div class="col-12">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item">
						<a class="nav-link active" id="product-tab" data-toggle="tab" href="#product" role="tab" aria-controls="product" aria-selected="true">Sản phẩm</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="booking-tab" data-toggle="tab" href="#booking" role="tab" aria-controls="booking" aria-selected="false">Đặt sân</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="order-tab" data-toggle="tab" href="#order" role="tab" aria-controls="order" aria-selected="false">Đơn hàng</a>
					</li>
				</ul>
			</div>
		</div>
		
		<!-- Tab content -->
		<div class="tab-content" id="myTabContent">
		
			<!-- Product tab content -->
			<div class="tab-pane fade show active" id="product" role="tabpanel" aria-labelledby="product-tab">
				<div class="row py-5">
					<div class="col-lg-10 mx-auto">
						<div class="card rounded shadow border-0">
							<div></div>
							<div class="card-body p-5 bg-white rounded">
								<div class="table-responsive">
									<table id="example" style="width: 100%"
										class="table table-striped table-bordered">
										<thead>
											<tr>
												<th>ID</th>
												<th>Tên chủ đề</th>
												<th>Giá gốc</th>
												<th>Giá sale</th>
												<th>URL ảnh</th>
												<th>Ảnh</th>
												<th>Loai sản phẩm</th>
												<th>Chức năng</th>
											</tr>
										</thead>
										<tbody>
											<%
											Shop shop = (Shop) request.getSession().getAttribute("shop");
											ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("productList");
											ArrayList<Category> categoryList = (ArrayList<Category>) request.getAttribute("categoryList");
											if (productList != null)
												for (Product product : productList) {
											%>
											<tr>
												<td><%=product.getId()%></td>
												<td><%=product.getFewChar()%></td>
												<td><%=Product.formMoney(product.getOriginalPrice())%></td>
												<td><%=Product.formMoney(product.getSalePrice())%></td>
												<td style="max-width: 200px"><%=product.getUrl()%></td>
												<td><img src="<%=product.getUrl()%>"></td>
												<td id="<%=product.getCategoryID()%>"><%=CategoryBO.getCategory(product.getCategoryID())%></td>
												<td style="min-width: 80px">
													<button class="btn-update"
														style="background-color: #007bff; border-radius: 8%; color: antiquewhite;">
														<i class="fa fa-wrench" aria-hidden="true"></i>
													</button>
													<form id="DELETE_form" method="post"
														style="display: contents">
														<input type="text" name="type" style="display: none"
															value="DELETE"></input><input type="text" name="pID"
															style="display: none" value="<%=product.getId()%>"></input>
														<button
															style="background-color: #E34724; border-radius: 8%; color: antiquewhite;">
															<i class="fa fa-trash" aria-hidden="true"></i>
														</button>
													</form>
												</td>
											</tr>
											<%
											}
											%>
											<tr>
												<td></td>
												<td><input style="width: 240px" form="ADD_form"
													type="text" name="product" autocomplete="off" required /></td>
												<td><input style="width: 120px" form="ADD_form"
													type="text" name="priceO" autocomplete="off" required /></td>
												<td><input style="width: 120px" form="ADD_form"
													type="text" name="priceS" autocomplete="off" required /></td>
												<td><input style="max-width: 200px" form="ADD_form"
													type="text" name="url" autocomplete="off" /></td>
												<td></td>
												<td><select form="ADD_form" name="categoryID"
													placeholder="Pick a state..." style="width: 150px">
														<%
														for (Category category : categoryList) {
														%>
														<option value="<%=category.getCategoryID()%>"><%=category.getNameCategory()%></option>
														<%
														}
														%>
												</select></td>
												<td>
													<form id="ADD_form" method="post" style="display: contents">
														<input type="text" name="type" style="display: none"
															value="ADD"></input> <input type="text" name="shopID"
															style="display: none" value="<%=shop.getId()%>"></input>
														<button
															style="background-color: #17a2b8; border-radius: 8%; color: antiquewhite;">
															<i class="fa fa-plus" aria-hidden="true"></i>
														</button>
													</form>
												</td>
											</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- Booking tab content -->
			<div class="tab-pane fade" id="booking" role="tabpanel" aria-labelledby="booking-tab">
				<!-- Booking alerts -->
				<%
				Boolean cancelResult = (Boolean) session.getAttribute("cancelResult");
				if (cancelResult != null) {
					if (cancelResult) {
						session.removeAttribute("cancelResult");
				%>
				<div class="alert alert-success text-center" role="alert">
					Hủy đặt sân thành công!
				</div>
				<%
					} else {
						session.removeAttribute("cancelResult");
				%>
				<div class="alert alert-danger text-center" role="alert">
					Không thể hủy đặt sân!
				</div>
				<%
					}
				}
				
				Boolean confirmResult = (Boolean) session.getAttribute("confirmResult");
				if (confirmResult != null) {
					if (confirmResult) {
						session.removeAttribute("confirmResult");
				%>
				<div class="alert alert-success text-center" role="alert">
					Xác nhận đặt sân thành công!
				</div>
				<%
					} else {
						session.removeAttribute("confirmResult");
				%>
				<div class="alert alert-danger text-center" role="alert">
					Không thể xác nhận đặt sân!
				</div>
				<%
					}
				}
				%>
				
				<!-- Search Form for Bookings -->
				<div class="row justify-content-center mb-4">
					<div class="col-lg-8">
						<div class="card">
							<div class="card-body">
								<form method="get" action="<%=request.getContextPath()%>/Trangchu/OwnerShop">
									<div class="form-row d-flex justify-content-between">
										<div class="form-group col-md-3">
											<label for="courtName">Sân:</label>
											<select id="courtName" name="courtName" class="form-control">
												<option value="">Tất cả</option>
												<option value="Sân 1">Sân 1</option>
												<option value="Sân 2">Sân 2</option>
												<option value="Sân 3">Sân 3</option>
											</select>
										</div>
										<div class="form-group col-md-4">
											<label for="bookingDate">Ngày:</label>
											<input type="date" id="bookingDate" name="bookingDate" class="form-control">
										</div>
										<div class="form-group col-md-3">
											<label for="timeSlot">Giờ:</label>
											<select id="timeSlot" name="timeSlot" class="form-control">
												<option value="">Tất cả</option>
												<option value="08:00 - 10:00">08:00 - 10:00</option>
												<option value="10:00 - 12:00">10:00 - 12:00</option>
												<option value="14:00 - 16:00">14:00 - 16:00</option>
												<option value="16:00 - 18:00">16:00 - 18:00</option>
											</select>
										</div>
										<div class="form-group col-md-2 d-flex align-items-end">
											<button type="submit" class="btn btn-primary btn-block">Tìm kiếm</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				
				<!-- Booking Table -->
				<div class="row py-3">
					<div class="col-lg-10 mx-auto">
						<div class="card rounded shadow border-0">
							<div class="card-body p-5 bg-white rounded">
								<div class="table-responsive">
									<table id="bookingTable" style="width: 100%"
										class="table table-striped table-bordered">
										<thead>
											<tr>
												<th>ID</th>
												<th>Khách hàng</th>
												<th>SĐT</th>
												<th>Sân</th>
												<th>Ngày đặt</th>
												<th>Khung giờ</th>
												<th>Trạng thái</th>
											</tr>
										</thead>
										<tbody>
											<%
											List<Booking> bookingList = (List<Booking>) request.getAttribute("bookingList");
											if (bookingList != null && !bookingList.isEmpty()) {
												for (Booking booking : bookingList) {
											%>
											<tr>
												<td><%=booking.getId()%></td>
												<td><%=booking.getCustomerName()%></td>
												<td><%=booking.getPhone()%></td>
												<td><%=booking.getCourtName()%></td>
												<td><%=booking.getBookingDate()%></td>
												<td><%=booking.getTimeSlot()%></td>
												<td style="min-width: 80px">
													<form id="CANCEL_form_<%=booking.getId()%>" method="post"
														style="display: contents" action="<%=request.getContextPath()%>/Trangchu/OwnerShop">
														<input type="text" name="type" style="display: none"
															value="CANCEL"></input>
														<input type="text" name="bookingID" style="display: none"
															value="<%=booking.getId()%>"></input>
														<button
															style="background-color: #E34724; border-radius: 8%; color: antiquewhite;"
															onclick="return confirm('Bạn có chắc chắn muốn hủy đặt sân này không?')">
															<i class="fa fa-times" aria-hidden="true"></i>
														</button>
													</form>
												</td>
											</tr>
											<%
												}
											} else {
											%>
											<tr>
												<td colspan="8">Không có lịch sử đặt sân</td>
											</tr>
											<%
											}
											%>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- Order tab content -->
			<div class="tab-pane fade" id="order" role="tabpanel" aria-labelledby="order-tab">
				<div class="row py-3">
					<div class="col-lg-10 mx-auto">
						<div class="card rounded shadow border-0">
							<div class="card-header">
								<h5>Danh sách đơn hàng</h5>
							</div>
							<div class="card-body p-5 bg-white rounded">
								<div class="table-responsive">
									<table id="orderTable" class="table table-striped table-bordered" style="width:100%">
										<thead>
											<tr>
												<th scope="col">ID</th>
												<th scope="col">Khách hàng</th>
												<th scope="col">Địa chỉ</th>
												<th scope="col">SĐT</th>
												<th scope="col">Tổng tiền</th>
												<th scope="col">Trạng thái</th>
												<th scope="col">Ngày đặt</th>
												<th scope="col">Thao tác</th>
											</tr>
										</thead>
										<tbody>
											<% 
											ArrayList<Order> orderList = (ArrayList<Order>) request.getAttribute("orderList");
											if(orderList != null && !orderList.isEmpty()) {
												for(Order order : orderList) {
											%>
											<tr>
												<td><%= order.getOrderID() %></td>
												<td><%= order.getFullName() %></td>
												<td><%= order.getAddress() %></td>
												<td><%= order.getPhoneNumber() %></td>
												<td><%= order.getTotalAmount() %> VND</td>
												<td><%= order.getStatus() %></td>
												<td><%= order.getOrderDate() %></td>
												<td>
													<div class="d-flex flex-column">
														<% if(!order.getStatus().equals("completed")) { %>
														<form method="post">
															<input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
															<input type="hidden" name="type" value="COMPLETE_ORDER">
															<button type="submit" class="btn btn-success">Hoàn thành đơn</button>
														</form>
														<% } else { %>
															<button class="btn btn-success" disabled>Đã hoàn thành</button>
														<% } %>
														<!-- Added data-toggle and data-target attributes as backup method -->
														<button type="button" class="btn btn-info mt-2 view-order-details" 
															data-order-id="<%= order.getOrderID() %>"
															data-toggle="modal" 
															data-target="#orderDetailsModal">Xem chi tiết</button>
													</div>
												</td>
											</tr>
											<% 
												}
											} else { %>
											<tr>
												<td colspan="8">Không có đơn hàng</td>
											</tr>
											<% } %>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Order Details Modal -->
	<div class="modal fade" id="orderDetailsModal" tabindex="-1" role="dialog" aria-labelledby="orderDetailsModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="orderDetailsModalLabel">Chi tiết đơn hàng #<span id="modalOrderId"></span></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row mb-3">
						<div class="col-md-6">
							<p><strong>Khách hàng:</strong> <span id="modalCustomerName"></span></p>
							<p><strong>Địa chỉ:</strong> <span id="modalAddress"></span></p>
						</div>
						<div class="col-md-6">
							<p><strong>SĐT:</strong> <span id="modalPhone"></span></p>
							<p><strong>Ngày đặt:</strong> <span id="modalOrderDate"></span></p>
						</div>
					</div>
					<h6>Danh sách sản phẩm</h6>
					<div class="table-responsive">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>Sản phẩm</th>
									<th>Đơn giá</th>
									<th>Số lượng</th>
									<th>Thành tiền</th>
								</tr>
							</thead>
							<tbody id="orderDetailsTableBody">
								<!-- Order details will be inserted here -->
							</tbody>
							<tfoot>
								<tr>
									<td colspan="3" class="text-right"><strong>Tổng tiền:</strong></td>
									<td id="modalTotalAmount"></td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
				</div>
			</div>
		</div>
	</div>
	
	<section id="contact" class="close" style="z-index: 9;">
		<div class="contact-box">
			<div class="contact-links">
				<img id="update-img"
					src="https://cf.shopee.vn/file/575e04c0e1d08b5f1b9f624a8d6b1419"
					alt="">
			</div>
			<div class="contact-form-wrapper">
				<label class="btn-close"
					style="position: absolute; right: 10px; top: 6px; padding: 10px; font-size: 20px; cursor: pointer;"><i
					class="fa fa-times" aria-hidden="true"></i></label>
				<form method="post">
					<input type="text" name="type" style="display: none" value="PUT"></input>
					<input id="update-id" type="text" name="id" style="display: none"></input>
					<input type="text" name="shopID" style="display: none"
						value="<%=shop.getId()%>"></input>
					<div class="form-item">
						<label>Name Product</label> <input id="update-product" type="text"
							name="product">
					</div>
					<div class="form-item">
						<label>Price Origin</label> <input id="update-priceO" type="text"
							name="priceO">
					</div>
					<div class="form-item">
						<label>Price Sale</label> <input id="update-priceS" type="text"
							name="priceS">
					</div>
					<div class="form-item">
						<label>URL image</label> <input id="update-url" type="text"
							name="url">
					</div>
					<input id="update-category" type="text" name="category0-ID"
						style="display: none">
					<div class="form-item">
						<label>Category</label> <select id="select-state"
							name="categoryID" placeholder="Pick a state...">
							<%
							for (Category category : categoryList) {
							%>
							<option value="<%=category.getCategoryID()%>"><%=category.getNameCategory()%></option>
							<%
							}
							%>
						</select>
					</div>
					<button class="submit-btn">Update</button>
				</form>
			</div>
		</div>
	</section>
	<script>
		$(function() {
			// Update product functionality
			$('#example .btn-update').click(
					function(e) {
						e.preventDefault();
						$('#update-id').val(
								$(this).closest('tr').find('td:nth-child(1)')
										.text());
						$('#update-img').attr(
								"src",
								$(this).closest('tr').find('td:nth-child(5)')
										.text());
						$('#update-product').val(
								$(this).closest('tr').find('td:nth-child(2)')
										.text());
						$('#update-priceO').val(
								$(this).closest('tr').find('td:nth-child(3)')
										.text());
						$('#update-priceS').val(
								$(this).closest('tr').find('td:nth-child(4)')
										.text());
						$('#update-url').val(
								$(this).closest('tr').find('td:nth-child(5)')
										.text());
						console.log($(this).closest('tr').find(
								'td:nth-child(7)').attr('id'));
						$('#update-category').val(
								$(this).closest('tr').find('td:nth-child(7)')
										.attr('id'));
						//$('#select-state').val($(this).closest('tr').find('td:nth-child(7)').text());
						$('#contact').removeClass('close');
						//$('.contact-form-wrapper').
					});
					
			// Close modal
			$('.btn-close').click(function(e) {
				$('#contact').addClass('close');
			});
			
			// View order details - Updated click handler
			$(document).on('click', '.view-order-details', function(e) {
				// Prevent default action but keep the Bootstrap modal trigger
				// e.preventDefault();
				
				var orderId = $(this).data('order-id');
				console.log("Order ID clicked: " + orderId);
				
				// Fetch order details via AJAX
				$.ajax({
					url: '<%=request.getContextPath()%>/Trangchu/GetOrderDetails',
					type: 'GET',
					data: { orderId: orderId },
					dataType: 'json',
					success: function(response) {
						console.log("Success response:", response);
						// Populate the modal with order details
						$('#modalOrderId').text(orderId);
						$('#modalCustomerName').text(response.order.fullName);
						$('#modalAddress').text(response.order.address);
						$('#modalPhone').text(response.order.phoneNumber);
						$('#modalOrderDate').text(response.order.orderDate);
						$('#modalTotalAmount').text(response.order.totalAmount + ' VND');
						
						// Clear and populate the order details table
						var tableBody = $('#orderDetailsTableBody');
						tableBody.empty();
						
						$.each(response.orderDetails, function(i, item) {
							var row = '<tr>' +
								'<td>' + item.productName + '</td>' +
								'<td>' + item.price + ' VND</td>' +
								'<td>' + item.quantity + '</td>' +
								'<td>' + (item.price * item.quantity) + ' VND</td>' +
								'</tr>';
							tableBody.append(row);
						});
					},
					error: function(xhr, status, error) {
						console.error("Error response:", error);
						console.error("Status:", status);
						console.error("Response:", xhr.responseText);
						alert('Có lỗi khi tải chi tiết đơn hàng. Vui lòng thử lại sau.');
					}
				});
			});
			
			// Initialize DataTables
			$(document).ready(function() {
				$('#example').DataTable();
				$('#bookingTable').DataTable();
				$('#orderTable').DataTable();
				
				// Set active tab based on URL parameter if present
				var urlParams = new URLSearchParams(window.location.search);
				var activeTab = urlParams.get('tab');
				if (activeTab) {
					$('#myTab a[href="#' + activeTab + '"]').tab('show');
				}
			});
		});
	</script>

</body>
</html>