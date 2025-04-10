package controllers;


import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BOs.CartBO;
import model.BOs.OwnerShopBO;
import model.entities.Cart;
import model.entities.Shop;

@WebServlet("/Trangchu")
public class HomeServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
	    resp.setCharacterEncoding("UTF-8");
	    resp.setContentType("text/html; charset=UTF-8");
		ArrayList<Shop> shopList=new ArrayList<Shop>();
		shopList= OwnerShopBO.getShops();
		req.setAttribute("shopList", shopList);
		RequestDispatcher dispatcher=req.getRequestDispatcher("/Home.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    req.setCharacterEncoding("UTF-8");
	    resp.setCharacterEncoding("UTF-8");
	    resp.setContentType("text/html; charset=UTF-8");
	    int productID=Integer.parseInt(req.getParameter("productID"));
	    int clientID=Integer.parseInt(req.getParameter("clientID"));
	    Cart cart=new Cart(0, 1, "", clientID, productID );
	    CartBO.addCartToData(cart);
		resp.sendRedirect(req.getContextPath()+"/Trangchu");
	}
}
