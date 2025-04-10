<%@page import="model.BOs.CategoryBO"%>
<%@page import="model.entities.Category"%>
<%@page import="model.entities.Shop"%>
<%@page import="model.entities.Product"%>
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

@media ( min-width : 1200px) .container {
	max-width
	:
	 
	100
	%;
	

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
			<img src="/WebShop/style/assets/images/logoShop/LOGO CAMSPORT.png"
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
        <a href="<%=request.getContextPath()%>/Trangchu/SignUpIn" style="text-decoration: none; color: inherit;">Đăng Xuất</a>
    </button>
</div>
	<div class="container py-5" style="max-width: 100%;">
		<header class="text-center text-white">
			<h1 class="display-4">QUản lý sản phẩm</h1>
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
												<option value=""></option>
												<option value=""></option>
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
			$('.btn-close').click(function(e) {
				$('#contact').addClass('close');
			})
			$(document).ready(function() {
				$('#example').DataTable();
				// $('#example2').DataTable();
			});
		});
	</script>

</body>
</html>