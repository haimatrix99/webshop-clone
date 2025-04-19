<%@page import="model.BOs.ProductBO"%>
<%@page import="model.BOs.OwnerShopBO"%>
<%@page import="model.entities.Shop"%>
<%@page import="model.entities.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.entities.Cart"%>
<%@page import="model.entities.Client"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/style/assets/images/logoShop/LOGO CAMSPORT.png" type="image/png">
<title>Giỏ Hàng</title>
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800"
	rel="stylesheet">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<style type="text/css">
.container {
	max-width: 980px !important;
	overflow: unset !important;
}

.content:not(:last-child) {
	margin-bottom: 0 !important;
}

.content h2:not(:first-child) {
	margin-top: 0 !important;
}
</style>
</head>
<body>

	<%@ include file="/Pages/MasterPage/Header.jsp"%>
	<link href="<%=request.getContextPath()%>/style/assets/css/notify.css"
		rel="stylesheet" />
	<link
		href="<%=request.getContextPath()%>/style/assets/css/stylePageCart.css"
		rel="stylesheet" />

	<header id="site-header">
		<div class="container">
			<h1>Shopping cart</h1>
		</div>
	</header>

	<div class="container">
		<section id="cart">
			<%
			// Get session cart for non-logged in users
			List<Cart> displayCartList = null;
			
			if (client != null) {
				// Use itemsCartList from Header.jsp for logged in users
				displayCartList = itemsCartList;
			} else {
				// Use session cart for non-logged in users
				displayCartList = (List<Cart>) session.getAttribute("sessionCart");
			}
			
			long subtotal = 0;
			if (displayCartList != null && !displayCartList.isEmpty()) {
				for (Cart cart : displayCartList) {
					Product product = ProductBO.getProductByID(cart.getProductID());
					Shop shop = OwnerShopBO.getShopByID(product.getShopID());
					subtotal += cart.getQuantity() * (Long.parseLong(product.getSalePrice()));
			%>
			<article class="product">
				<header>
					<a
						href="GioHang?<%="cartID=" + cart.getCartID() + "&actionCart=remove"%>"
						class="remove"> <img src="<%=product.getUrl()%>" alt="">

						<h3>Remove product</h3>
					</a>
				</header>

				<div class="content">

					<h1><%=shop.getNameShop()%></h1>
					<%=product.getProduct()%>
				</div>

				<footer class="content">
					<a
						href="GioHang?<%="cartID=" + cart.getCartID() + "&actionCart=minus&quantity=" + cart.getQuantity()%>"><span
						class="qt-minus">-</span></a> <span class="qt"><%=cart.getQuantity()%></span>
					<a
						href="GioHang?<%="cartID=" + cart.getCartID() + "&actionCart=plus&quantity=" + cart.getQuantity()%>"><span
						class="qt-plus">+</span></a>

					<h2 class="full-price">
						<%=Product.formMoney(Long.toString(cart.getQuantity() * (Long.parseLong(product.getSalePrice()))))%>đ
					</h2>

					<h2 class="price">
						<%=Product.formMoney(product.getSalePrice())%>đ
					</h2>
				</footer>
			</article>
			<footer id="site-footer">
				<div class="container clearfix">
					<div class="left">
						<h3 class="subtotal">
							<b>Subtotal:</b> <span><%=Product.formMoney(Long.toString(subtotal))%></span>
							VNĐ
						</h3>
						<h3 class="tax">
							<b>Taxes (2%):</b> <span> <%
 long tax = Math.round((subtotal * 0.02));
 out.print(Product.formMoney(Long.toString(tax)));
 %></span> VNĐ
						</h3>
						<h3 class="shipping">
							<b>Shipping:</b> <span>20.000</span> VNĐ
						</h3>
					</div>

					<div class="right" style="margin-right: 40px;">
						<h1 class="total">
							<b style="color: red;">Total: <span><%=subtotal != 0 ? Product.formMoney(Long.toString(tax + subtotal + 20000)) : 0%></span>
								VNĐ
							</b>
						</h1>
						<!-- Thêm nút thanh toán bằng thẻ và tiền mặt -->
						<div style="display: flex; gap: 10px; margin-bottom: 10px;">
							<button class="btn btn-primary"
								style="width: 45%; background-color: orange; border: none; padding: 8px; font-size: 14px;">
								<img
									src="https://png.pngtree.com/element_our/20200702/ourmid/pngtree-bank-card-icon-image_2292633.jpg"
									alt="Thẻ"
									style="width: 15px; margin-right: 5px; vertical-align: middle;">
								Thanh toán bằng thẻ
							</button>
							<button class="btn btn-secondary"
								style="width: 45%; background-color: orange; border: none; padding: 8px; font-size: 14px;">
								<img
									src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0d-k3OPUfL4hwijBNNzy9kcUwNMCw0cwugQ&s"
									alt="Tiền mặt"
									style="width: 15px; margin-right: 5px; vertical-align: middle;">
								Thanh toán bằng tiền mặt
							</button>
						</div>
						<%
						if (subtotal != 0) {
							if (client != null) {
								// For logged-in users, check their money balance
								if (subtotal + tax + 20000 <= Long.parseLong(client.getMoney()))
									out.print("<button class=\"btn btn-success\" style=\"width: 100%\">Checkout</button>");
								else
									out.print("<button class=\"btn btn-error\" style=\"width: 100%\">Checkout</button>");
							} else {
								// For non-logged users, offer sign-in or continue as guest
								out.print("<button class=\"btn btn-success\" style=\"width: 100%\">Checkout</button>");
								out.print("<div style=\"margin-top: 10px; text-align: center;\">");
								out.print("<a href=\"" + request.getContextPath() + "/Trangchu/SignUpIn\" style=\"color: #ee4d2d; margin-right: 10px;\">Sign in</a>");
								out.print("<span>or</span>");
								out.print("<a href=\"#\" style=\"color: #ee4d2d; margin-left: 10px;\">Continue as guest</a>");
								out.print("</div>");
							}
						} else
							out.print("<button class=\"btn\" style=\"width: 100%\">Checkout</button>");
						%>
					</div>
				</div>
			</footer>
			<div id="notify" class="close">
				<div id="success-box" class="close">
					<span></span>
					<div class="dot"></div>
					<div class="dot two"></div>
					<div class="face">
						<div class="eye"></div>
						<div class="eye right"></div>
						<div class="mouth happy"></div>
					</div>
					<div class="shadow scale"></div>
					<div class="message">
						<h1 class="alert">Success!</h1>
						<p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!</p>
					</div>
					<form method="post">
						<input name="totalMoney" style="display: none"
							value="<%=subtotal + tax + 20000%>">
						<button class="button-box">
							<h1 class="green">Xác Nhận</h1>
						</button>
					</form>
				</div>
				<div id="error-box" class="close">
					<div class="dot"></div>
					<div class="dot two"></div>
					<div class="face2">
						<div class="eye"></div>
						<div class="eye right"></div>
						<div class="mouth sad"></div>
					</div>
					<div class="shadow move"></div>
					<div class="message">
						<h1 class="alert">Not Enough Money!</h1>
						<p>Vui lòng nạp thêm tiền!
					</div>
					<button class="button-box">
						<a href="Payment"><h1 class="red"
								style="background-color: #FFFF">Nạp Tiền</h1></a>
					</button>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<footer id="site-footer">
				<div class="container clearfix">
					<div class="left">
						<h3 class="subtotal">
							<b>Subtotal:</b> <span><%=Product.formMoney(Long.toString(subtotal))%></span>
							VNĐ
						</h3>
					</div>
				</div>
			</footer>
			<%
			}
			%>

		</section>

	</div>

	<script type="text/javascript">
	let btn_error = document.querySelector('.btn-error');
	let btn_success = document.querySelector('.btn-success');
	
	if(btn_error) {
		document.querySelector('.btn-error').addEventListener('click', () => { 
			document.getElementById('notify').classList.remove('close');
			document.getElementById('error-box').classList.remove('close');
		});
	}
	
	if(btn_success) {
		document.querySelector('.btn-success').addEventListener('click', () => {
			document.getElementById('notify').classList.remove('close');
			document.getElementById('success-box').classList.remove('close');
		});
	}
	
	const buttons = document.querySelectorAll('.btn-primary, .btn-secondary');
	
	buttons.forEach(button => {
		button.addEventListener('click', () => {
			// Đặt lại màu cho tất cả các nút
			buttons.forEach(btn => btn.style.backgroundColor = 'orange');
			// Thay đổi màu cho nút được nhấn
			button.style.backgroundColor = 'blue';
		});
	});
	</script>
</body>
</html>