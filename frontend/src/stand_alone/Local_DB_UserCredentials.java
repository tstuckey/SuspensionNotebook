package stand_alone;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.MouseEvent;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ResourceBundle;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JDesktopPane;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.event.InternalFrameEvent;
import javax.swing.event.InternalFrameListener;

import base.Suspension_Notebook;
import base.The_Desktop;

//import db_info.DB_Connection;

public class Local_DB_UserCredentials
implements ActionListener, InternalFrameListener, FocusListener {
	//DB_Connection local_db_connection;
	The_Desktop parent_desktop;
	JDesktopPane desktop_pane;   	
	public JInternalFrame local_frame;	
	JPanel Main_Panel;
	GridBagConstraints class_c;

	JTextField hostname;
	JTextField username;
	JPasswordField password;
	JButton okButton;
	JButton cancelButton;	
	UserFields user_fields;

	//	public Local_DB_UserCredentials(DB_Connection db_connection,JDesktopPane desktop) {
	public Local_DB_UserCredentials(The_Desktop desktop_class,JDesktopPane desktop) {
		//		local_db_connection=db_connection;
		this.parent_desktop=desktop_class;
		this.desktop_pane=desktop;
		initializeClassVariables();
		doDialog(Main_Panel);
		local_frame.add(Main_Panel);
		local_frame.pack();
		local_frame.setVisible(true);
		local_frame.getRootPane().setDefaultButton(okButton);//make the okButton the default button

		Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
		Dimension frameSize = local_frame.getSize();
		local_frame.setLocation((int)screenSize.width/2 - frameSize.width/2,
				(int)screenSize.height/2 - frameSize.height/2);
		local_frame.getRootPane().setDefaultButton( okButton );
		desktop.add(local_frame);
	}

	private void initializeClassVariables() {
		local_frame=new JInternalFrame("",true,true,true,true);
		local_frame.addInternalFrameListener(this);
		Main_Panel = initializeJPanel("Local Database Credentials");
		class_c = new GridBagConstraints();
		class_c.weightx = 1.0;

		class_c.anchor=GridBagConstraints.CENTER;
		class_c.gridwidth=GridBagConstraints.REMAINDER;

		hostname = new JTextField(getLocalHost(),20);
		hostname.setEditable(false);
		username = new JTextField(getLocalUser(),20);
		username.setEditable(false);
		password = new JPasswordField("",20);
		user_fields = new UserFields(null,null, null);
	}
	private String getLocalHost(){
		return "localhost";
	}
	
	private String getLocalUser(){
		return "root";
	}

	private String getMasterDB(){
		//ResourceBundle lables = ResourceBundle.getBundle("Connection_Props");
		//String result = lables.getString("DB_HOST");
		String result=Suspension_Notebook.outside_ref.db_ip;
		return result;
	}

	private String getMasterCopyUser(){
		ResourceBundle lables = ResourceBundle.getBundle("Connection_Props");
		String result = lables.getString("DB_COPY_USER");
		return result;
	}	

	private String getMasterCopyPasswd(){
		ResourceBundle lables = ResourceBundle.getBundle("Connection_Props");
		String result = lables.getString("DB_COPY_PASSWD");
		return result;
	}	
	
	public JPanel initializeJPanel(String title) {
		JPanel t_panel=new JPanel();
		t_panel.setBorder( BorderFactory.createCompoundBorder(
				BorderFactory.createTitledBorder(title),
				BorderFactory.createEmptyBorder(0,0,0,0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}

	class UserFields {
		public String the_hostname;
		public String the_username;
		public String the_password;

		public UserFields(String h, String u, String p) {
			the_hostname = h;
			the_username = u;
			the_password = p;
		}
	}


	public void doDialog(JPanel parent_panel) {
		JPanel p1=initializeJPanel("");
		JPanel p2=initializeJPanel("");
		addTextField(p1,"Hostname:",hostname,class_c,"end row");
		addTextField(p1,"User name:",username,class_c,"end row");
		addPasswordField(p1,"Password:",password,class_c,"end row");
		class_c.anchor=GridBagConstraints.SOUTHWEST;
		class_c.anchor=GridBagConstraints.CENTER;
		okButton = addButton(p2, "Ok");
		cancelButton = addButton(p2, "Cancel");

		class_c.gridwidth=GridBagConstraints.REMAINDER;
		parent_panel.add(p1,class_c);
		parent_panel.add(p2,class_c);
		okButton.setSelected(true);
	}

	private JButton addButton(Container c, String name) {
		JButton button = new JButton(name);
		button.addActionListener(this);
		button.addFocusListener(this);
		c.add(button);
		return button;
	}

	public void addTextField(JPanel t_panel, String t_label, JTextField t_field,
			GridBagConstraints c, String end_row) {
		JPanel local_panel=new JPanel();
		c.insets=new Insets(10,35,10,10);
		local_panel.add(new JLabel(t_label),c);

		c.insets=new Insets(10,0,10,35);
		if (end_row.equals("end row")) {
			c.gridwidth=GridBagConstraints.REMAINDER;
		}

		local_panel.add(t_field, c);
		t_panel.add(local_panel,c);
		c.gridwidth=1; //reset gridwidth
	}   

	public void addPasswordField(JPanel t_panel, String t_label, JPasswordField t_area,
			GridBagConstraints c, String end_row) {
		JPanel local_panel=new JPanel();

		c.insets=new Insets(10,35,10,10);
		local_panel.add(new JLabel(t_label),c);

		c.insets=new Insets(10,0,10,35);
		if (end_row.equals("end row")) {
			c.gridwidth=GridBagConstraints.REMAINDER;
		}

		local_panel.add(t_area, c);
		t_panel.add(local_panel,c);
		c.gridwidth=1; //reset gridwidth
	}   
	
	private Boolean isFormFilledOut(){
		//if any of the fields are false, popup a dialog
		//instructing the user to complete the form
		//and return false to signify the form is incomplete
		if ( user_fields.the_hostname.trim().equals("")||
		     user_fields.the_username.trim().equals("")||
		     user_fields.the_password.trim().equals("")){
			JOptionPane.showMessageDialog(null, 
					"Please make sure you've entered\n the password for your local database.", "Form Incomplete",
                    JOptionPane.WARNING_MESSAGE,null);
			return false;
		}
		     else
		    	 return true;
	}
	
	public void actionPerformed(ActionEvent e) {
		Object source = e.getSource();
		if (source == okButton) {
			user_fields.the_hostname=hostname.getText();
			user_fields.the_username = username.getText();
			user_fields.the_password = new String(password.getPassword());		
			if (!isFormFilledOut())return;
			local_frame.setVisible(false);
			local_frame.dispose();

			//OK has been pressed now verify we have MySQL on this box
			//and proceed to make a copy from the master server
			//and load it on the local server
            JOptionPane.showMessageDialog(null, "There will be three steps:\n"+
            		"\t1.Check if MySQL is loaded on the local computer\n"+
            		"\t2.Remove old info\n"+
            		"\t3.Create empty database\n"+
            		"\t4.Copy info to local database\n"
            		, "Warning",
                    JOptionPane.WARNING_MESSAGE,null);
			runMySQLScripts();
		}	
	}

	private void runMySQLScripts(){
		The_Desktop.setCursorWait(true);
		Boolean mysql_loaded=isMySQLPresent();
		if (mysql_loaded){
			Boolean drop_success=dropExistingDB();
			if (drop_success){
				Boolean create_success=createEmptyDB();
				if (create_success){
					Boolean copy_success=copyMySQLfromServer();
					if (copy_success){
						stayConnectedToMasterOrConnectToLocal();
					}//end copy success
				}//end create success
			}//end drop success
		}//end mysql loaded
		The_Desktop.setCursorWait(false);
	}

	class StreamGobbler extends Thread
	//This inner class spawns a thread which listens on either
	//stdout or stderr and outputs the results of the exec'd command
	{
		InputStream is;
		String type;
		Boolean pop_it_up=false;

		StreamGobbler(InputStream is, String type, Boolean pop_it_up)
		{
			this.is = is;
			this.type = type;
			this.pop_it_up=pop_it_up;
		}

		public void run()
		{
			try
			{
				InputStreamReader isr = new InputStreamReader(is);
				BufferedReader br = new BufferedReader(isr);
				String line=null;

				while ( (line = br.readLine()) != null){
					if (line.toLowerCase().contains("access denied")&&(pop_it_up)){
			            JOptionPane.showMessageDialog(null, "Incorrect password for local database.\n"+
			            		"Please try again.", "Warning",
			                    JOptionPane.WARNING_MESSAGE,null);
					}
					System.out.println(type + ">" + line);
				}
			} catch (IOException ioe)
			{
				ioe.printStackTrace();  
			}
		}
	}


	private boolean isMySQLPresent(){
		try {

			Runtime rt = Runtime.getRuntime();
			//String cmd="mysqladmin -hlocalhost -V;";
			String cmd="mysqladmin -h"+user_fields.the_hostname+" -V;";
			Process proc = rt.exec(cmd);

			// any error message?
			StreamGobbler errorGobbler = new StreamGobbler(proc.getErrorStream(), "ERROR", false);            

			// any output?
			StreamGobbler outputGobbler = new StreamGobbler(proc.getInputStream(), "OUTPUT",false);

			//start the threads listening on stderr and stdoutput for this exec process
			errorGobbler.start();
			outputGobbler.start();

			// wait for the process to exit before getting the process's exit value
			int exitVal = proc.waitFor();
			if (exitVal==0){
				//Everything was alright, no errors where encountered during exec
				//so let's return TRUE to signify that MySQL is present on the local box
	            JOptionPane.showMessageDialog(null, "MySQL is present.", "Step 1 of 4",
	                    JOptionPane.INFORMATION_MESSAGE,null);

				return true;
			}
			if (exitVal>0){
				//There were errors encountered during exec
				return false;
			}

		} catch (Exception e) {
			//An exception is thrown if the system cannot find the cmd specified
            JOptionPane.showMessageDialog(null, "Please install MySQL on this laptop and \nrun this utility again.", "Warning",
                    JOptionPane.WARNING_MESSAGE,null);
		}
	return false;
	}

	private boolean dropExistingDB(){
		try {

			Runtime rt = Runtime.getRuntime();
			/*forcefully and silently drop the existing local copy of the Suspension Notebook*/
			//String cmd="mysqladmin -uusername -ppasswd -hlocalhost -f drop suspension";
			String cmd="mysqladmin -u"+user_fields.the_username+
			                     " -p"+user_fields.the_password+
			                     " -h"+user_fields.the_hostname+
			                     " -f drop suspension";
			Process proc = rt.exec(cmd);

			// any error message?
			StreamGobbler errorGobbler = new StreamGobbler(proc.getErrorStream(), "ERROR",false);            

			// any output?
			StreamGobbler outputGobbler = new StreamGobbler(proc.getInputStream(), "OUTPUT",false);

			//start the threads listening on stderr and stdoutput for this exec process
			errorGobbler.start();
			outputGobbler.start();

			// wait for the process to exit before getting the process's exit value
			int exitVal = proc.waitFor();
			if (exitVal==0){
				//Everything was alright, no errors where encountered during exec
				//so let's return TRUE to signify that MySQL is present on the local box
	            JOptionPane.showMessageDialog(null, "Successfully removed old info.", "Step 2 of 4",
	                    JOptionPane.INFORMATION_MESSAGE,null);
				return true;
				
			}
			if (exitVal==1){
				//The drop command failed because the local db didn't exist
				//This isn't a problem because we are getting ready to create what we need
				//This is just so we start from a clean slate if there was a db already on the localhost
	            //so let's return TRUE
	            return true;
			}

			if (exitVal>1){
				//There were errors encountered during exec
	            JOptionPane.showMessageDialog(null, "Problems encountered during db drop.", "Warning",
	                    JOptionPane.WARNING_MESSAGE,null);
	            return false;
			}

		} catch (Exception e) {
			//An exception is thrown if the system cannot find the cmd specified
            JOptionPane.showMessageDialog(null, "Please install MySQL on this laptop and \nrun this utility again.", "Warning",
                    JOptionPane.WARNING_MESSAGE,null);
		}
		return false;
	}

	private boolean createEmptyDB(){
		try {

			Runtime rt = Runtime.getRuntime();
			/*create the suspension db on the localhost*/
			//String cmd="mysqladmin -uusername -ppasswd -hlocalhost create suspension";
			String cmd="mysqladmin -u"+user_fields.the_username+
            					 " -p"+user_fields.the_password+
            					 " -h"+user_fields.the_hostname+
            					 " -f create suspension";
			Process proc = rt.exec(cmd);

			// any error message?
			StreamGobbler errorGobbler = new StreamGobbler(proc.getErrorStream(), "ERROR", true);            

			// any output?--we don't want to log the output from the mysqldump
			StreamGobbler outputGobbler = new StreamGobbler(proc.getInputStream(), "OUTPUT", true);

			//start the threads listening on stderr and stdoutput for this exec process
			errorGobbler.start();
			outputGobbler.start();

			// wait for the process to exit before getting the process's exit value
			int exitVal = proc.waitFor();
			if (exitVal==0){
				//Everything was alright, no errors where encountered during exec
				//so let's return TRUE to signify that MySQL is present on the local box
	            JOptionPane.showMessageDialog(null, "Successfully created empty database.", "Step 3 of 4",
	                    JOptionPane.INFORMATION_MESSAGE,null);
				return true;
			}
			if (exitVal>0){
				//There were errors encountered during exec
	            JOptionPane.showMessageDialog(null, "Problems encountered during db creation.", "Warning",
	                    JOptionPane.WARNING_MESSAGE,null);
	            return false;
			}

		} catch (Exception e) {
			//An exception is thrown if the system cannot find the cmd specified
            JOptionPane.showMessageDialog(null, "Please install MySQL on this laptop and \nrun this utility again.", "Warning",
                    JOptionPane.WARNING_MESSAGE,null);
			//t.printStackTrace();
		}
		return false;
	}	
	
	private boolean copyMySQLfromServer(){
		try {

			Runtime rt = Runtime.getRuntime();
			//String cmd="mysqldump  -umake_copy -p!going_testing -h72.211.177.88 --opt --routines --compress suspension| mysql -u'username' -p'passwd' -hlocalhost suspension";
			//The following command array is for a Windows box cmd /c 'the_command'
			//opens the cmd shell, executes 'the_command' and exits
			//
			//For a Unix platform, it would need to be replaced with /bin/sh -c
			String[] cmd={"cmd", "/c",
							"mysqldump -u"+getMasterCopyUser()+
			 					 " -p"+getMasterCopyPasswd()+
			 					 " -h"+getMasterDB()+
			 					 " --opt --routines --compress suspension | "+
			 		        "mysql -u"+user_fields.the_username+
			 				 	 " -p"+user_fields.the_password+
			 				 	 " -h"+user_fields.the_hostname+
			 				 	 " suspension"};
			
			Process proc = rt.exec(cmd);

			// any error message?
			StreamGobbler errorGobbler = new StreamGobbler(proc.getErrorStream(), "ERROR", true);            

			// any output?--we don't want to log the output from the mysqldump
			//StreamGobbler outputGobbler = new StreamGobbler(proc.getInputStream(), "OUTPUT");

			//start the threads listening on stderr and stdoutput for this exec process
			errorGobbler.start();
			//outputGobbler.start(); //we don't want to log the output for the mysqldump

			// wait for the process to exit before getting the process's exit value
			int exitVal = proc.waitFor();
			if (exitVal==0){
				//Everything was alright, no errors where encountered during exec
				//so let's return TRUE to signify that MySQL is present on the local box
	            JOptionPane.showMessageDialog(null, "Successfully copied to local database.\n You're ready to go!", "Step 4 of 4",
	                    JOptionPane.INFORMATION_MESSAGE,null);
				return true;
				
			}
			if (exitVal>0){
				//There were errors encountered during exec
	            JOptionPane.showMessageDialog(null, "Problems encountered during copy routine.", "Warning",
	                    JOptionPane.WARNING_MESSAGE,null);
	            return false;
			}

		} catch (Exception e) {
			//An exception is thrown if the system cannot find the cmd specified
            JOptionPane.showMessageDialog(null, "Please install MySQL on this laptop and \nrun this utility again.", "Warning",
                    JOptionPane.WARNING_MESSAGE,null);
			//t.printStackTrace();
		}
		return false;
	}
	
	private void stayConnectedToMasterOrConnectToLocal(){
		Object[] options = {"Stay Connected to Master",
							"Disconnect"};
		int result = JOptionPane.showOptionDialog(null,
				"Connection Options",
				"Question",
				JOptionPane.YES_NO_CANCEL_OPTION,
				JOptionPane.QUESTION_MESSAGE,
				null,
				options,
				options[1]);

		//Handle all three options
		switch (result){
		//0=stay connected to same db
		case 0:  parent_desktop.findSettings();
				 break;
		//1=end this connection
		case 1:  parent_desktop.connectedToDataBase(false, "");
				 break;
		//default=stay connected to same db
		default: parent_desktop.findSettings();//
				 break;
		}
	}
	
	public void internalFrameClosing(InternalFrameEvent e) {
	}

	public void internalFrameClosed(InternalFrameEvent e) {
	}

	public void internalFrameOpened(InternalFrameEvent e) {
	}

	public void internalFrameIconified(InternalFrameEvent e) {
	}

	public void internalFrameDeiconified(InternalFrameEvent e) {
	}

	public void internalFrameActivated(InternalFrameEvent e) {
	}

	public void internalFrameDeactivated(InternalFrameEvent e) {
	}

	public void focusGained(FocusEvent e) {
	}

	public void focusLost(FocusEvent e) {
	}

	public void mouseDragged(MouseEvent arg0) {
	}

	public void mouseMoved(MouseEvent e) {
	}




}