package base;

import java.io.*;

import utilities.SplashScreen;
import utilities.URLReader;

/**
 * This program handles the configuration management of Suspension Settings and
 * also provides support for customer relationship management related to the business
 * of providing suspension settings.
 * 
 * @author Tom Stuckey
 *
 */
public class Suspension_Notebook {
	public static int DEBUG=0;
	public static int DEBUG2=0;
	public static int DB_LOG=0; //for logging when not connected to primary db
	public static int DB_READ_ONLY=0;
	public static URLReader outside_ref;
	public static void main(String args[])throws IOException, NumberFormatException {
		outside_ref=new URLReader();//this is to get the current ip of the remote db server from a website
		SplashScreen splashScreen=new SplashScreen("/img/logo.jpg");
		splashScreen.open (3000);
		//when the splash screen timer expires, the SplashScreen class invokes the The_Deskop
	}

}//end class Suspension_Notebook
