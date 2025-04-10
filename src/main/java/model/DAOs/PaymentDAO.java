package model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import config.ConnectionSQL;
import model.entities.Payment;
import model.entities.Product;

public class PaymentDAO {
	public static ArrayList<Payment> findAll() {
		ArrayList<Payment> paymentList=new ArrayList<Payment>();
		Connection connection=ConnectionSQL.getConnection();
		Statement stm;
		try {
			stm = connection.createStatement();
			ResultSet rs=stm.executeQuery("Select * from payment");
			while (rs.next()) {
				paymentList.add(new Payment(rs.getInt("paymentID"), rs.getString("cardholderName"), rs.getString("nameAccount"),
						rs.getInt("status"), rs.getInt("clientID"),rs.getString("money")));
			}
			connection.close();
			return paymentList;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return paymentList;
		
	}
    public static void insert(String cardholderName,String nameAccount, String status, int clientId, String money) {
    	try {
    		Connection connection= ConnectionSQL.getConnection();
    		PreparedStatement stm=connection.prepareStatement("Insert Into payment (cardholderName,nameAccount,status,clientID,money) values(?,?,?,?,?)");
			stm.setString(1, cardholderName);
			stm.setString(2, nameAccount);
			stm.setString(3, status);
			stm.setInt(4, clientId);
			stm.setString(5, money);
    		stm.executeUpdate();
			connection.close();
			stm.close();
			System.out.println("Add a payment into database successed!");
		} catch (SQLException e) {
			System.out.println("Add a payment into database failed!");
			e.printStackTrace();
		}
    }
    public static void updateStatusByPaymentId(int paymentID,String status) {
    	try {
    		Connection connection= ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
    		stm.executeUpdate(String.format("UPDATE payment SET status=%s WHERE paymentID=%d",status,paymentID));
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    public static void deleteByPaymentId(int paymentID) {
    	try {
    		Connection connection= ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
    		stm.executeUpdate(String.format("DELETE FROM payment WHERE paymentID=%d;",paymentID));
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    public static void updatePaymentsMoney() {
    	try {
    		Connection connection= ConnectionSQL.getConnection();
			Statement stm=connection.createStatement();
			ResultSet rs=stm.executeQuery(String.format("SELECT paymentID,clientID,money,status FROM payment WHERE status!=%d;",0));
			while(rs.next()) {
				stm=connection.createStatement();
				if(rs.getInt("status")==1) {
				stm=connection.createStatement();
				stm.executeUpdate(String.format("Update client set money=money+%d WHERE clientID=%d",Integer.parseInt(Product.form(rs.getString("money"))),rs.getInt("clientID")));
				stm=connection.createStatement();
				stm.executeUpdate(String.format("DELETE FROM payment WHERE paymentID=%d;",rs.getInt("paymentID")));
				}
				else {
					stm=connection.createStatement();
					stm.executeUpdate(String.format("DELETE FROM payment WHERE paymentID=%d;",rs.getInt("paymentID")));
				}
			}
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
}
