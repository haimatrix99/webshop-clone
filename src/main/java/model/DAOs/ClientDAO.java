package model.DAOs;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import config.ConnectionSQL;
import model.entities.Client;

public class ClientDAO {
	public static int insert(String user, String password, String money, String fullname, String birthday,
			String address, String phone) {
		try {
			Connection connection = ConnectionSQL.getConnection();
			//check exist
			Statement stm1 = connection.createStatement();
			ResultSet rs = stm1.executeQuery("Select clientID from client where user ="+"'"+ user+"'");
			while (rs.next()) {
				System.out.println("User existes!");
				return rs.getInt("clientID");
			}
			
			PreparedStatement stm2 = connection.prepareStatement(
					"Insert Into client (user,pass,money,fullname,birthday,address,phone) values(?,?,?,?,?,?,?)");
			stm2.setString(1, user);
			stm2.setString(2, password);
			stm2.setString(3, money);
			stm2.setString(4, fullname);
			stm2.setString(5, birthday);
			stm2.setString(6, address);
			stm2.setString(7, phone);
			stm2.executeUpdate();
			//insert
			Statement stm3 = connection.createStatement();
			rs = stm3.executeQuery(String.format("Select clientID from client where user =%s", user));
			while (rs.next()) {
				return rs.getInt("clientID");
			}
			stm1.close();
			stm2.close();
			stm3.close();
			connection.close();
			System.out.println("Add client into database successed!");
		} catch (SQLException e) {
			System.out.println("Add client into database failed!");
			e.printStackTrace();
		}
		return 0;
	}

	public static ArrayList<Client> findAll() {
		try {
			ArrayList<Client> clientList = new ArrayList<Client>();
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			ResultSet rs = stm.executeQuery("Select * from client");
			while (rs.next()) {
				clientList.add(new Client(rs.getInt("clientID"), rs.getString("user"), rs.getString("pass"),
						rs.getString("money"), rs.getString("fullname"), rs.getDate("birthday").toString(),
						rs.getString("address"), rs.getString("phone"), rs.getString("image"), rs.getString("role")));
			}
			System.out.println("Get client database successed!");
			connection.close();
			return clientList;
		} catch (SQLException e) {
			System.out.println("Get client database failed!");
			e.printStackTrace();
		}

		return null;
	}

	public static Client findByClientId(int clientID) {
		try {
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			ResultSet rs = stm.executeQuery(String.format("Select * from client where clientID=%d", clientID));
			System.out.println("Get client database successed!");
			if (rs.next()) {
				return new Client(rs.getInt("clientID"), rs.getString("user"), rs.getString("pass"),
						rs.getString("money"), rs.getString("fullname"), new Date(System.currentTimeMillis()).toString(),
						rs.getString("address"), rs.getString("phone"), rs.getString("image"), rs.getString("role"));
			}
			connection.close();
		} catch (SQLException e) {
			System.out.println("Get client database failed!");
			e.printStackTrace();
		}

		return null;
	}

	public static Client findByUserAndPass(String user, String pass) {
		try {
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			ResultSet rs = stm
					.executeQuery(String.format("Select * from client where user=\"%s\"AND pass=\"%s\"", user, pass));
			if (rs.next()) {
				return new Client(rs.getInt("clientID"), rs.getString("user"), rs.getString("pass"),
						rs.getString("money"), rs.getString("fullname"), rs.getDate("birthday").toString(),
						rs.getString("address"), rs.getString("phone"), rs.getString("image"), rs.getString("role"));
			}
			System.out.println("Get client database successed!");
			connection.close();
		} catch (SQLException e) {
			System.out.println("Get client database failed!");
			e.printStackTrace();
		}
		return null;
	}

	public static void updateByClientId(String user, String pass, String fullname, String birthday, String address,
			String phone, String image, int clientId) {
		try {
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			stm.executeUpdate(String.format(
					"UPDATE client SET user=\"%s\", pass=\"%s\", fullname=\"%s\", birthday=\"%s\", address=\"%s\", phone=\"%s\", image=\"%s\" WHERE clientID=%d;",
					user, pass, fullname, birthday, address, phone, image, clientId));
			connection.close();
			System.out.println("Update account in database successed!");
		} catch (SQLException e) {
			System.out.println("Update account in database failed!");
			e.printStackTrace();
		}
	}

	public static void decreaseMoneyByClientId(long money, int clientID) {
		try {
			Connection connection = ConnectionSQL.getConnection();
			Statement stm = connection.createStatement();
			stm.executeUpdate(String.format("Update client set money=money-%d WHERE clientID=%d", money, clientID));

			connection.close();
			System.out.println("Delete cart in database successed!");
		} catch (SQLException e) {
			System.out.println("Delete cart in database failed!");
			e.printStackTrace();
		}

	}
}
