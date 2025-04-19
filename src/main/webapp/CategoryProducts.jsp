<%@page import="model.BOs.ProductBO"%>
<%@page import="model.BOs.CategoryBO"%>
<%@page import="model.entities.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int categoryId = (Integer) request.getAttribute("categoryId");
String categoryName = (String) request.getAttribute("categoryName");
ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("productList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%=categoryName%> - Camsport Shop</title>
<link rel="icon" href="/style/assets/images/logoShop/LOGO CAMSPORT.png" type="image/png">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/style/assets/css/stylePageHome.css">
<style>
.category-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}
.category-header {
    text-align: center;
    margin-bottom: 20px;
}
.category-title {
    color: #ee4d2d;
    font-size: 24px;
    font-weight: 700;
}
.product-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 15px;
}
.product-card {
    width: calc(20% - 15px);
    min-width: 180px;
    margin-bottom: 20px;
    transition: transform 0.3s;
    border-radius: 5px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}
.product-card:hover {
    transform: translateY(-5px);
}
.back-link {
    display: inline-block;
    margin: 15px 0;
    color: #ee4d2d;
    text-decoration: none;
    font-weight: bold;
}
.back-link:hover {
    text-decoration: underline;
}
@media (max-width: 768px) {
    .product-card {
        width: calc(33.33% - 15px);
    }
}
@media (max-width: 480px) {
    .product-card {
        width: calc(50% - 15px);
    }
}
</style>
</head>
<%@ include file="/Pages/MasterPage/Header.jsp"%>
<body>
    <div class="category-container">
        <a href="<%=request.getContextPath()%>/Trangchu" class="back-link">
            <i class="fa fa-arrow-left" aria-hidden="true"></i> Back to Home
        </a>
        
        <div class="category-header">
            <h1 class="category-title"><%=categoryName%></h1>
            <div style="width: 100px; height: 3px; background-color: #ee4d2d; margin: 10px auto;"></div>
            <p><%=productList != null ? productList.size() : 0%> products found</p>
        </div>
        
        <div class="product-grid">
            <% if (productList != null && !productList.isEmpty()) {
                for (Product product : productList) { %>
                <a class="product-card" href="<%=request.getContextPath()%>/Trangchu/Product?id=<%=product.getId()%>">
                    <div style="position: relative;">
                        <span class="sale<%if (product.getOriginalPrice().equals(product.getSalePrice())) out.print(" close");%>">
                            <%
                            try {
                                out.print(Math.round(
                                (1 - Long.parseLong(product.getSalePrice()) * 1.0 / Long.parseLong(product.getOriginalPrice())) * 100.0));
                            } catch (Exception e) {
                                out.print(0);
                            }
                            %>%
                        </span>
                        <img src="<%=product.getUrl()%>" alt="<%=product.getFewChar()%>" style="width: 100%; height: 180px; object-fit: contain;">
                    </div>
                    <div class="content--product" style="padding: 10px;">
                        <div>
                            <h4 style="margin: 4px 0; font-size: 14px; height: 40px; overflow: hidden;"><%=product.getFewChar()%></h4>
                        </div>
                        <div class="update--status" style="display: flex; justify-content: space-between; align-items: center; margin-top: 10px;">
                            <div>
                                <div style="font-size: 12px; color: #757575;">
                                    Đã bán <%=product.getNumsold()%>
                                </div>
                                <div class="price" style="font-size: 16px; color: #ee4d2d; font-weight: bold;">
                                    <span><%=Product.formMoney(product.getSalePrice())%></span><span>₫</span>
                                </div>
                            </div>
                            <div>
                                <% if (accesser != null && accesser.equals("user") && client != null) { %>
                                <form method="post">
                                    <input style="display: none" name="clientID" value="<%=client.getId()%>">
                                    <input style="display: none" name="productID" value="<%=product.getId()%>">
                                    <input style="display: none" name="categoryId" value="<%=categoryId%>">
                                    <button onclick="showAlert()" class="btn btn--buyticket js--btn--buyticket" style="padding: 5px 10px; font-size: 12px;">
                                        <i class="fa fa-cart-plus" aria-hidden="true"></i>
                                    </button>
                                </form>
                                <% } else { %>
                                <form method="post">
                                    <input style="display: none" name="productID" value="<%=product.getId()%>">
                                    <input style="display: none" name="categoryId" value="<%=categoryId%>">
                                    <button onclick="showAlert()" class="btn btn--buyticket js--btn--buyticket" style="padding: 5px 10px; font-size: 12px;">
                                        <i class="fa fa-cart-plus" aria-hidden="true"></i>
                                    </button>
                                </form>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </a>
            <% }
            } else { %>
                <div style="text-align: center; padding: 50px 0;">
                    <p>No products found in this category.</p>
                </div>
            <% } %>
        </div>
    </div>
    
    <script>
    function showAlert() {
      alert("Thêm vào giỏ hàng thành công!");
    }
    </script>
    
    <%@ include file="/Pages/MasterPage/Footer.jsp"%>
</body>
</html> 