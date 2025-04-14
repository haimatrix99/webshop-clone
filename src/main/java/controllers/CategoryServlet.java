package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BOs.CategoryBO;
import model.BOs.ProductBO;
import model.entities.Category;
import model.entities.Product;

@WebServlet(urlPatterns = "/Trangchu/Category")
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        int categoryId = Integer.parseInt(req.getParameter("id"));
        String categoryName = CategoryBO.getCategory(categoryId);
        ArrayList<Product> productList = ProductBO.getProductsByCategory(categoryId);

        req.setAttribute("categoryId", categoryId);
        req.setAttribute("categoryName", categoryName);
        req.setAttribute("productList", productList);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/CategoryProducts.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        int productID = Integer.parseInt(req.getParameter("productID"));
        int clientID = Integer.parseInt(req.getParameter("clientID"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));

        // Add to cart logic (same as in HomeServlet)
        model.entities.Cart cart = new model.entities.Cart(0, 1, "", clientID, productID);
        model.BOs.CartBO.addCartToData(cart);

        // Redirect back to the category page
        resp.sendRedirect(req.getContextPath() + "/Trangchu/Category?id=" + categoryId);
    }
}