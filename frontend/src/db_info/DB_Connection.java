package db_info;
import java.sql.*;
import java.util.*;

import javax.swing.JDesktopPane;
import javax.swing.JOptionPane;

import base.Suspension_Notebook;
import base.The_Desktop;

public class DB_Connection {
	The_Desktop parent_desktop;
	 JDesktopPane desktop_pane;
	 public DB_UserCredentials the_user_info;
	 String DB_BASE_URL = null;
	 public String DB_HOSTNAME = null;
	 String DB_INSTANCE = null;
	 String DB_USR = null;
	 String DB_USR_PASSWD = null;
	 public Connection conn=null;
	 public DB_Calls db_calls;

	public DB_Connection(The_Desktop desktop_class,JDesktopPane desktop) {
		this.parent_desktop=desktop_class;
		this.desktop_pane=desktop;
		the_user_info=new DB_UserCredentials(this,desktop);
	}//end Connect_to_Database

	public void tryConnect(){
		The_Desktop.setCursorWait(true);
		
		String DB_URL=null;
		ResourceBundle labels = ResourceBundle.getBundle("Connection_Props");
		DB_BASE_URL = labels.getString("DB_BASE_URL");
		DB_HOSTNAME = the_user_info.user_fields.the_hostname;
		DB_INSTANCE = labels.getString("DB_INSTANCE");
		DB_USR=the_user_info.user_fields.the_username;
		DB_USR_PASSWD=the_user_info.user_fields.the_password;
		try {
			//DB_URL=DB_BASE_URL+DB_HOSTNAME+"/"+DB_INSTANCE+"?cacheResultSetMetadata=false";
			//DB_URL=DB_BASE_URL+DB_HOSTNAME+"/"+DB_INSTANCE+"?autoReconnect=true";
			DB_URL=DB_BASE_URL+DB_HOSTNAME+"/"+DB_INSTANCE;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(DB_URL, DB_USR, DB_USR_PASSWD);
			conn.setAutoCommit(true);

			//turn on logging when connected to the localhost and away from the office
			if ((the_user_info.db_logging_checkbox.isSelected())){
				Suspension_Notebook.DB_LOG=1;
			}else{
				Suspension_Notebook.DB_LOG=0;
			}
			if (the_user_info.read_only_checkbox.isSelected()){
				Suspension_Notebook.DB_READ_ONLY=1;
			}
			else{
				Suspension_Notebook.DB_READ_ONLY=0;
			}
			db_calls=new DB_Calls(conn);
			parent_desktop.connectedToDataBase(true,DB_HOSTNAME);//set the title off the main frame as "connected"
		} catch (Exception e) {
			JOptionPane.showMessageDialog(null, "Invalid Username or Password\n Please try again.", "Warning",
					JOptionPane.WARNING_MESSAGE,null);

			the_user_info=new DB_UserCredentials(this,desktop_pane);//bring up the credentials again if we fail
			System.err.println("Cannot connect to database server");
			

		}
		if (Suspension_Notebook.DEBUG==1) {
			try {
				System.out.println("Connector's autocommit status is "+conn.getAutoCommit());
			}catch (SQLException e) {
				System.err.println("Problem getting status.");
			}
		}
		The_Desktop.setCursorWait(false);
	}

}//end class Database_Connection
