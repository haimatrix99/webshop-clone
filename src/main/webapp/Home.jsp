<%@page import="model.BOs.ProductBO"%>
<%@page import="model.BOs.CategoryBO"%>
<%@page import="model.DAOs.ProductDAO"%>
<%@page import="model.entities.Shop"%>
<%@page import="model.entities.Product"%>
<%@page import="model.entities.Category"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ArrayList<Product> hotProductList = ProductBO.getProductFromData(); // Load all products as hot
ArrayList<Shop> shopList = new ArrayList<Shop>();
shopList = (ArrayList<Shop>) request.getAttribute("shopList");
// For categories and shop products
ArrayList<Product> productList = new ArrayList<Product>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Camsport Shop</title>
<link rel="icon" href="/style/assets/images/logoShop/LOGO CAMSPORT.png" type="image/png">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.3/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.css"
	rel="stylesheet" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick-theme.min.css"
	rel="stylesheet" 
/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/style/assets/css/stylePageHome.css">

<script type="text/javascript">
        $(document).on('ready', function () {
            $(".Products-hot").slick({
              infinite: true,
              slidesToShow: 6,
              slidesToScroll: 3
          });
        })
  </script>
<style>
.slick-prev:before {
	color: #ee4d2d;
	font-size: 30px;
}

.slick-next:before {
	color: #ee4d2d;
	font-size: 30px;
}

.close {
	display: none;
}

/* Added styles for slider images */
.mySlides img {
	width: 100%;
	height: 700px;
	object-fit: cover;
	object-position: center;
}

