package base;

import javax.swing.JFrame;
import javax.swing.JDesktopPane;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JMenuBar;
import javax.swing.JOptionPane;
import javax.swing.UIManager;
import javax.swing.plaf.BorderUIResource;
import stand_alone.Local_DB_UserCredentials;
import utilities.Help_Frame;
import db_info.DB_Connection;
import find_routines.Find_Settings_Frame;
import java.awt.event.*;
import java.awt.*;
import java.sql.*;

public class The_Desktop extends JFrame implements ActionListener {
    static JDesktopPane desktop;
    
    public DB_Connection active_db_connection;
    public Find_Settings_Frame find_frame;
    public Local_DB_UserCredentials stand_alone_credentials;
    
    public JMenuBar menuBar;
    public JMenu file_menu;
    public JMenu add_menu;
    public JMenu work_order_menu;
    public JMenu connect_menu;
    public JMenu utilities_menu;
    public JMenu help_menu;
    
    public The_Desktop() {
    	
        //Make the big window be indented 50 pixels from each edge
        //of the screen.
        int inset = 50;
        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        setBounds(inset, inset,
                screenSize.width  - inset*2,
                screenSize.height - inset*2);
        
        //Set up the GUI.
        desktop = new JDesktopPane(); //a specialized layered pane
        this.setContentPane(desktop);
        this.setJMenuBar(createMenuBar());
        
        desktop.setDragMode(JDesktopPane.LIVE_DRAG_MODE);
		
        //Make the selected cell border black instead of the default blue
		UIManager.put("Table.focusCellHighlightBorder", new BorderUIResource.LineBorderUIResource(Color.black));
		//Make the text for the comboxes black even when they are disabled
		UIManager.put("ComboBox.disabledForeground", Color.black);
        
		connectedToDataBase(false,"");
		createDBConnection();
		new Active_Work_GUIs(active_db_connection);
		menuBar.setVisible(true);
		
		
    }

    public void connectedToDataBase(Boolean connected, String hostname){
       	if (connected){
       		this.setTitle("Suspension Notebook--CONNECTED to "+hostname);
       		makeMenusVisible("full");
       		findSettings();//invoke the find interface as soon as the user is connected
       	}
    	else {
    		this.setTitle("Suspension Notebook--DISCONNECTED");
    		makeMenusVisible("partial");
    		active_db_connection=null;//this ends any current db connection
    	}
    }
    
    public void makeMenusVisible(String amount){
      	if (amount.equals("full")){
    		file_menu.setEnabled(true);
    		add_menu.setEnabled(true);
    		work_order_menu.setEnabled(true);
    		connect_menu.setEnabled(true);
    		utilities_menu.setEnabled(true);
    		help_menu.setEnabled(true);
    	}
    	if (amount.equals("partial")){
    		file_menu.setEnabled(true);
    		add_menu.setEnabled(false);
    		work_order_menu.setEnabled(false);
    		connect_menu.setEnabled(true);
    		utilities_menu.setEnabled(false);
    		help_menu.setEnabled(false);
    	}

    }
    
    protected JMenuBar createMenuBar() {
        menuBar = new JMenuBar();
        
        //Set up the File menu.
        file_menu=addToMenuBar(menuBar, "File", KeyEvent.VK_F);
        addToMenu(file_menu, "Quit","quit");
        
        //Set up the Add menu.
        add_menu=addToMenuBar(menuBar, "Add", KeyEvent.VK_A);
        addToMenu(add_menu, "Customer", "add customer");
        addToMenu(add_menu, "Bike Model", "add bike");
        
        //Set up the Find menu.
        work_order_menu=addToMenuBar(menuBar, "Work Orders", KeyEvent.VK_W);
        addToMenu(work_order_menu, "New Work Order", "new order");
        addToMenu(work_order_menu, "Search Work Orders","search orders");
        
        //Set up the Connect menu
        connect_menu=addToMenuBar(menuBar, "Connect", KeyEvent.VK_C);
        addToMenu(connect_menu, "Change Database", "change database");
        addToMenu(connect_menu, "Disconnect from Database", "disconnect database");
        
        //Set up the Stand Alone menu.
        utilities_menu=addToMenuBar(menuBar, "Utilities", KeyEvent.VK_U);
        addToMenu(utilities_menu, "Copy DB to Local Computer","make stand alone");

        
        //Set up the Help menu.
        help_menu=addToMenuBar(menuBar, "Help", KeyEvent.VK_H);
        addToMenu(help_menu, "Version", "version");
        addToMenu(help_menu, "Clear Open Work Orders", "clear_work_orders");
        return menuBar;
    }
    
