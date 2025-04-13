<%@page import="model.BOs.ClientBO"%>
<%@page import="model.BOs.CategoryBO"%>
<%@page import="model.BOs.CartBO"%>
<%@page import="model.entities.Category"%>
<%@page import="model.entities.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.entities.Product"%>
<%@page import="model.entities.Client"%>
<%@page import="common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/style/assets/css/bullma_css.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.logo {
	width: 100px;
	display: block;
	margin: 0 auto;
}

.navbar {
	font-size: large;
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 999;
	padding: 0;
	background-color: #ee4d2d;
}

.account:hover .nav-account {
	display: block;
}

.nav-account {
	display: none;
}

.navbar-brand {
	padding: 0;
}

a {
	text-decoration: none !important;
}

.navbar-item.is-mega {
	position: static;
}

.navbar-item.is-mega .is-mega-menu-title {
	margin-bottom: 0;
	padding: 0.375rem 1rem;
}

/* Three-column layout */
.navbar-container {
	display: flex;
	width: 100%;
	align-items: center;
}

.navbar-start {
	flex: 1;
	display: flex;
	justify-content: flex-start;
	align-items: center;
}

.navbar-center {
	flex: 2;
	display: flex;
	justify-content: center;
	align-items: center;
}

.navbar-end {
	flex: 1;
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

/* Cart icon styling */
.cart-icon-container {
	position: relative;
}

.cart-count {
	height: 18px;
	width: 18px;
	background-color: darkorange;
	border-radius: 50%;
	position: absolute;
	top: -8px;
	right: -8px;
	font-size: small;
	text-align: center;
	color: white;
}

.close {
	display: none;
}

/* Search Navbar Styles */
.search-navbar {
	position: fixed;
	top: -70px;
	left: 0;
	width: 100%;
	background-color: #ee4d2d;
	padding: 15px 20px;
	display: flex;
	align-items: center;
	z-index: 1000;
	transition: transform 0.3s ease-in-out;
	box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.search-navbar.active {
	transform: translateY(70px);
}

.search-navbar-start {
	flex: 1;
	display: flex;
	justify-content: flex-start;
	align-items: center;
}

.search-navbar-center {
	flex: 2;
	display: flex;
	justify-content: center;
	align-items: center;
}

.search-navbar-end {
	flex: 1;
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 20px;
}

.search-form {
	width: 100%;
	max-width: 600px;
	display: flex;
	position: relative;
}

.search-input {
	width: 100%;
	padding: 10px 15px;
	border: none;
	border-radius: 4px;
	font-size: 16px;
}

.search-button {
	position: absolute;
	right: 5px;
	top: 50%;
	transform: translateY(-50%);
	background: none;
	border: none;
	color: #ee4d2d;
	cursor: pointer;
	font-size: 20px;
}

.search-close {
	background: none;
	border: none;
	color: white;
	font-size: 20px;
	cursor: pointer;
	margin-left: 15px;
}

/* Responsive adjustments */
@media screen and (max-width: 1023px) {
	.navbar-container {
		flex-direction: column;
	}
	
	.navbar-start, .navbar-center, .navbar-end {
		width: 100%;
		justify-content: center;
		padding: 10px 0;
	}
}
</style>

<%
HttpSession ses = request.getSession();
String accesser = (String) ses.getAttribute("accesser");
Client client = null;
ArrayList<Cart> itemsCartList = new ArrayList<Cart>();
ArrayList<Category> categoryList = new ArrayList<Category>();
categoryList = CategoryBO.getCategorysInData();
if (accesser != null && accesser.equals("user")) {
	client = (Client) ses.getAttribute("user");
	client = client != null ? ClientBO.getClientById(client.getId()) : null;
	itemsCartList = client != null ? (ArrayList<Cart>) CartBO.getItemsCartByClient(client.getId()) : null;
	ses.setAttribute("itemsCartList", itemsCartList);
}
%>

<nav class="navbar">
	<div class="navbar-container">
		<!-- Left Column - Logo and Home -->
		<div class="navbar-start">
			<a href="#" class="logo" title="Tuulkit">
				<img src="/style/assets/images/logoShop/LOGO CAMSPORT.png" alt="Logo">
			</a>
		</div>
		
		<!-- Middle Column - Products & Support -->
		<div class="navbar-center">
			<!-- Products Dropdown -->
			<a class="navbar-item" href="<%=request.getContextPath()%>/Trangchu" style="color: #FFFF; font-size: 18px">
				Trang chủ
			</a>
			<div class="navbar-item has-dropdown is-hoverable is-mega">
				<a class="navbar-link" style="color: #FFFF;" href="<%=request.getContextPath()%>/Trangchu/ProductMenu">
					Sản Phẩm
				</a>
				<div id="blogDropdown" class="navbar-dropdown" data-style="width: 18rem;">
					<div class="container is-fluid">
						<div class="columns">
							<div class="column">
								<%
								int count = 0;
								for (Category category : categoryList) {
									count++;
								%>
								<a class="navbar-item" href="<%=request.getContextPath()%>/Trangchu/ProductMenu?categoryID=<%=category.getCategoryID()%>">
									<div class="navbar-content">
										<p><%=category.getNameCategory()%></p>
									</div>
								</a>
								<%
								if (count == 4) {
									out.print("</div>\n<div class=\"column\">");
									count = 0;
								}
								}
								%>
							</div>
						</div>
					</div>
					<hr class="navbar-divider">
					<div class="navbar-item">
						<div class="navbar-content">
							<div class="level is-mobile">
								<div class="level-left">
									<div class="level-item">
										<strong>Stay up to date!</strong>
									</div>
								</div>
								<div class="level-right">
									<div class="level-item">
										<a class="button bd-is-rss is-small" href="#">
											<span class="icon is-small">
												<i class="fa fa-rss"></i>
											</span>
											<span>Subscribe</span>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Support Dropdown -->
			<div class="navbar-item has-dropdown is-hoverable">
				<div class="navbar-link" style="color: #FFFF;">Hỗ Trợ</div>
				<div id="moreDropdown" class="navbar-dropdown">
					<a class="navbar-item" href="#">
						<div class="level is-mobile">
							<div class="level-left">
								<div class="level-item">
									<strong>HOTLINE <i class="fa fa-volume-control-phone" aria-hidden="true"></i></strong>
									<p style="padding-left: 20px; font-size: large;">0111244899</p>
								</div>
							</div>
						</div>
					</a>
				</div>
			</div>

			<!-- Đặt Sân Link -->
			<a class="navbar-item" href="<%=request.getContextPath()%>/Trangchu/DatSan" style="color: #FFFF;">
				Đặt Sân
			</a>

			<% if (accesser != null && client != null && accesser.equals("user") && client.getRole().equals("1")) { %>
			<a class="navbar-item" href="<%=request.getContextPath()%>/Trangchu/Attendance" style="color: #FFFF; font-size: 18px">
				CheckIn/Out
			</a>
			<% } %>
		</div>
		
		<!-- Right Column - Search, Account, Cart -->
		<div class="navbar-end">
			<!-- Search Icon -->
			<a class="navbar-item" id="search-toggle" href="javascript:void(0);" style="color: #FFFF;">
				<i class="fa fa-search" aria-hidden="true" style="font-size: 20px;"></i>
			</a>
			
			<!-- Account Icon -->
			<a class="navbar-item" href="<%=request.getContextPath()%>/Trangchu/Account" style="color: #FFFF;">
				<i class="fa fa-user" aria-hidden="true" style="font-size: 20px;"></i>
			</a>
			
			<!-- Cart Icon with Counter -->
			<a class="navbar-item cart-icon-container" href="<%=request.getContextPath()%>/Trangchu/GioHang" style="color: #FFFF;">
				<i class="fa fa-shopping-cart" aria-hidden="true" style="font-size: 20px;"></i>
				<span <%=client == null || itemsCartList.size() == 0 ? "class=\"close\"" : "class=\"cart-count\""%>>
					<% if (client != null) { out.print(itemsCartList.size()); } %>
				</span>
			</a>
		</div>
	</div>

	<!-- Mobile Burger Menu -->
	<div class="navbar-burger burger" data-target="navMenubd-example" style="position: absolute; top: 10px; right: 10px;">
		<span></span>
		<span></span>
		<span></span>
	</div>

	<!-- Mobile Menu Content -->
	<div id="navMenubd-example" class="navbar-menu">
		<!-- Mobile menu content goes here (for responsive design) -->
	</div>
</nav>

<!-- Search Navbar -->
<div class="search-navbar" id="search-navbar">
	<div class="search-navbar-start">
		<a href="#" class="logo" title="Tuulkit">
			<img src="/style/assets/images/logoShop/LOGO CAMSPORT.png" alt="Logo" style="width: 70px;">
		</a>
	</div>
	
	<div class="search-navbar-center">
		<form class="search-form" method="get" action="<%=request.getContextPath() + "/Trangchu/ProductMenu"%>">
			<input type="search" name="search" class="search-input" placeholder="Tìm kiếm sản phẩm..." />
			<button type="submit" class="search-button">
				<i class="fa fa-search" aria-hidden="true"></i>
			</button>
		</form>
	</div>
	
	<div class="search-navbar-end">
		<!-- Account Icon -->
		<a class="navbar-item" href="<%=request.getContextPath()%>/Trangchu/Account" style="color: #FFFF;">
			<i class="fa fa-user" aria-hidden="true" style="font-size: 20px;"></i>
		</a>
		
		<!-- Cart Icon with Counter -->
		<a class="navbar-item cart-icon-container" href="<%=request.getContextPath()%>/Trangchu/GioHang" style="color: #FFFF;">
			<i class="fa fa-shopping-cart" aria-hidden="true" style="font-size: 20px;"></i>
			<span <%=client == null || itemsCartList.size() == 0 ? "class=\"close\"" : "class=\"cart-count\""%>>
				<% if (client != null) { out.print(itemsCartList.size()); } %>
			</span>
		</a>
		
		<!-- Close search button -->
		<button class="search-close" id="search-close">
			<i class="fa fa-times" aria-hidden="true"></i>
		</button>
	</div>
</div>

<script>
// JavaScript for search navbar transition
document.addEventListener('DOMContentLoaded', function() {
	const searchToggle = document.getElementById('search-toggle');
	const searchNavbar = document.getElementById('search-navbar');
	const searchClose = document.getElementById('search-close');
	const searchInput = document.querySelector('.search-input');
	
	searchToggle.addEventListener('click', function() {
		searchNavbar.classList.add('active');
		setTimeout(() => {
			searchInput.focus();
		}, 300);
	});
	
	searchClose.addEventListener('click', function() {
		searchNavbar.classList.remove('active');
	});
});
</script>