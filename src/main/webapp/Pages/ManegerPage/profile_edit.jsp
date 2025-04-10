<%@page import="model.entities.Product"%>
<%@page import="model.entities.Client"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile Setting</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<style type="text/css">
body {
	background: rgb(255, 127, 80)
}

.form-control:focus {
	box-shadow: none;
	border-color: #BA68C8
}

.profile-button {
	background: rgb(255, 127, 80);
	box-shadow: none;
	border: none
}

.profile-button:hover {
	background: #ee4d2d
}

.profile-button:focus {
	background: #ee4d2d;
	box-shadow: none
}

.profile-button:active {
	background: #ee4d2d;
	box-shadow: none
}

.back:hover {
	color: #ee4d2d;
	cursor: pointer
}

.labels {
	font-size: 11px
}

.add-experience:hover {
	background: #BA68C8;
	color: #fff;
	cursor: pointer;
	border: solid 1px #BA68C8
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
	<form class="container rounded bg-white mt-5 mb-5" method="post">
		<div class="row">
			<div class="col-md-3 border-right">
				<div
					class="d-flex flex-column align-items-center text-center p-3 py-5">
					<img class="rounded-circle mt-5" width="150px"
						src="<%=client.getImage()%>"><span class="font-weight-bold">Avatar</span><span>
					</span>
				</div>
			</div>
			<div class="col-md-9 border-right">
				<div class="d-flex justify-content-between align-items-center my-3">
					<h4 class="text-right">Avatar</h4>
				</div>
				<div class="row mt-3">

					<div class="col-md-12">
						<label class="labels">Link Image</label><input type="text"
							class="form-control" placeholder="enter link image" name="image"
							value="<%=client.getImage()%>">

					</div>
				</div>
			</div>
			<div class="col-md-12 border-right">
				<div class="p-3 py-5">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h4 class="text-right">Profile Settings</h4>
					</div>
					<input style="display: none" name="clientID"
						value="<%=client.getId()%>"> <input style="display: none"
						name="money" value="<%=client.getMoney()%>">
					<div class="row mt-2">
						<div class="col-md-12">
							<label class="labels">Username</label><input type="text"
								class="form-control" placeholder="enter username" name="user"
								value="<%=client.getUser()%>">
						</div>
						<div class="col-md-12">
							<label class="labels">Password</label><input type="password"
								class="form-control" placeholder="enter password" name="pass"
								value="<%=client.getPassword()%>">
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-md-12">
							<label class="labels">Fullname</label><input type="text"
								name="fullname" class="form-control"
								placeholder="enter phone number"
								value="<%=client.getFullName()%>">
						</div>
						<div class="col-md-12">
							<label class="labels">Mobile Number</label><input type="text"
								name="phone" class="form-control"
								placeholder="enter phone number" value="<%=client.getPhone()%>">
						</div>
						<div class="col-md-12">
							<label class="labels">Address</label><input type="text"
								name="address" class="form-control"
								placeholder="enter address line 1"
								value="<%=client.getAddress()%>">
						</div>

						<div class="col-md-12">
							<label class="labels">Birthday</label><input type="date"
								class="form-control" placeholder="enter birthday"
								name="birthday" value="<%=client.getBirthday()%>">
						</div>
					</div>

					<div class="mt-5 text-center">
						<button class="btn btn-primary profile-button" type="button">Save
							Profile</button>

						<a class="btn btn-secondary " href="<%=request.getContextPath()%>/Trangchu/Account">Back</a>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>