    private JMenu addToMenuBar(JMenuBar menuBar, String title, int t_event) {
        JMenu t_menu = new JMenu(title);
        t_menu.setMnemonic(t_event);
        menuBar.add(t_menu);
        return t_menu;
    }
    
    private void addToMenu(JMenu t_menu, String title, String act_cmd) {
        //This method creates a menuItem with "title" adds it to the t_menu
        JMenuItem menuItem = new JMenuItem(title);
        menuItem.setActionCommand(act_cmd);
        menuItem.addActionListener(this);
        t_menu.add(menuItem);
    }
    
    //React to menu selections.
    public void actionPerformed(ActionEvent e) {
        String cmd=e.getActionCommand();
        if (cmd.equals("new order")) {
            brandNew();
        }
        if (cmd.equals("search orders")) {
            findSettings();
        }
        if (cmd.startsWith("add")) {
            addElementFrame(e.getActionCommand());
        }
        if (cmd.equals("quit")) {
            System.exit(0);
        }
        
        if (cmd.equals("change database")) {
        	createDBConnection();
        }
        if (cmd.equals("disconnect database")) {
        	disConnectDBConnection();
        }
        
        if (cmd.equals("make stand alone")) {
        	doStandAlone();
        }
        if (cmd.equals("version")) {
        	helpFrame();
        }
        if (cmd.equals("clear_work_orders")) {
        	clearOpenWorkOrders();
        }
    }
    
    public Integer generateWorkOrderID() {
        //This method gets a new work_order_id from the database
        ResultSet rs=null;
        rs=active_db_connection.db_calls.createNewWorkOrder();
        
        Integer new_work_order_id=0;
        try {
            if (rs.first()) {
                new_work_order_id=rs.getInt("New ID");
            }
        }catch (SQLException e) {
            System.err.println("Setup_Desktop:  Problem creating new work_order.");
            e.printStackTrace();
        }
        
        return new_work_order_id;
    }
    
    
    //Create a new internal frame.
    protected void brandNew() {
        //create a new Settings_Frame with a newly generated work_order_id
    	setCursorWait(true); 
    	if (find_frame.isVisible()){
    		find_frame.dispose();
    	}
    	    		
    	Integer new_work_order=generateWorkOrderID();
    	Settings_Frame settings_frame = new Settings_Frame(new_work_order,true,desktop, active_db_connection);
        settings_frame.setVisible(true);
        desktop.add(settings_frame);
        Active_Work_GUIs.active_settings_frames.add(settings_frame);
        active_db_connection.db_calls.insertOpenWorkOrder(new_work_order);
        try {
            settings_frame.setSelected(true);
        } catch (java.beans.PropertyVetoException e) {}
        setCursorWait(false); 
    }

    protected void helpFrame() {
        //create a new Frame for the help info
        Help_Frame help_frame = new Help_Frame(desktop);
    	help_frame.setVisible(true);
        desktop.add(help_frame);
        try {
        	help_frame.setSelected(true);
        } catch (java.beans.PropertyVetoException e) {}
    }    

    private void clearOpenWorkOrders() {
		Object stringArray2[] = { "Clear Open Work Orders","Cancel" };
		Integer clear_result=JOptionPane.showOptionDialog(null, null, "Are You Sure?",
				JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE, null, stringArray2,
				stringArray2[0]);
		
		//increment the revision on both
		if (clear_result==0){
			active_db_connection.db_calls.clearOpenWorkOrders();
		}
		
		//increment the revision on shock only
		if (clear_result==1){
		    return;//exit out of this method			
		}
    }    

    public void closeIntroFrames(){
    	if ((find_frame!=null)&&(find_frame.isVisible())){
    		find_frame.dispose();
    	}
    	
    	if ((stand_alone_credentials!=null)&&(stand_alone_credentials.local_frame.isVisible())){
    		stand_alone_credentials.local_frame.dispose();
    	}
    	
    	if ((active_db_connection!=null)&&(active_db_connection.the_user_info.local_frame.isVisible())){
    		active_db_connection.the_user_info.local_frame.dispose();
    	}
    	
    }    

