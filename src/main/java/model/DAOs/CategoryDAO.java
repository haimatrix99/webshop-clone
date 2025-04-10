package model.DAOs;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import config.ConnectionSQL;
import model.entities.Category;

public class CategoryDAO {
    public static String findByCategoryId(int categoryID) {
    	try {
    		String name=null;
    		Connection connection=ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			ResultSet rs=stm.executeQuery(String.format("Select (nameCategory) from category where categoryID=%d",categoryID));
			if (rs.next()) {
				name= rs.getString("nameCategory");
			}
			System.out.println("Get Category database successed!");
			connection.close();
			return name;
		} catch (SQLException e) {
			System.out.println("Get Category database failed!");
			e.printStackTrace();
		}
		return null;
    }
    public static ArrayList<Category> findAll() {
    	try {
    		ArrayList<Category> categoryList=new ArrayList<Category>();
    		Connection connection=ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			ResultSet rs=stm.executeQuery(String.format("Select * from category"));
			while (rs.next()) {
				categoryList.add(new Category(rs.getInt("categoryID"),rs.getString("nameCategory")));
			}
			System.out.println("Get categories database successed!");
			connection.close();
			return categoryList;
		} catch (SQLException e) {
			System.out.println("Get categories database failed!");
			e.printStackTrace();
		}
		return null;
    }
}
