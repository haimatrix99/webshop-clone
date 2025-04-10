package model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import config.ConnectionSQL;
import model.entities.Comment;

public class CommentDAO {
	public static ArrayList<Comment> findByProductID(int productID) {
		ArrayList<Comment>  commentList=new ArrayList<Comment>();
		Connection connection=ConnectionSQL.getConnection();
		Statement stm;
		try {
			stm = connection.createStatement();
			ResultSet rs=stm.executeQuery(String.format("Select * from comment where product_productID=%d",productID));
			while (rs.next()) {
				commentList.add(new Comment(rs.getInt("commentID"), rs.getString("comment"), rs.getString("date"),
						rs.getInt("client_clientID"),rs.getInt("product_productID")));
			}
			connection.close();
			return commentList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return commentList;
		
	}
    public static void insert(String comment,int clientId, int productId) {
    	try {
    		Connection connection= ConnectionSQL.getConnection();
    		PreparedStatement stm=connection.prepareStatement("Insert Into comment (comment,client_clientID,product_productID,date) values(?,?,?,NOW())");
			stm.setString(1, comment);
			stm.setInt(2, clientId);
			stm.setInt(3, productId);
    		stm.executeUpdate();
			connection.close();
			stm.close();
			System.out.println("Add a Comment into database successed!");
		} catch (SQLException e) {
			System.out.println("Add a Comment into database failed!");
			e.printStackTrace();
		}
    }
}
