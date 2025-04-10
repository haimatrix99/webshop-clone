<%@page import="model.entities.Product"%>
<%@page import="model.entities.Client"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<style type="text/css">
body {
	margin-top: 20px;
	color: #1a202c;
	text-align: left;
	background-color: #e2e8f0;
}

.main-body {
	padding: 15px;
}

.card {
	box-shadow: 0 1px 3px 0 rgba(0, 0, 0, .1), 0 1px 2px 0
		rgba(0, 0, 0, .06);
}

.card {
	position: relative;
	display: flex;
	flex-direction: column;
	min-width: 0;
	word-wrap: break-word;
	background-color: #fff;
	background-clip: border-box;
	border: 0 solid rgba(0, 0, 0, .125);
	border-radius: .25rem;
}

.card-body {
	flex: 1 1 auto;
	min-height: 1px;
	padding: 1rem;
}

.gutters-sm {
	margin-right: -8px;
	margin-left: -8px;
}

.gutters-sm>.col, .gutters-sm>[class*=col-] {
	padding-right: 8px;
	padding-left: 8px;
}

.mb-3, .my-3 {
	margin-bottom: 1rem !important;
}

.bg-gray-300 {
	background-color: #e2e8f0;
}

.h-100 {
	height: 100% !important;
}

.shadow-none {
	box-shadow: none !important;
}
</style>
</head>
<body>
	<%
	HttpSession ses = request.getSession();
	String accesser = (String) ses.getAttribute("accesser");
	Client client = null;
	if (accesser != null && accesser.equals("user")) {
		client = (Client) ses.getAttribute("user");
	}
	%>
	<div class="container">
		<div class="main-body">

			<div class="row gutters-sm">
				<div class="col-md-4 mb-3">
					<div class="card">
						<div class="card-body">
							<div class="d-flex flex-column align-items-center text-center">
								<img src="<%=client.getImage() %>"
									alt="avatar" class="rounded-circle" width="150">
								<div class="mt-3">
									<h4><%=client.getFullName() %></h4>
									<p class="text-muted font-size-sm">Số dư <%=Product.formMoney(client.getMoney()) %> VNĐ</p>
									<a class="btn btn-primary" href="<%=request.getContextPath() %>/Trangchu">Home</a>
									<a class="btn btn-outline-primary" href="<%=request.getContextPath() %>/Trangchu/SignUpIn">Logout</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-8">
					<div class="card mb-3">
						<div class="card-body">
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Địa chỉ</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=client.getAddress() %></div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Tên đăng nhập</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=client.getUser() %></div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Số điện thoại</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=client.getPhone() %></div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">Ngày sinh</h6>
								</div>
								<div class="col-sm-9 text-secondary"><%=client.getBirthday() %></div>
							</div>
							<hr>

							<div class="row">
								<div class="col-sm-12">
									<a class="btn btn-info " target="__blank"
										href="<%= request.getContextPath()+"/Trangchu/Account?setting"%>">Edit</a>
								</div>
							</div>
						</div>
					</div>


				</div>
			</div>

		</div>
	</div>
</body>
</html>