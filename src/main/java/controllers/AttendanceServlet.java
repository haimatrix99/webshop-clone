package controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.BOs.AttendanceBO;
import model.entities.AttendanceRecord;
import model.entities.Client;
import model.entities.InfoAddress;
import model.entities.Location;

@WebServlet("/Trangchu/Attendance")
public class AttendanceServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession ses = request.getSession();
		Client client = (Client) ses.getAttribute("user");
		List<AttendanceRecord> attendanceList = AttendanceBO.findByEmployee(client.getId());
		request.setAttribute("attendanceList", attendanceList);
		request.getRequestDispatcher("/Pages/ActionDataPage/attendance.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession ses = request.getSession();
		Client client = (Client) ses.getAttribute("user");
		String action = request.getParameter("action");
		try {
			String urlString = "https://ipwhois.app/json/";
			URL url = new URL(urlString);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");

			if (conn.getResponseCode() != 200) {
				System.out.println("Lỗi: " + conn.getResponseCode());
				return;
			}

			// Đọc dữ liệu từ API
			BufferedReader br = new BufferedReader(
					new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
			StringBuilder resp = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
				resp.append(line);
			}
			br.close();
			conn.disconnect();

			// Chuyển response thành String
			String json = resp.toString();

			Location location = new Gson().fromJson(json, Location.class);
			// In kết quả
			System.out.println(
					"Vị trí: " + location.getCity() + ", " + location.getRegion() + ", " + location.getCountry());
			String vtri = getAddress(location.getLongitude(), location.getLatitude());
			AttendanceBO.addAttendance(client.getId(), action, vtri);
			response.sendRedirect(request.getContextPath() + "/Trangchu/Attendance");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public String getAddress(String lon, String lat) {
		try {
			String urlString = "https://nominatim.openstreetmap.org/reverse?lat=" + lat + "&lon=" + lon
					+ "&format=json";
			URL url = new URL(urlString);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");

			if (conn.getResponseCode() != 200) {
				System.out.println("Lỗi: " + conn.getResponseCode());
				return "HaNoi, VietNam";
			}

			// Đọc dữ liệu từ API
			BufferedReader br = new BufferedReader(
					new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
			StringBuilder resp = new StringBuilder();
			String line;
			while ((line = br.readLine()) != null) {
				resp.append(line);
			}
			br.close();
			conn.disconnect();

			// Chuyển response thành String
			String json = resp.toString();

			InfoAddress info = new Gson().fromJson(json, InfoAddress.class);
			// In kết quả
			System.out.println("Vị trí: " + new Gson().toJson(info));
			String vtri = info.getAddress().getRoad() + ", " + info.getAddress().getSuburb() + ", "
					+ info.getAddress().getCity();
			return vtri;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "HaNoi, VietNam";
	}
}
