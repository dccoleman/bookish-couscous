package dbProjectWork;

public class Reporting {
	/*
	 * TO RUN FROM COMMAND LINE: 
	 * - Need to be in the containing package: Oracle JDBC/Bin/dbProjectWork
	 * - Run with: Java -cp . dbProjectWork/Reporting Username Password
	 * 
	 * 
	 */
	public static void main(String[] args) {
		int count = args.length;
		if (count != 2){
			System.out.println("Please input only the Username and Password to the SQL Account");
			System.exit(1);
		}
		System.out.println("System Initilizing...");
		Database db = new Database(args[0], args[1]);
		db.whoIs();

	}

}
