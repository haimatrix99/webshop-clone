<%@page import="model.BOs.ProductBO"%>
<%@page import="model.entities.Product"%>
<%@page import="model.entities.OrderDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.entities.Client"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/style/assets/images/logoShop/LOGO CAMSPORT.png" type="image/png">
<title>Chi Tiết Đơn Hàng</title>
<link
    href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800"
    rel="stylesheet">
<script
    src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<style type="text/css">
.container {
    max-width: 980px !important;
    margin: 0 auto;
    padding: 20px;
}

.order-details-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.order-details-table th, .order-details-table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
}

.order-details-table th {
    background-color: #f2f2f2;
    color: #333;
}

.order-details-table tr:nth-child(even) {
    background-color: #f9f9f9;
}

.order-details-table tr:hover {
    background-color: #f0f0f0;
}

.product-img {
    width: 60px;
    height: 60px;
    object-fit: contain;
}

.back-link {
    display: inline-block;
    margin-bottom: 20px;
    color: #4CAF50;
    text-decoration: none;
}

.back-link:hover {
    text-decoration: underline;
}

.order-total {
    margin-top: 20px;
    text-align: right;
    font-size: 18px;
}

.order-total strong {
    color: #ee4d2d;
}

h1 {
    color: #333;
    border-bottom: 2px solid #eee;
    padding-bottom: 10px;
    margin-bottom: 20px;
}
</style>
</head>
<%@ include file="/Pages/MasterPage/Header.jsp"%>
<body>
    <div class="container" style="margin-top: 100px;">
        <a href="<%=request.getContextPath()%>/Trangchu/Orders" class="back-link">← Quay lại danh sách đơn hàng</a>
        
        <h1>Chi Tiết Đơn Hàng</h1>
        
        <%
        ArrayList<OrderDetail> orderDetails = (ArrayList<OrderDetail>) request.getAttribute("orderDetails");
        
        if (orderDetails != null && !orderDetails.isEmpty()) {
            long totalAmount = 0;
            int orderId = orderDetails.get(0).getOrderID();
        %>
        <div>
            <p><strong>Mã đơn hàng:</strong> #<%=orderId%></p>
        </div>
        
        <table class="order-details-table">
            <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <% 
                for (OrderDetail detail : orderDetails) {
                    Product product = ProductBO.getProductByID(detail.getProductID());
                    long itemTotal = detail.getPrice() * detail.getQuantity();
                    totalAmount += itemTotal;
                %>
                <tr>
                    <td>
                        <img src="<%=product.getUrl()%>" alt="<%=product.getProduct()%>" class="product-img">
                    </td>
                    <td><%=product.getProduct()%></td>
                    <td><%=Product.formMoney(String.valueOf(detail.getPrice()))%> VNĐ</td>
                    <td><%=detail.getQuantity()%></td>
                    <td><%=Product.formMoney(String.valueOf(itemTotal))%> VNĐ</td>
                </tr>
                <% 
                }
                %>
            </tbody>
        </table>
        
        <div class="order-total">
            <p>Phí vận chuyển: <strong>20.000 VNĐ</strong></p>
            <p>Thuế (2%): <strong><%=Product.formMoney(String.valueOf(Math.round(totalAmount * 0.02)))%> VNĐ</strong></p>
            <p>Tổng thanh toán: <strong><%=Product.formMoney(String.valueOf(totalAmount + 20000 + Math.round(totalAmount * 0.02)))%> VNĐ</strong></p>
        </div>
        
        <% 
        } else {
        %>
        <div>
            <p>Không tìm thấy thông tin chi tiết đơn hàng.</p>
        </div>
        <% 
        }
        %>
    </div>

</body>
</html> 