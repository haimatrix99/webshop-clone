package model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import config.ConnectionSQL;
import model.entities.Cart;

public class CartDAO {
    public static void insert(int quantity,String feature,int clientID,int productID) {
    	try {
    		Connection connection=ConnectionSQL.getConnection();
    		PreparedStatement stm=connection.prepareStatement("Insert Into cart (quantity,feature,client_clientID,product_productID) values(?,?,?,?)");
			stm.setInt(1, quantity);
			stm.setString(2, feature);
			stm.setInt(3, clientID);
			stm.setInt(4, productID);
    		stm.executeUpdate();
    		stm.close();
			connection.close();
			System.out.println("Add new cart into database successed!");
		} catch (SQLException e) {
			System.out.println("Add new cart into database failed!");
			e.printStackTrace();
		}
    }
    public static ArrayList<Cart> findAll() {
    	try {
    		ArrayList<Cart> itemsCartList=new ArrayList<Cart>();
    		Connection connection=ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			ResultSet rs=stm.executeQuery("Select * from cart");
			while (rs.next()) {
				itemsCartList.add(new Cart(rs.getInt("cartID"), rs.getInt("quantity"), rs.getString("feature"),rs.getInt("client_clientID"),rs.getInt("product_productID")));
			}
			System.out.println("Get item in cart database successed!");
			connection.close();
			return itemsCartList;
		} catch (SQLException e) {
			System.out.println("Get item in cart database failed!");
			e.printStackTrace();
		}
    	
		return null;
    }
    public static int countByClientId(int clientID) {
    	try {
    		Connection connection=ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			ResultSet rs=stm.executeQuery(String.format("SELECT COUNT(*) FROM cart WHERE client_clientID=%d;",clientID));
			System.out.println("Get number of item in cart database successed!");
			connection.close();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("Get number of item in cart database failed!");
			e.printStackTrace();
		}
    	
		return 0;	
    }
    public static ArrayList<Cart> findByClientId(int clientID) {
    	try {
    		ArrayList<Cart> itemsCartList=new ArrayList<Cart>();
    		Connection connection=ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			ResultSet rs=stm.executeQuery(String.format("SELECT * FROM cart WHERE client_clientID=%d;",clientID));
			while (rs.next()) {
				itemsCartList.add(new Cart(rs.getInt("cartID"), rs.getInt("quantity"), rs.getString("feature"),rs.getInt("client_clientID"),rs.getInt("product_productID")));
			}
			connection.close();
			return itemsCartList;
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return null;	
    }
    public static void deleteByCartId(int cartID) {
    	try {
    		Connection connection=ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			stm.executeUpdate(String.format("DELETE FROM cart WHERE cartID=%d;",cartID));
			connection.close();
			System.out.println("Delete item in database successed!");
		} catch (SQLException e) {
			System.out.println("Delete item in database failed!");
			e.printStackTrace();
		}
    }
    public static void updateQuantityByCartId(int cartID,int quantity) {
    	try {
    		Connection connection= ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();

			stm.executeUpdate(String.format("UPDATE cart SET quantity=%d WHERE cartID=%d;",quantity,cartID));
			connection.close();
			System.out.println("Update cart in database successed!");
		} catch (SQLException e) {
			System.out.println("Update cart in database failed!");
			e.printStackTrace();
		}
    }

    public static void deleteByClientId(int clientID) {
    	try {
    		Connection connection=ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			stm.executeUpdate(String.format("DELETE FROM cart WHERE client_clientID=%d;",clientID));
			
			connection.close();
			System.out.println("Delete cart in database successed!");
		} catch (SQLException e) {
			System.out.println("Delete cart in database failed!");
			e.printStackTrace();
		}
    }
}
