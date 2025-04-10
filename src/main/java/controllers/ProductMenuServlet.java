package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BOs.ProductBO;
import model.entities.Product;

@WebServlet(urlPatterns = "/Trangchu/ProductMenu")
public class ProductMenuServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	ArrayList<Product> productList=new ArrayList<Product>();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    req.setCharacterEncoding("UTF-8");
	    resp.setCharacterEncoding("UTF-8");
	    resp.setContentType("text/html; charset=UTF-8");
	    ArrayList<Product> productList=new ArrayList<Product>();
	    String search=req.getParameter("search");
	    String categoryID=req.getParameter("categoryID");
	    if(search==null) {
	    	if(categoryID==null) {
	    		productList=ProductBO.getProductFromData();
	    	}else {
	    		productList=ProductBO.getProductsByCategory(Integer.parseInt(categoryID));
	    	}
	    }else {
	    	productList = ProductBO.searchProducts(search);
	    }
	    req.setAttribute("productList", productList);
		RequestDispatcher dispatcher=req.getRequestDispatcher("/ProductMenu.jsp");
		dispatcher.forward(req, resp);
	}
}
