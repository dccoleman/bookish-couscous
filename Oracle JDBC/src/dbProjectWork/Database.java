package dbProjectWork;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.sql.*;

public class Database {
	public String username;
	public String password;
	Connection connection;
	
	// Connection data here:
	
	public Database(String username, String password){
		this.username = username;
		this.password = password;
		// Connect to the database
		try {
			System.out.println("Connecting");
			 connection = DriverManager.getConnection(
			 		"jdbc:oracle:thin:@oracle.wpi.edu:1521:WPI11grxx", username, password);
		} catch (SQLException e) {
			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			return;
		}
		
	}
	
	public void whoIs(){
		System.out.println("Username: "+this.username+" Password "+this.password);
	}
	
	public ResultSet query(String query) {
		ResultSet rset = null;
		try {
			Statement stmt = connection.createStatement();
			rset = stmt.executeQuery(query);
		} catch (SQLException e) {
			System.out.println("Get Data Failed! Check output console");
			e.printStackTrace();
		}
		return rset;
	}

}
