package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BOs.ClientBO;
import model.entities.Client;

@WebServlet("/Trangchu/Account")
@MultipartConfig(maxFileSize = 1024 * 100, maxRequestSize = 1024 * 300)
public class AccountServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		if(req.getParameter("setting")!=null) {
			req.getRequestDispatcher("/Pages/ManegerPage/profile_edit.jsp").forward(req, resp);
		}
		else {
			req.getRequestDispatcher("/Pages/ManegerPage/profile.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession ses = req.getSession();

		int clientID = Integer.parseInt((String) req.getParameter("clientID"));
		String user = (String) req.getParameter("user");
		String pass = (String) req.getParameter("pass");
		String name = (String) req.getParameter("fullname");
		String address = (String) req.getParameter("address");
		String phone = (String) req.getParameter("phone");
		String birthday = (String) req.getParameter("birthday");
		String money = (String) req.getParameter("money");
		String image = (String) req.getParameter("image");
		Client client = new Client(clientID, user, pass, money, name, birthday, address, phone,
				image,"0");
		ClientBO.updateAccountInData(client);
		ses.setAttribute("user", client);
		resp.sendRedirect(req.getContextPath() + "/Trangchu");
	}
}
