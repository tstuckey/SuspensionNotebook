package base;

import javax.swing.JDesktopPane;
import javax.swing.JInternalFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JButton;
import javax.swing.BorderFactory;
import javax.swing.JOptionPane;
import javax.swing.event.*;

import utilities.PrintDialogInternalFrame;
import utilities.PrintStructure;

import db_info.DB_Connection;

import java.awt.event.*;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import java.awt.*;
import java.sql.*;
import java.util.Vector;

/* Used by Setup_Desktop.java. */
public class Settings_Frame extends JInternalFrame implements ActionListener,
		InternalFrameListener {
	static final int xOffset = 10, yOffset = 10;
	static int openFrameCount = 0;
	JDesktopPane local_desktop;
	JInternalFrame local_frame;
	JScrollPane areaScrollPane;
	JPanel Main_Panel;
	GridBagConstraints class_c;

	PrintStructure printing_choices;
	JButton edit_button;
	JButton save_button;
	JButton cancel_button;
	JButton print_button;

	JButton set_from_button;
	JButton set_to_button;

	Active_Work_Order current_work_order; // the active work_order for this frame
	All_Info all_info;

	DB_Connection active_db_connection;
	public Settings_Frame(Integer in_work_order, Boolean editable,
			JDesktopPane desktop, DB_Connection active_db_connection) {
		local_desktop = desktop;
		this.active_db_connection=active_db_connection;
		initializeClassVariables(in_work_order, editable);
		local_frame.add(areaScrollPane);
		local_frame.pack();
		local_frame.setVisible(true);
		local_frame.setLocation(xOffset * openFrameCount, 
								yOffset	* openFrameCount);
		local_desktop.add(local_frame);
		local_desktop.getDesktopManager().activateFrame(local_frame);//make this the frame at the front
		openFrameCount++;
		}

	private void initializeClassVariables(Integer in_work_order,
			Boolean editable) {
		local_frame = new JInternalFrame("", true, true, true, true);
		local_frame.addInternalFrameListener(this);
		Main_Panel = Initialize_JPanel("Build Setting");
		class_c = new GridBagConstraints();

		class_c.anchor = GridBagConstraints.CENTER;
		class_c.gridwidth = GridBagConstraints.REMAINDER;
		setUpButtons(editable);
		current_work_order = new Active_Work_Order(in_work_order, editable,active_db_connection);// create
																			// a
																			// new
																			// work_order_instance
																			// for
																			// the
																			// given
																			// in_work_order
		all_info = new All_Info(current_work_order, Main_Panel, class_c,active_db_connection);
		setFrameTitle();

		areaScrollPane = new JScrollPane(Main_Panel);
		areaScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		areaScrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
		
        printing_choices=new PrintStructure();
	}

	public JPanel Initialize_JPanel(String title) {
		JPanel t_panel = new JPanel();
		t_panel.setBorder(BorderFactory.createCompoundBorder(
				BorderFactory.createTitledBorder(title), 
				BorderFactory.createEmptyBorder(0,0,0,0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}

	public void setFrameTitle() {
		// This method finds the shock and rebound specs for a given setting
		ResultSet rs = null;

		rs = active_db_connection.db_calls.getGeneralInfo(current_work_order.work_order_id);

		try {
			if (rs.first()) {
				String first_name = replaceNulls(rs.getString("First Name"));
				String last_name = replaceNulls(rs.getString("Last Name"));
				String ability = replaceNulls(rs.getString("Riding Ability"));
				String year = replaceNulls(rs.getString("Year"));
				String brand = replaceNulls(rs.getString("Brand"));
				String model = replaceNulls(rs.getString("Model"));
				String shock_rev = replaceNulls(rs.getString("Shock_Rev"));
				String fork_rev = replaceNulls(rs.getString("Fork_Rev"));
				String terrain = getTerrain(current_work_order);
				String riding_type = getRidingType(current_work_order);

				String full_name;
				if (first_name.length()>0 && last_name.length()>0){
					full_name=last_name+", "+first_name;
				}else
					full_name= last_name+" "+first_name;
				
				String title_string = ("Work Order: "
						+ current_work_order.work_order_id + " " + full_name
						+ "   Ability: " + ability
						+ "   Terrain: " + terrain + "   Riding Type: "
						+ riding_type + "   Bike: " + year + " " + brand + " "
						+ model + "   Shock Rev: " + shock_rev
						+ "   Fork Rev: " + fork_rev);

				String title_string_subset = (
						full_name+"  "+  year + " " + brand + " "
						+ model);
				
				
				local_frame.setTitle(title_string);
				all_info.resetOverallTitle(title_string_subset);
			}
		} catch (SQLException e) {
			System.err.println("Settings_Frame:  Problem retrieving data.");
			e.printStackTrace();
		}
	}

	private String getTerrain(Active_Work_Order work_order) {
		String terrain = "";
		ResultSet rs = null;
		rs = active_db_connection.db_calls.getTerrain(work_order.work_order_id);
		int count = 0;
		try {
			if (rs.first()) {
				do {
					if (count == 0) {
						terrain = rs.getString("Terrain");
					} else {
						terrain = terrain + ", " + rs.getString("Terrain");
					}
					count++;
				} while (rs.next());
			}
		} catch (SQLException e) {
			System.err.println("Settings_Frame: Problem retrieving terrain.");
			e.printStackTrace();
		}
		return terrain;
	}

	private String getRidingType(
			Active_Work_Order work_order) {
		String riding_type = "";
		ResultSet rs = null;
		rs = active_db_connection.db_calls.getRidingType(work_order.work_order_id);
		int count = 0;
		try {
			if (rs.first()) {
				do {
					if (count == 0) {
						riding_type = rs.getString("Riding Type");
					} else {
						riding_type = riding_type + ", "
								+ rs.getString("Riding Type");
					}
					count++;
				} while (rs.next());
			}
		} catch (SQLException e) {
			System.err.println("Settings_Frame: Problem retrieving terrain.");
			e.printStackTrace();
		}
		return riding_type;
	}

	private String replaceNulls(String input) {
		// handle both nulls and zero amounts as returns from the db
		if ((input == null) || (input.equals("0")))
			return "";
		else
			return input;
	}

	public void setUpButtons(Boolean editable) {
		JPanel actions_box = Initialize_JPanel("");
		GridBagConstraints c = new GridBagConstraints();
		c.weightx = 1.0;
		c.anchor = GridBagConstraints.CENTER;

		JPanel edit_box = Initialize_JPanel("Edit Actions");
		edit_button = new JButton("Edit");
		edit_button.setActionCommand("edit");
		edit_button.addActionListener(this);
		edit_box.add(edit_button);
		//if the setting is editable and the db logging is turned off (as in we're connected
		//to the master db), go ahead and make this setting editable
		if ((editable)&&(Suspension_Notebook.DB_READ_ONLY==0)) {
			edit_button.setEnabled(true);
		} else {
			edit_button.setEnabled(false);
		}
		cancel_button = new JButton("Cancel");
		cancel_button.setActionCommand("cancel");
		cancel_button.addActionListener(this);
		edit_box.add(cancel_button);
		cancel_button.setEnabled(false);

		save_button = new JButton("Save");
		save_button.setActionCommand("save");
		save_button.addActionListener(this);
		edit_box.add(save_button);
		save_button.setEnabled(false);

		print_button=new JButton("Print");
		print_button.setActionCommand("print");
		print_button.addActionListener(this);
		edit_box.add(print_button);
		print_button.setEnabled(true);
		
		JPanel compare_box = Initialize_JPanel("Compare Actions");
		set_from_button = new JButton("Compare FROM");
		set_from_button.setActionCommand("set from");
		set_from_button.addActionListener(this);
		set_from_button.setBackground(Color.WHITE);
		compare_box.add(set_from_button);

		set_to_button = new JButton("Compare TO");
		set_to_button.setActionCommand("set to");
		set_to_button.addActionListener(this);
		set_to_button.setBackground(Color.WHITE);
		compare_box.add(set_to_button);

		c.insets=new Insets(0,0,0,25);
		actions_box.add(edit_box, c);
		actions_box.add(compare_box, c);

		Main_Panel.add(actions_box, class_c);
	}

	private void promptSaveType() {
		Object stringArray[] = { "Current", "Revision", "Cancel" };
		Integer result = JOptionPane
				.showOptionDialog(null, null, "Select Save",
						JOptionPane.YES_NO_OPTION,
						JOptionPane.QUESTION_MESSAGE, null, stringArray,
						stringArray[0]);

		// Update Current Selected
		if (result == 0) {
			all_info.saveInfo(current_work_order);
			setFrameTitle();// update the frame title

			Active_Work_GUIs.removeWorkOrder(current_work_order);
			local_desktop.remove(local_frame);// remove the classes GUIs from
												// the desktop
			// local_parent_frame.remove(local_frame);//remove the classes GUIs
			// from the desktop
			local_frame.dispose();// dispose of the existing setting class
			Settings_Frame modified_setting = new Settings_Frame(
					current_work_order.work_order_id,
					current_work_order.editable, local_desktop,active_db_connection); // create a
																	// new set
																	// of GUIS
																	// with the
																	// new info
			modified_setting.show();
			Active_Work_GUIs.active_settings_frames.add(modified_setting);
			active_db_connection.db_calls.insertOpenWorkOrder(current_work_order.work_order_id);
		}

		// Major Update Selected
		if (result == 1) {
			// now get the specific type of revision
			Object stringArray2[] = { "Rev Both", "Rev Shock only",
					"Rev Fork Only", "Cancel" };
			Integer rev_result = JOptionPane.showOptionDialog(null, null,
					"Select Save", JOptionPane.YES_NO_OPTION,
					JOptionPane.QUESTION_MESSAGE, null, stringArray2,
					stringArray2[0]);
			String rev_type = null;
			// increment the revision on both
			if (rev_result == 0) {
				rev_type = "Revise Both";
			}

			// increment the revision on shock only
			if (rev_result == 1) {
				rev_type = "Revise Shock";
			}

			// increment the revision on fork only
			if (rev_result == 2) {
				rev_type = "Revise Fork";
			}
			if (rev_result == 3) {
				rev_type = "Cancel";
				return;// exit out of this method
			}

			Integer new_id = active_db_connection.db_calls.cloneWorkOrder(
					current_work_order.work_order_id, "Major Revision",
					rev_type);
			Active_Work_Order new_work_order = new Active_Work_Order(new_id,
					true,active_db_connection);// create a new work_order_instance for the given
							// in_work_order
			all_info.saveInfo(new_work_order);
			setFrameTitle();// update the frame title

			Active_Work_GUIs.removeWorkOrder(current_work_order);
			local_desktop.remove(local_frame);// remove the classes GUIs from
												// the desktop
			local_frame.dispose();// dispose of the existing setting class
			Settings_Frame new_setting = new Settings_Frame(new_id, true,
					local_desktop,active_db_connection); // create a new set of GUIS with the new
									// info
			new_setting.show();
			Active_Work_GUIs.active_settings_frames.add(new_setting);
			active_db_connection.db_calls.insertOpenWorkOrder(new_id);
		}

		// Cancel Selected
		if (result == 2) {
		}
	}

	private void printSheets(){
		new PrintDialogInternalFrame(local_desktop,this, printing_choices);
	}
	
	
	public void processPrintingDecision(Vector<String> choice){
		int current_tab_index=all_info.tabbedPane.getSelectedIndex(); //store the active tab index
		PrinterJob job = PrinterJob.getPrinterJob();
		boolean ok_to_print = job.printDialog();//invoke the printer dialog
		job.setPrintable(all_info);//scope this to the Work_Info
		
		if (ok_to_print) {
			try {
				//iterate through all selected indexes
				for (int i=0;i<choice.size();i++){
					//System.out.println("Settings_Frame: printing:  requesting to print "+choice.elementAt(i));
					int print_index=printing_choices.getprintIndex(choice.elementAt(i));
					if (print_index>=0)	all_info.tabbedPane.setSelectedIndex(print_index);
					job.print();//print the actively selected tabs
				}
				all_info.tabbedPane.setSelectedIndex(current_tab_index); //reset tab to minimize user confusion
			} catch (PrinterException ex) {
				/* The job did not successfully complete */
			}
		}        

	}

	public void actionPerformed(ActionEvent e) {
		if ((e.getActionCommand()).equals("set from")) {
			if (set_from_button.getBackground() == Color.WHITE)
				set_from_button.setBackground(Color.GREEN);
			else
				set_from_button.setBackground(Color.WHITE);

			Active_Work_GUIs.changeFROMSettingsFrame(this, set_from_button.getBackground());
		}

		if ((e.getActionCommand()).equals("set to")) {
			if (set_to_button.getBackground() == Color.WHITE)
				set_to_button.setBackground(Color.RED);
			else
				set_to_button.setBackground(Color.WHITE);

			Active_Work_GUIs.changeTOSettingsFrame(this, set_to_button.getBackground());
		}

		if ((e.getActionCommand()).equals("edit")) {
			all_info.enableSubComponents();

			edit_button.setEnabled(false);
			cancel_button.setEnabled(true);
			save_button.setEnabled(true);
		}
		if ((e.getActionCommand()).equals("cancel")) {
			all_info.disableSubComponents();

			if (current_work_order.editable == true) {
				edit_button.setEnabled(true);
			} else {
				edit_button.setEnabled(false);
			}
			cancel_button.setEnabled(false);
			save_button.setEnabled(false);
		}
		if ((e.getActionCommand()).equals("save")) {
			promptSaveType();
			all_info.disableSubComponents();
			if (current_work_order.editable == true) {
				edit_button.setEnabled(true);
			} else {
				edit_button.setEnabled(false);
			}
			cancel_button.setEnabled(false);
			save_button.setEnabled(false);
		}
		if ((e.getActionCommand()).equals("print")) {
			printSheets();
		}
	
	
	}

	public void internalFrameClosing(InternalFrameEvent e) {
		Active_Work_GUIs.removeWorkOrder(current_work_order);
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


}
