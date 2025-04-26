<%@page import="model.entities.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.entities.Client"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/style/assets/images/logoShop/LOGO CAMSPORT.png" type="image/png">
<title>Đơn hàng của tôi</title>
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

.orders-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.orders-table th, .orders-table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
}

.orders-table th {
    background-color: #f2f2f2;
    color: #333;
}

.orders-table tr:nth-child(even) {
    background-color: #f9f9f9;
}

.orders-table tr:hover {
    background-color: #f0f0f0;
}

.btn-view {
    padding: 6px 12px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
}

.btn-cancel {
    padding: 6px 12px;
    background-color: #f44336;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
    margin-left: 8px;
}

.no-orders {
    margin-top: 30px;
    text-align: center;
    color: #666;
}

h1 {
    color: #333;
    border-bottom: 2px solid #eee;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.pending {
    color: #ff9800;
    font-weight: bold;
}

.completed {
    color: #4CAF50;
    font-weight: bold;
}

.cancelled {
    color: #f44336;
    font-weight: bold;
}
</style>
</head>
<%@ include file="/Pages/MasterPage/Header.jsp"%>
<body>
    <div class="container" style="margin-top: 100px;">
        <h1>Đơn hàng của tôi</h1>
        
        <%
        ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
        
        if (orders != null && !orders.isEmpty()) {
        %>
        <table class="orders-table">
            <thead>
                <tr>
                    <th>Mã đơn hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <% 
                for (Order order : orders) {
                %>
                <tr>
                    <td>#<%=order.getOrderID()%></td>
                    <td><%=order.getOrderDate()%></td>
                    <td><%=model.entities.Product.formMoney(Long.toString(order.getTotalAmount()))%> VNĐ</td>
                    <td>
                        <span class="<%=order.getStatus().toLowerCase()%>">
                            <%=order.getStatus().equals("pending") ? "Chờ xác nhận" : 
                               order.getStatus().equals("completed") ? "Hoàn thành" : 
                               order.getStatus().equals("cancelled") ? "Đã hủy" : order.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <a href="<%=request.getContextPath()%>/Trangchu/Orders?orderId=<%=order.getOrderID()%>" class="btn-view">Chi tiết</a>
                        <% if (order.getStatus().equals("pending")) { %>
                        <form action="<%=request.getContextPath()%>/Trangchu/Orders" method="post" style="display: inline;">
                            <input type="hidden" name="orderId" value="<%=order.getOrderID()%>">
                            <input type="hidden" name="action" value="cancel">
                            <button type="submit" class="btn-cancel" onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?')">Hủy đơn</button>
                        </form>
                        <% } %>
                    </td>
                </tr>
                <% 
                }
                %>
            </tbody>
        </table>
        <% 
        } else {
        %>
        <div class="no-orders">
            <p>Bạn chưa có đơn hàng nào.</p>
            <p><a href="<%=request.getContextPath()%>/Trangchu/ProductMenu">Tiếp tục mua sắm</a></p>
        </div>
        <% 
        }
        %>
    </div>

</body>
</html> 