    public void createDBConnection(){
    	closeIntroFrames();

    	//check to see if there is an active DB connection
    	//if there is one active, check with the user to see if they really want to change
    	//if they do, close the existing connection and prompt for the new connection
    	if (active_db_connection !=null){
    		Object stringArray2[] = { "Change","Stay Connected" };
    		Integer result=JOptionPane.showOptionDialog(null, null, "You are already connected.\n"+
    				"Do you want to CHANGE your connection?",
    				JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE, null, stringArray2,
    				stringArray2[0]);
    		if (result==0){
    			//the user wants to change, so first close the existing connection
    			try {
    				if(active_db_connection.conn!=null)active_db_connection.conn.close();
    				active_db_connection=null;
    				this.connectedToDataBase(false, "");
    				//we're done closing the connection, we drop out of this if bundle and
    				//create our new DB_Connection
    			} catch (SQLException e) {
    				System.out.println("Problem encountered closing the connection");
    				//e.printStackTrace();
    			}
    		}
    		if (result==1){
    			//the user wants to stay connected, so just return
    			return;
    		}

    	}
    	active_db_connection=new DB_Connection(this,desktop);
    }

    public void disConnectDBConnection(){
    	//Terminate any active DBConnection
    	Object stringArray2[] = { "Disconnect","Stay Connected" };
    	Integer result=JOptionPane.showOptionDialog(null, null, "Do You Want To Disconnect?",
    			JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE, null, stringArray2,
    			stringArray2[0]);

    	if (result==0){
    		//the user really wants to disconnect, so do the following
    		//First check to see if there are any Active_Guis
    		//if there are any, prompt the user to close any open settings first
    		if(Active_Work_GUIs.active_settings_frames.size()>0){
    			JOptionPane.showMessageDialog(null, "Close all open work orders first.", "Warning",
    					JOptionPane.WARNING_MESSAGE,null);
    			return;
    		}

    		closeIntroFrames();
    		try {
    			if ((active_db_connection!=null)&&(active_db_connection.conn !=null))active_db_connection.conn.close();
    			active_db_connection=null;
    			this.connectedToDataBase(false, "");
    		} catch (SQLException e) {
    			System.out.println("Problem encountered closing the connection");
    			//e.printStackTrace();
    		}
    	}
    	if (result==1){
    		//the user wants to stay connected, so just return
    		return;
    	}


    }
    
    public void findSettings() {
    	setCursorWait(true); 
    	closeIntroFrames();

    	find_frame = new Find_Settings_Frame(desktop,active_db_connection);
        find_frame.setVisible(true);
        desktop.add(find_frame);
        
        try {
            find_frame.setSelected(true);
        } catch (java.beans.PropertyVetoException e) {}
        setCursorWait(false); 
    }

 
    protected void doStandAlone() {
    	setCursorWait(true); 
    	closeIntroFrames();
    	if (active_db_connection==null){
            JOptionPane.showMessageDialog(null, "Need to connect to a Database first.", "Warning",
                    JOptionPane.WARNING_MESSAGE,null);
            setCursorWait(false); 
            return;
    	}
    	
    	if ((active_db_connection.DB_HOSTNAME.toLowerCase().contains("localhost"))||
    		(active_db_connection.DB_HOSTNAME.toLowerCase().contains("127.0.0.1"))	){
            JOptionPane.showMessageDialog(null, "Can't copy from local database; connect to Master first.", "Warning",
                    JOptionPane.WARNING_MESSAGE,null);
            setCursorWait(false); 
            return;
    	}
    	stand_alone_credentials = new Local_DB_UserCredentials(this,desktop);
        try {
        	stand_alone_credentials.local_frame.setSelected(true);
        } catch (java.beans.PropertyVetoException e) {}
    	setCursorWait(false); 
    }

    protected void addElementFrame(String cmd) {
    	setCursorWait(true); 
    	Add_Element_Frame frame = new Add_Element_Frame(cmd, active_db_connection);
        frame.setVisible(true);
        desktop.add(frame);
        
        try {
            frame.setSelected(true);
        } catch (java.beans.PropertyVetoException e) {}
        setCursorWait(false);
    }
    
    public static void setCursorWait(Boolean state){
    	if (state)
    	desktop.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
    	else
    		desktop.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR)); 
    }

    private static void createAndShowGUI() {
        //Make sure we have nice window decorations.
        JFrame.setDefaultLookAndFeelDecorated(true);
        //Create and set up the window.
        The_Desktop setupDesktop = new The_Desktop();
        setupDesktop.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        setupDesktop.addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(WindowEvent winEvt) {
                //Close out any settings frames that were open
                Active_Work_GUIs.removeAllWorkOrders();
            	System.exit(0); 
            }
        });  
        
        //Display the window.
        setupDesktop.setVisible(true);
    }
    
    public static void Draw_Page() {
        //Schedule a job for the event-dispatching thread:
        //creating and showing this application's GUI.
    	javax.swing.SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                createAndShowGUI();
            }
        });
    }
}
