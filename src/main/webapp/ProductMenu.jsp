<%@page import="model.entities.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/style/assets/css/stylePageHome.css">
</head>
<body>
	<%@ include file="/Pages/MasterPage/Header.jsp"%>
	<div class="Products" style="margin-top: 60px">
		<%
		ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("productList");
		for (Product product : productList) {
		%>
		<a class="Product"
			href="<%=request.getContextPath()%>/Trangchu/Product?id=<%=product.getId()%>&product=<%=product.getFewChar()%>&priceO=<%=Product.formMoney(product.getOriginalPrice())%>&priceS=<%=Product.formMoney(product.getSalePrice())%>&url=<%=product.getUrl()%>&shopID=<%=product.getShopID()%>">
			<div>
				<span
					class="sale<%if (product.getOriginalPrice().equals(product.getSalePrice()))
	out.print(" close");%>"><%=Math.round(
		(1 - Long.parseLong(product.getSalePrice()) * 1.0 / Long.parseLong(product.getOriginalPrice())) * 100.0)%>%</span>
				<img src="<%=product.getUrl()%>" alt="tainghe-airpod"
					style="max-width: 250px;">
			</div>
			<div class="content--product">
				<div>
					<h4 style="margin: 4px 6px;"><%=product.getFewChar()%></h4>
				</div>
				<div class="update--status">
					<div>
						<div class="_2OiIy8 _3UxTxH"
							style="font-size: 12px; margin-top: 8px;">
							Đã bán
							<%=product.getNumsold()%></div>
						<div class="price" style="font-size: 16px;">
							<span class="_2SnSlL"><%=Product.formMoney(product.getSalePrice())%></span><span
								class="_1KHyQl">₫</span>
						</div>
					</div>
					<div>
						<%
						if (accesser != null && accesser.equals("user") && client != null)
							out.print("<form method='post'>" + "<input style='display: none' name='clientID' value='" + client.getId() + "'>"
							+ "<input style='display: none' name='productID' value='" + product.getId() + "'>"
							+ "<button class='btn btn--buyticket js--btn--buyticket'>Buy Now<i class='fa fa-cart-plus' aria-hidden='true' style='margin-left: 5px;'></i></button>"
							+ "</form>");
						else
							out.print(
							"<button class='btn btn--buyticket js--btn--buyticket'>Buy Now<i class='fa fa-cart-plus' aria-hidden='true' style='margin-left: 5px;'></i></button>");
						%>

					</div>
				</div>
			</div>
		</a>
		<%
		}
		%>
	</div>
</body>
</html>