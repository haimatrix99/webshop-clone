package model.BOs;

import java.util.ArrayList;

import model.DAOs.ProductDAO;
import model.entities.Product;

public class ProductBO {
	public static ArrayList<Product> getProductFromData() {

		return ProductDAO.findAll();
	}

	public static ArrayList<Product> getProductsByShop(int shopID) {

		return ProductDAO.findByShopId(shopID);
	}

	public static Product getProductByID(int productID) {

		return ProductDAO.findByProductId(productID);
	}

	public static void addProductToData(Product product) {

		ProductDAO.insert(product.getProduct(), product.getOriginalPrice(), product.getSalePrice(), product.getUrl(),
				product.getShopID(), product.getCategoryID());
	}

	public static void deleteProductInData(int productID) {
		ProductDAO.deleteByProductId(productID);
	}

	public static void updateProductInData(Product product) {
		ProductDAO.UpdateByProductId( product.getProduct(), product.getOriginalPrice(), product.getSalePrice(), product.getUrl(),
					product.getCategoryID(), product.getId());
	}

	public static ArrayList<Product> getProductsByCategory(int categoryID) {

		return ProductDAO.findByCategoryId(categoryID);
	}
	public static ArrayList<Product> searchProducts(String key) {

		return ProductDAO.findLikeProduct(key);
	}
}
