package config;

import java.sql.*;

public class ConnectionSQL {
    private static String getEnvOrDefault(String name, String defaultValue) {
        String value = System.getenv(name);
        return value != null ? value : defaultValue;
    }
    
    private static String host = getEnvOrDefault("DB_HOST", "localhost");
    private static String port = getEnvOrDefault("DB_PORT", "3306");
    private static String dbName = getEnvOrDefault("DB_NAME", "webshop");
    private static String user = getEnvOrDefault("DB_USER", "root");
    private static String password = getEnvOrDefault("DB_PASSWORD", "");
    private static String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName;
    
    public static Connection getConnection() {
    	Connection connection = null;
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	connection = DriverManager.getConnection(url, user, password);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        if(connection==null) System.out.println("Connect failed!");

        return connection;
    }
//    public static void main(String[] args) {
//        System.out.println(getConnection());
//    }
}
