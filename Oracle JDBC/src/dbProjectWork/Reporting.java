package dbProjectWork;
import java.lang.Integer;

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
			// Show the menue for arguments
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
		db.whoIs();
		System.out.println("Your argument is: "+ Integer.toString(decision));

	}

}
