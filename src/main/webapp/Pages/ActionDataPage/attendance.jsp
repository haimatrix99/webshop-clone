<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.entities.AttendanceRecord" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chấm Công Nhân Viên</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/style/assets/css/attendance.css">
</head>
<body>
<%@ include file="/Pages/MasterPage/Header.jsp"%>
    <div class="container">
        <h1 style ="font-size:40px">Chấm Công Nhân Viên</h1>
		<h1 style ="font-size:30px">Xin chào, <%= client.getFullName() %></h1>
        <div class="layout">
            <!-- Cột trái: Lịch sử chấm công -->
            <div class="column history">
                <h2>Lịch Sử Chấm Công</h2>
                <table border="1">
                    <tr>
                    	<th>Tên NV</th>
                        <th>Ngày</th>
                        <th>Check-in</th>
                        <th>Check-out</th>
                        <th>Trạng thái</th>
                        <th>Vị trí</th>
                    </tr>
                    <%
                        List<AttendanceRecord> attendanceList = (List<AttendanceRecord>) request.getAttribute("attendanceList");
                        if (attendanceList != null && !attendanceList.isEmpty()) {
                            for (AttendanceRecord record : attendanceList) {
                    %>
                    <tr>
                    	<td><%= client.getFullName() %></td>
                        <td><%= record.getDate() %></td>
                        <td><%= record.getCheckinTime() %></td>
                        <td><%= record.getCheckoutTime() %></td>
                        <td><%= record.getStatus() %></td>
                        <td><%= record.getLocation() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4">Không có lịch sử chấm công</td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
            <div>
                <h2>Check-in / Check-out</h2>
                <form method="post">
                    <input type="hidden" name="employeeId" value="1">
                    <button type="submit" name="action" value="checkin">Check-in</button>
                    <button type="submit" name="action" value="checkout">Check-out</button>
                </form>
            </div>
        </div>
    </div>
    <div style="width: 100%; background-color: #ee4d2d; height: 6px; margin-top: 10px; margin-bottom: 40px;"></div>
</body>
</html>