.slideshow-container {
	max-width: 100%;
	position: relative;
	margin: auto;
}
</style>
</head>
<%@ include file="/Pages/MasterPage/Header.jsp"%>
<body>
	<div id="main-home">

		<div class="slider">
			<div class="slideshow-container">

				<div class="mySlides fade">
					<img src="/style/assets/images/slider/slider_1.jpg">
				</div>

				<div class="mySlides fade">
					<img src="/style/assets/images/slider/slider_2.jpg">
				</div>

				<div class="mySlides fade">
					<img src="/style/assets/images/slider/slider_3.jpg">
				</div>

				<div class="mySlides fade">
					<img src="/style/assets/images/slider/slider_4.jpg">
				</div>

				<div class="mySlides fade">
					<img src="/style/assets/images/slider/slider_5.jpg">
				</div>

				<div class="mySlides fade">
					<img src="/style/assets/images/slider/slider_6.jpg">
				</div>

				<div class="mySlides fade">
					<img src="/style/assets/images/slider/slider_7.jpg">
				</div>

				<a class="prev" onclick="plusSlides(-1)">❮</a> <a class="next"
					onclick="plusSlides(1)">❯</a>
				<div class="dots">
					<span class="dot" onclick="currentSlide(1)"></span>
					<span class="dot" onclick="currentSlide(2)"></span>
					<span class="dot" onclick="currentSlide(3)"></span>
					<span class="dot" onclick="currentSlide(4)"></span>
					<span class="dot" onclick="currentSlide(5)"></span>
					<span class="dot" onclick="currentSlide(6)"></span>
					<span class="dot" onclick="currentSlide(7)"></span>
				</div>
			</div>
		</div>
		<div style="background-color: #FFFF;">
			<div style="padding: 10px; text-align: center; height: 48px;">
				<h1 style="color: #ee4d2d; font-size: 18px; font-weight: 700;">Sản
					Phẩm Được Xem Nhiều Nhất</h1>
			</div>
			<div style="width: 100%; height: 1px; background-color: #ee4d2d;"></div>
			<div class="Products-hot">
				<% if (hotProductList != null && !hotProductList.isEmpty()) {
					for (Product product : hotProductList) { %>
				<div class="Product-hot">
					<a href="<%=request.getContextPath()%>/Trangchu/Product?id=<%=product.getId()%>">
						<div>
							<span class="span-hot"></span>
							<span class="spans"></span>
							<img src="<%=product.getUrl()%>" alt="<%=product.getFewChar()%>">
						</div>
						<div><%=product.getFewChar()%></div>
					</a>
				</div>
				<% } } %>
			</div>
		</div>
		<!-- Add Products By Category Section -->
		<% if (categoryList != null) 
			for (Category category : categoryList) {
				ArrayList<Product> categoryProducts = ProductBO.getProductsByCategory(category.getCategoryID());
				if (categoryProducts != null && !categoryProducts.isEmpty()) {
		%>
		<div style="max-width: 100%; background-color: #FFFF; margin-top: 20px;">
			<div style="padding: 10px; text-align: center; height: 48px;">
				<h1 style="color: #ee4d2d; font-size: 18px; font-weight: 700;"><%=category.getNameCategory()%></h1>
			</div>
			<div style="width: 95%; height: 2px; background-color: #ee4d2d; margin: 0 auto;"></div>
			
			<div class="category-products" style="display: flex; flex-wrap: wrap; justify-content: center; padding: 15px;">
				<%
				for (Product product : categoryProducts) {
					if (categoryProducts.size() > 10 && categoryProducts.indexOf(product) >= 10) break; // Limit to 6 products per category
				%>
				<a class="Product" style="width: 16%; min-width: 180px; margin: 10px;"
					href="<%=request.getContextPath()%>/Trangchu/Product?id=<%=product.getId()%>">
					<div>
						<span
							class="sale<%if (product.getOriginalPrice().equals(product.getSalePrice()))
	out.print(" close");%>">
							<%
							try {
								out.print(Math.round(
								(1 - Long.parseLong(product.getSalePrice()) * 1.0 / Long.parseLong(product.getOriginalPrice())) * 100.0));
							} catch (Exception e) {
								out.print(0);
							}
							%>%
						</span> <img src="<%=product.getUrl()%>" alt="<%=product.getFewChar()%>"
							style="max-width: 160px; height: auto;">
					</div>
					<div class="content--product">
						<div>
							<h4 style="margin: 4px 6px; font-size: 14px;"><%=product.getFewChar()%></h4>
						</div>
						<div class="update--status">
							<div>
								<!-- <div class="_2OiIy8 _3UxTxH"
									style="font-size: 12px; margin-top: 8px;">
									Đã bán
									<%=product.getNumsold()%></div> -->
								<div class="price" style="font-size: 16px;">
									<span class="_2SnSlL"><%=Product.formMoney(product.getSalePrice())%></span><span
										class="_1KHyQl">₫</span>
								</div>
							</div>
							<div>
								<%
								if (accesser != null && accesser.equals("user") && client != null) {
								%>
								<form method="post">
									<input style="display: none" name="clientID" value="<%=client.getId()%>">
									<input style="display: none" name="productID" value="<%=product.getId()%>">
									<button onclick="showAlert()" class="btn btn--buyticket js--btn--buyticket">Add to Cart<i class="fa fa-cart-plus" aria-hidden="true" style="margin-left: 5px;"></i></button>
								</form>
								<%
								} else {
								%>
								<form method="post">
									<input style="display: none" name="productID" value="<%=product.getId()%>">
									<button onclick="showAlert()" class="btn btn--buyticket js--btn--buyticket">Add to Cart<i class="fa fa-cart-plus" aria-hidden="true" style="margin-left: 5px;"></i></button>
								</form>
								<%
								}
								%>
							</div>
						</div>
					</div>
				</a>
				<%
				}
				%>
				<!-- View All Link -->
				<div style="width: 100%; text-align: center; margin-top: 15px;">
					<a href="<%=request.getContextPath()%>/Trangchu/ProductMenu?categoryID=<%=category.getCategoryID()%>" 
					   style="color: #ee4d2d; text-decoration: none; font-weight: bold;">
						View All Products in <%=category.getNameCategory()%> <i class="fa fa-arrow-right" aria-hidden="true"></i>
					</a>
				</div>
			</div>
		</div>
		<%
				}
			}
		%>
		
		<%
		if (shopList != null)
			for (Shop shop : shopList) {
				productList = ProductBO.getProductsByShop(shop.getId());
		%>
		<%
		int slidesToShow = productList.size() < 5 ? productList.size() : 5;
		int slidesToScroll = productList.size() <= 3 ? 2 : 3;
		%>
		<script type="text/javascript">
			$(document).on('ready', function () {
				$(".Shop<%=shop.getId()%>").slick({
					infinite: true,
					slidesToShow: <%=slidesToShow%>,
					slidesToScroll: <%=slidesToScroll%>
				});
			});
		</script>
		<div style="max-width: 100%; background-color: #FFFF;">
			<div class="shop" style = "padding-right: 30px">
				<div class="header-shop">
					<div
						style="border-radius: 50%; border: 2px solid #4444; padding: 10px">
						<img src="<%=shop.getUrlAvatar()%>" alt=""
							style="width: 80px; border-radius: 50%;">
					</div>
					<div>
						<h1 style="font-size: 30px;"><%=shop.getNameShop()%></h1>
					</div>
				</div>
				<div
					style="width: 95%; height: 4px; background-color: #aaa !important;"></div>
			</div>

			<div class="Shop<%=shop.getId()%>">
				<%
				if (productList != null)
					for (Product product : productList) {
				%>
				<a class="Product"
					href="<%=request.getContextPath()%>/Trangchu/Product?id=<%=product.getId()%>">
					<div>
						<span
							class="sale<%if (product.getOriginalPrice().equals(product.getSalePrice()))
	out.print(" close");%>">
							<%
							try {
								out.print(Math.round(
								(1 - Long.parseLong(product.getSalePrice()) * 1.0 / Long.parseLong(product.getOriginalPrice())) * 100.0));
							} catch (Exception e) {
								out.print(0);
							}
							%>%
						</span> <img src="<%=product.getUrl()%>" alt="tainghe-airpod"
							style="max-width: 250px;">
					</div>
					<div class="content--product">
						<div>
							<h4 style="margin: 4px 6px;"><%=product.getFewChar()%></h4>
						</div>
						<div class="update--status">
							<div>
								<!-- <div class="_2OiIy8 _3UxTxH"
									style="font-size: 12px; margin-top: 8px;">
									Đã bán
									<%=product.getNumsold()%></div> -->
								<div class="price" style="font-size: 16px;">
									<span class="_2SnSlL"><%=Product.formMoney(product.getSalePrice())%></span><span
										class="_1KHyQl">₫</span>
								</div>
							</div>
							<div>
								<%
								if (accesser != null && accesser.equals("user") && client != null) {
								%>
								<form method="post">
									<input style="display: none" name="clientID" value="<%=client.getId()%>">
									<input style="display: none" name="productID" value="<%=product.getId()%>">
									<button onclick="showAlert()" class="btn btn--buyticket js--btn--buyticket">Add to Cart<i class="fa fa-cart-plus" aria-hidden="true" style="margin-left: 5px;"></i></button>
								</form>
								<%
								} else {
								%>
								<form method="post">
									<input style="display: none" name="productID" value="<%=product.getId()%>">
									<button onclick="showAlert()" class="btn btn--buyticket js--btn--buyticket">Add to Cart<i class="fa fa-cart-plus" aria-hidden="true" style="margin-left: 5px;"></i></button>
								</form>
								<%
								}
								%>

							</div>
						</div>
					</div>
				</a>

				<%
				}
				%>
			</div>

		</div>
		<%
		}
		%>
	</div>
	</div>
	<script>
    function showAlert() {
      alert("Thêm vào giỏ hàng thành công!");
    }
    </script>
	<%@ include file="/Pages/MasterPage/Footer.jsp"%>
	<script type="text/javascript"
		src="/style/assets/js/js-pageHome.js"></script>
</body>
</html>