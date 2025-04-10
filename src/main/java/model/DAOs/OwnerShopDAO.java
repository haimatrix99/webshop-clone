package model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import config.ConnectionSQL;
import model.entities.Shop;

public class OwnerShopDAO {
    public static void insert(String user,String pass,String nameShop,String avatar) {
    	try {
    		Connection connection= ConnectionSQL.getConnection();
    		PreparedStatement stm=connection.prepareStatement("Insert Into shop (user,pass,nameShop,numFollower,urlAvatar) values(?,?,?,?,?)");
			stm.setString(1, user);
			stm.setString(2, pass);
			stm.setString(3, nameShop);
			stm.setString(4, "0");
			stm.setString(5, avatar);
    		stm.executeUpdate();
			connection.close();
			stm.close();
			System.out.println("create new a shop into database successed!");
		} catch (SQLException e) {
			System.out.println("create new a shop into database failed!");
			e.printStackTrace();
		}
    }
    public static ArrayList<Shop> findAll() {
    	try {
    		ArrayList<Shop> shopList=new ArrayList<Shop>();
    		Connection connection=ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			ResultSet rs=stm.executeQuery("Select * from shop");
			while (rs.next()) {
				shopList.add(new Shop(rs.getInt("shopID"), rs.getString("user"), rs.getString("pass"),
						rs.getString("nameShop"),rs.getString("numFollower"), rs.getString("urlAvatar")));
			}
			System.out.println("Get shops database successed!");
			connection.close();
			return shopList;
		} catch (SQLException e) {
			System.out.println("Get shops database failed!");
			e.printStackTrace();
		}
    	
		return null;
    }
    public static Shop findByShopId(int shopID) {
    	try {
    		Shop shop=null;
    		Connection connection=ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			ResultSet rs=stm.executeQuery(String.format("Select * from shop where shopID=%d",shopID));
			if (rs.next()) {
				shop=new Shop(rs.getInt("shopID"), rs.getString("user"), rs.getString("pass"),
						rs.getString("nameShop"),rs.getString("numFollower"),rs.getString("urlAvatar"));
			}
			System.out.println("Get a shop database successed!");
			connection.close();
			return shop;
		} catch (SQLException e) {
			System.out.println("Get a shop database failed!");
			e.printStackTrace();
		}
    	
		return null;
    }
    public static Shop findByUserAndPass(String user, String pass) {
    	try {
    		Connection connection=ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			ResultSet rs=stm.executeQuery(String.format("Select * from shop where user=\"%s\"AND pass=\"%s\"",user,pass));
			if(rs.next()) {
				return new Shop(rs.getInt("shopID"), rs.getString("user"), rs.getString("pass"),
						rs.getString("nameShop"),rs.getString("numFollower"), rs.getString("urlAvatar"));
			}
			System.out.println("Get a shop database successed!");
			connection.close();
		} catch (SQLException e) {
			System.out.println("Get a shop database failed!");
			e.printStackTrace();
		}
		return null;
    	
    }
}
