<%@page import="model.entities.Shop"%>
<%@page import="model.entities.Client"%>
<%@page import="model.entities.Payment"%>
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
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
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
<style>
body {
	min-height: 100vh;
	background-color: #FFE53B;
	background-image: linear-gradient(147deg, #FFE53B 0%, #FF2525 100%);
}

@media ( min-width : 1200px) .container {
	max-width
	:
	 
	100
	%;
	

}
</style>
</head>
<body>
	<div>
		<span style="font-size: 40px"><i class="fa fa-registered"
			aria-hidden="true"></i></span>
		<button style="width: 100px; height: 40px">
			<a href="<%=request.getContextPath()%>/Trangchu/SignUpIn">Đăng
				Xuất</a>
		</button>
	</div>


	<div class="container py-5" style="max-width: 100%;">
		<header class="text-center text-white">
			<h1 class="display-4">Payment Table</h1>
		</header>
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
										<th>Tên tài khoản</th>
										<th>Tên chủ thẻ</th>
										<th style="max-width: 60px">Check</th>
										<th>Số tiền nạp</th>
										<th style="max-width: 120px">Chức năng</th>
									</tr>
								</thead>
								<tbody>
									<%
									ArrayList<Payment> paymentList =(ArrayList<Payment>) request.getAttribute("paymentList");

									if (paymentList != null)
										for (Payment pay : paymentList) {
									%>
									<tr>
										<td><%=pay.getPaymentID()%></td>
										<td><%=pay.getNameAccount()%></td>
										<td><%=pay.getCardholderName()%></td>
										<td><div
												style="border-radius: 50%;width: 20px; height: 20px; background-color: <%=pay.getStatus() == 0 ? "#C3C9C4" : pay.getStatus() == 1 ? "#78DE87" : "#E34724"%>"></div></td>
										<td><%=pay.getMoney()%></td>
										<td style="min-width: 80px">
											<form method="post" style="display: contents;">
												<input type="text" name="table" style="display: none;"
													value="payment"></input> <input type="text" name="status"
													style="display: none;" value="1"></input> <input
													type="text" name="paymentID" style="display: none;"
													value="<%=pay.getPaymentID()%>"></input>
												<button
													style="background-color: #78DE87; border-radius: 8%; color: antiquewhite;">
													<i class="fa fa-check-circle" aria-hidden="true"></i>
												</button>
											</form>
											<form method="post" style="display: contents">
												<input type="text" name="table" style="display: none"
													value="payment"></input> <input type="text" name="status"
													style="display: none;" value="2"></input> <input
													type="text" name="paymentID" style="display: none;"
													value="<%=pay.getPaymentID()%>"></input>
												<button
													style="background-color: #E34724; border-radius: 8%; color: antiquewhite;">
													<i class="fa fa-times-circle" aria-hidden="true"></i>
												</button>
											</form>
											<form method="post" style="display: contents">
												<input type="text" name="table" style="display: none"
													value="payment"></input> <input type="text" name="status"
													style="display: none;" value="3"></input> <input
													type="text" name="paymentID" style="display: none;"
													value="<%=pay.getPaymentID()%>"></input>
												<button
													style="background-color: #007bff; border-radius: 8%; color: antiquewhite;">
													<i class="fa fa-trash" aria-hidden="true"></i>
												</button>
											</form>
										</td>
									</tr>
									<%
									}
									%>
								
							</table>
						</div>
					</div>
					<form method="post"
						style="width: 100px; height: 40px; margin: auto; margin-bottom: 20px;">
						<input type="text" name="table" style="display: none"
							value="submit"></input>
						<button
							style="background-color: #007bff; color: antiquewhite; width: 100%; height: 100%;">SUBMIT</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
		$(function() {
			$(document).ready(function() {
				$('#example').DataTable();
			});
		});
	</script>

</body>
</html>