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
			<%
				}
			%>
			
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
						
						<!-- Checkout Form -->
						<% if (subtotal > 0) { %>
						<div class="checkout-form" style="margin-bottom: 15px; background-color: #f8f8f8; padding: 15px; border-radius: 5px;">
							<h3 style="margin-top: 0; margin-bottom: 10px; color: #333;">Thông tin giao hàng</h3>
							<form method="post" id="checkoutForm">
								<div style="margin-bottom: 10px;">
									<input type="text" name="fullName" placeholder="Họ tên" required 
										   style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box;">
								</div>
								<div style="margin-bottom: 10px;">
									<input type="text" name="address" placeholder="Địa chỉ" required 
										   style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box;">
								</div>
								<div style="margin-bottom: 10px;">
									<input type="tel" name="phoneNumber" placeholder="Số điện thoại" required 
										   style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box;">
								</div>
								<input type="hidden" name="totalMoney" value="<%=subtotal + tax + 20000%>">
								
								<!-- Hidden inputs for cart items -->
								<%
								for (int i = 0; i < displayCartList.size(); i++) {
									Cart cartItem = displayCartList.get(i);
									Product cartProduct = ProductBO.getProductByID(cartItem.getProductID());
									long itemPrice = Long.parseLong(cartProduct.getSalePrice());
								%>
									<input type="hidden" name="productID_<%=i%>" value="<%=cartItem.getProductID()%>">
									<input type="hidden" name="quantity_<%=i%>" value="<%=cartItem.getQuantity()%>">
									<input type="hidden" name="price_<%=i%>" value="<%=itemPrice%>">
								<%
								}
								%>
								<input type="hidden" name="itemCount" value="<%=displayCartList.size()%>">
								<input type="hidden" name="createOrder" value="true">
							</form>
						</div>
						<% } %>
						
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
					<div class="message">
						<p>Cảm ơn bạn đã đặt hàng! Chúng tôi sẽ liên hệ sớm để xác nhận.</p>
					</div>
					<button type="button" id="close-success-box" style="position: absolute; top: 10px; right: 10px; background: none; border: none; font-size: 20px; cursor: pointer;">✕</button>
					<button type="button" id="confirm-order" class="button-box">
						<h1 class="green">Xác Nhận</h1>
					</button>
				</div>	
			</div>
			<%
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
		document.querySelector('.btn-success').addEventListener('click', function(e) {
			// Prevent the default form submission
			e.preventDefault();
			
			// Validate form if form exists
			const checkoutForm = document.getElementById('checkoutForm');
			if (checkoutForm) {
				const fullName = checkoutForm.elements['fullName'].value;
				const address = checkoutForm.elements['address'].value;
				const phoneNumber = checkoutForm.elements['phoneNumber'].value;
				
				// If form is valid, show success message and submit the form
				if (fullName && address && phoneNumber) {
					document.getElementById('notify').classList.remove('close');
					document.getElementById('success-box').classList.remove('close');
				} else {
					alert('Vui lòng điền đầy đủ thông tin giao hàng');
				}
			} else {
				// If no form (old behavior), just show notification
				document.getElementById('notify').classList.remove('close');
				document.getElementById('success-box').classList.remove('close');
			}
		});
		
		// Add event listener for close button
		document.getElementById('close-success-box').addEventListener('click', function() {
			document.getElementById('notify').classList.add('close');
			document.getElementById('success-box').classList.add('close');
		});
		
		// Add event listener for confirm button
		document.getElementById('confirm-order').addEventListener('click', function() {
			const checkoutForm = document.getElementById('checkoutForm');
			if (checkoutForm) {
				checkoutForm.submit();
			}
			document.getElementById('notify').classList.add('close');
			document.getElementById('success-box').classList.add('close');
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