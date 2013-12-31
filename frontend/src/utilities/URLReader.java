package utilities;
import java.net.*;
import java.util.ResourceBundle;
import java.io.*;

import base.Suspension_Notebook;

public class URLReader {
    public String db_ip;
	
    /**
     * Open a URL connection to an IP or URL specified in our Connection.properties file
     */
    public URLReader(){
		try {
			//get the current IP address of the db system
			URL check_ip = new URL(getURL());
			BufferedReader in = new BufferedReader(
					new InputStreamReader(check_ip.openStream()));

			String inputLine;
			if ((inputLine = in.readLine()) != null){
				//read a line from result of querying the IP specified
				if (Suspension_Notebook.DEBUG==1)System.out.println("Result was "+inputLine);
				db_ip=inputLine;
			}
			in.close();
		} catch (MalformedURLException e) {
			//if we have problems connecting etc, just default to the "localhost" as the db location
			db_ip="localhost";
		} catch (IOException e) {
			//if we have problems connecting etc, just default to the "localhost" as the db location
			db_ip="localhost";
		}		
	}

	private String getURL(){
		ResourceBundle lables = ResourceBundle.getBundle("Connection_Props");
		String result = lables.getString("CHECK_DB_IP");
		return result;
	}	
	
	
}
