package model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import config.ConnectionSQL;
import model.entities.Product;

public class ProductDAO {
	public static ArrayList<Product> findAll() {
		try {
			ArrayList<Product> productList = new ArrayList<Product>();
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			ResultSet rs = stm.executeQuery("Select * from product");
			while (rs.next()) {
				productList.add(new Product(rs.getInt("productID"), rs.getString("product"), rs.getString("priceO"),
						rs.getString("priceS"), rs.getString("img"), rs.getInt("shop_shopID"),
						rs.getInt("category_categoryID")));
			}
			System.out.println("Get product list database successed!");
			connection.close();
			return productList;
		} catch (SQLException e) {
			System.out.println("Get product list database failed!");
			e.printStackTrace();
		}

		return null;
	}

	public static ArrayList<Product> findByShopId(int shopID) {
		try {
			ArrayList<Product> productList = new ArrayList<Product>();
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			ResultSet rs = stm.executeQuery(String.format("Select * from product where shop_shopID=%d", shopID));
			while (rs.next()) {
				productList.add(new Product(rs.getInt("productID"), rs.getString("product"), rs.getString("priceO"),
						rs.getString("priceS"), rs.getString("img"), rs.getInt("shop_shopID"),
						rs.getInt("category_categoryID")));
			}
			System.out.println("Get product list of shop database successed!");
			connection.close();
			return productList;
		} catch (SQLException e) {
			System.out.println("Get product list of shop database failed!");
			e.printStackTrace();
		}

		return null;
	}
	public static ArrayList<Product> findLikeProduct(String key) {
		try {
			ArrayList<Product> productList = new ArrayList<Product>();
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			ResultSet rs = stm.executeQuery("Select * from product where product like '%"+key+"%'");
			while (rs.next()) {
				productList.add(new Product(rs.getInt("productID"), rs.getString("product"), rs.getString("priceO"),
						rs.getString("priceS"), rs.getString("img"), rs.getInt("shop_shopID"),
						rs.getInt("category_categoryID")));
			}
			System.out.println("Get product list of shop database successed!");
			connection.close();
			return productList;
		} catch (SQLException e) {
			System.out.println("Get product list of shop database failed!");
			e.printStackTrace();
		}

		return null;
	}
	public static Product findByProductId(int productID) {
		try {
			Product p = null;
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			ResultSet rs = stm.executeQuery(String.format("Select * from product where productID=%d", productID));
			if (rs.next()) {
				p = new Product(rs.getInt("productID"), rs.getString("product"), rs.getString("priceO"),
						rs.getString("priceS"), rs.getString("img"), rs.getInt("shop_shopID"),
						rs.getInt("category_categoryID"));
			}
			System.out.println("Get a product database successed!");
			connection.close();
			return p;
		} catch (SQLException e) {
			System.out.println("Get a product database failed!");
			e.printStackTrace();
		}

		return null;
	}

	public static void insert(String product, String oPrice, String salePrice, String urlImage, int shopId,
			int categoryId) {
		try {
			Connection connection = ConnectionSQL.getConnection();
			PreparedStatement stm = connection.prepareStatement(
					"Insert Into product(product,priceO,priceS,img,shop_shopID,category_categoryID) values(?,?,?,?,?,?)");
			stm.setString(1, product);
			stm.setString(2, oPrice);
			stm.setString(3, salePrice);
			stm.setString(4, urlImage);
			stm.setInt(5, shopId);
			stm.setInt(6, categoryId);
			stm.executeUpdate();
			connection.close();
			stm.close();
			System.out.println("Add product into database successed!");
		} catch (SQLException e) {
			System.out.println("Add product into database failed!");
			e.printStackTrace();
		}
	}

	public static void deleteByProductId(int productID) {
		try {
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			stm.executeUpdate(String.format("DELETE FROM product WHERE productID=%d;", productID));
			connection.close();
			System.out.println("Delete a product in database successed!");
		} catch (SQLException e) {
			System.out.println("Delete a product in database failed!");
			e.printStackTrace();
		}
	}

	public static void UpdateByProductId(String product, String oPrice, String sPrice, String urlImage, int categoryId,
			int productId) {
		try {
			Connection connection = ConnectionSQL.getConnection();
			PreparedStatement stm = connection.prepareStatement(
					"UPDATE product SET product=?, priceO=?, priceS=?, img=?, category_categoryID=? WHERE productID=?");
			stm.setString(1, product);
			stm.setString(2, oPrice);
			stm.setString(3, sPrice);
			stm.setString(4, urlImage);
			stm.setInt(5, categoryId);
			stm.setInt(6, productId);
			stm.executeUpdate();
			connection.close();
			System.out.println("Update a product in database successed!");
		} catch (SQLException e) {
			System.out.println("Update a product in database failed!");
			e.printStackTrace();
		}
	}

	public static ArrayList<Product> findByCategoryId(int categoryID) {
		try {
			ArrayList<Product> productList = new ArrayList<Product>();
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			ResultSet rs = stm
					.executeQuery(String.format("Select * from product where category_categoryID=%d", categoryID));
			while (rs.next()) {
				productList.add(new Product(rs.getInt("productID"), rs.getString("product"), rs.getString("priceO"),
						rs.getString("priceS"), rs.getString("img"), rs.getInt("shop_shopID"),
						rs.getInt("category_categoryID")));
			}
			System.out.println("Get products by category database successed!");
			connection.close();
			return productList;
		} catch (SQLException e) {
			System.out.println("Get products by category database failed!");
			e.printStackTrace();
		}

		return null;
	}
}
