package dbProjectWork;
import java.lang.Integer;
import java.sql.*;
import java.util.Scanner;

public class Reporting {
	/*
	 * TO RUN FROM COMMAND LINE: 
	 * - Need to be in the containing package: Oracle JDBC/Bin/dbProjectWork
	 * - Run with: Java -cp . dbProjectWork/Reporting Username Password integer for argument
	 * 
	 * 
	 */
	public static void main(String[] args) {
		int count = args.length;
		Integer decision = new Integer(-1);
		// Args should be : <Username> <Password> <Integer between 1 and 4>
		if (count < 2 || count > 3){
			System.out.println("Please input <Username> <Password> <Integer between 1 and 4>");
			System.exit(1);
		}
		if (count == 2){
			// Show the menu for arguments
			System.out.println("1 -- Report Customer Information");
			System.out.println("2 -- Report Tour Guide Information");
			System.out.println("3 -- Report Booked Tour Information");
			System.out.println("4 -- Update Booked Tour Vehicle");
			System.exit(1);
		}
		try {
			// Convert the argument
			decision = Integer.parseInt(args[2]);
			
			// If the argument is outside the argument range
			if (decision < 1 || decision > 4){
				System.out.println("Decision argument should be between 1 and 4");
				System.exit(1);
			}
		} catch (NumberFormatException e){
			// Error if it's not an integer
			System.out.println("Third Argument should be an Integer");
			System.exit(1);
		}
		
		
		System.out.println("System Initilizing...");
		Database db = new Database(args[0], args[1]);
		//db.whoIs();
		//System.out.println("Your argument is: "+ decision);
		switch (decision) {
		case 1:
			try {
				System.out.println("Enter Customer ID: ");
				Scanner scan = new Scanner(System.in);
				int i = scan.nextInt();
				//System.out.println("SELECT * FROM CUSTOMER WHERE customerID = " + Integer.toString(i));
				ResultSet rset = db.query("SELECT * FROM CUSTOMER WHERE customerID = " + Integer.toString(i));
				
				//Setting up dummy variables
				int custID = 0;
				String firstName = "";
				String lastName = "";
				String address = "";
				long phone = 0;
				int age = 0;
				
				while (rset.next() && rset != null) {
					custID = rset.getInt("customerID");
					firstName = rset.getString("firstname");
					lastName = rset.getString("lastname");
					address = rset.getString("address");
					age = rset.getInt("age");
					phone = rset.getLong("phone");
					System.out.println("ID: " + custID + "   Name: " + firstName + " " + lastName + "   Address: " + address + "   Phone Number: " + phone + "   Age: " + age);
				} // end while
			} catch (SQLException e) {
				System.out.println("Get Data Failed! Check output console");
				e.printStackTrace();
				return;			
			}
			
			break;
		case 2:
			try {
				System.out.println("Enter Tour Guide Driver License ");
				Scanner scan = new Scanner(System.in);
				long i = scan.nextLong();
				//System.out.println("SELECT * FROM GUIDE WHERE DriverLicense = " + Integer.toString(i));
				ResultSet rset = db.query("SELECT * FROM GUIDE WHERE DriverLicense = " + Long.toString(i));
				
				//Setting up dummy variables
				long driversLicense = 0;
				String firstName = "";
				String lastName = "";
				String title = "";
				String vType = "";
				
				while (rset.next() && rset != null) {
					driversLicense = rset.getLong("DriverLicense");
					firstName = rset.getString("firstname");
					lastName = rset.getString("lastname");
					title = rset.getString("Title");
					vType = rset.getString("VehicleType");

					System.out.println("Drivers License: " + driversLicense + "   Name: " + firstName + " " + lastName + "   Title: " + title + "   Vehicle Type: " + vType);
				} // end while
			} catch (SQLException e) {
				System.out.println("Get Data Failed! Check output console");
				e.printStackTrace();
				return;			
			}
			
			break;
		case 3:
			try {
				System.out.println("Enter Booked Tour ID: ");
				Scanner scan = new Scanner(System.in);
				long i = scan.nextLong();
				ResultSet rset = db.query("SELECT * FROM BookedTour_AD WHERE BookedTourID = " + Long.toString(i));
				//ResultSet travelingRset = db.query("Add query here");
				int custID = 0,bookedTourID = 0,licensePlate = 0;
				String custFirstName = "", custLastName = "", guideFirstName = "", guideLastName = "", tourName = "";
				String purchaseDate = "",travelDate = "";
				int age = 0;
				int totalPrice = 0;
				
				while (rset.next() && rset != null) {
					custID = rset.getInt("customerID");
					bookedTourID = rset.getInt("bookedtourid");
					custFirstName = rset.getString("Customerfirstname");
					custLastName = rset.getString("customerlastname");
					guideFirstName = rset.getString("guidefirstname");
					guideLastName = rset.getString("guideLastName");
					tourName = rset.getString("TourName");
					totalPrice = rset.getInt("totalprice");
					age = rset.getInt("customerAge");
					purchaseDate = rset.getString("PurchaseDate");
					travelDate = rset.getString("TravelDate");
					licensePlate = rset.getInt("LicensePlate");
					
					System.out.println("Booked Tour ID: " +  bookedTourID);
					System.out.println("Customer Name: " + custFirstName + " " + custLastName);
					System.out.println("Customer Age: " + age);
					System.out.println("People Traveling With: ");
					ResultSet secondRes = db.query("SELECT firstname,lastname,age FROM customer c, (SELECT travelingwithid FROM travelingwith WHERE customerid = "+ custID +") t WHERE c.customerid = t.travelingwithid");
					
					//Setting up dummy variables
					String secondaryFirstName = "";
					String secondarylastName = "";
					int cage = 0;
					
					while (secondRes.next() && secondRes != null) {
						secondaryFirstName = secondRes.getString("firstname");
						secondarylastName = secondRes.getString("lastname");
						cage = secondRes.getInt("age");
						System.out.println("	Name: " + secondaryFirstName + " " + secondarylastName + " " + cage);
						
					} // end while
					
					System.out.println("Tour Name: " + tourName);
					System.out.println("Purchase Date: " + purchaseDate);
					System.out.println("Travel Date: " + travelDate);
					System.out.println("Tour Guide Name: " + guideFirstName + " " + guideLastName);
					System.out.println("License Plate: " + licensePlate);
					System.out.println("Total Price: " + totalPrice);
				} // end whi
			} catch (SQLException e) {
				System.out.println("Get Data Failed! Check output console");
				e.printStackTrace();
				return;			
			}
			
			break;
		case 4:
			System.out.println("Update Booked Tour Vehicle");
			break;
			
		}
		System.out.println("Ending");

	}

}
