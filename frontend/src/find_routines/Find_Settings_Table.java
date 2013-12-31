package find_routines;

import javax.swing.event.*;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.TableColumn;
import javax.swing.table.DefaultTableModel;
import java.awt.Dimension;
import javax.swing.*;


import base.Active_Work_GUIs;
import base.Settings_Frame;
import base.The_Desktop;

import db_info.DB_Connection;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Component;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.util.Vector;
import java.sql.*;

public class Find_Settings_Table implements ActionListener,
ListSelectionListener, PopupMenuListener {
	JInternalFrame p_frame;
	static JDesktopPane desktop;
	JTable class_table;
	DefaultTableModel model;

	JPanel search_panel;
	JPanel criteria_panel;
	JPanel number_area;
	JTextField field_for_numbers;
	JPanel number_buttons_panel;
	JPanel results_panel;
	JPanel commands_panel;
	
	GridBagConstraints class_c;

	JButton open_selection;
	JButton clone_selection;
	JButton delete_selection;

	JComboBox rider_box;
	Vector<Integer> ref_rider;
	JComboBox year_box;
	Vector<Integer> ref_year;
	JComboBox model_box;
	Vector<Integer> ref_model;
	JComboBox ability_box;
	Vector<Integer> ref_ability;

	Integer number_of_results_buttons;//the total number of results buttons to handle the query
	static Integer number_results_buttons_per_panel=5;//the number of results buttons per results panel
	Integer current_results_button;   //the active results button
	Integer current_results_panel;    //the active results panel
	
	DB_Connection active_db_connection;
	
	public Find_Settings_Table(JInternalFrame parent_internal_frame,
			JDesktopPane parent_desktop, JPanel parent_panel,
			GridBagConstraints parent_c, DB_Connection active_db_connection) {
		p_frame = parent_internal_frame;
		desktop = parent_desktop;
		this.active_db_connection=active_db_connection;
		initializeClassVariables();
		setupSelectionArea();
		setupResultsArea();
		setUpSelectionButton();
		getWorkOrders(current_results_button);// retrieve all data to start off with
		parent_panel.add(search_panel, parent_c);
		disablePanelComponents();
	}// end constructor

	private void initializeClassVariables() {
		search_panel = initializeJPanel("");
		results_panel = initializeJPanel("");
		criteria_panel = initializeJPanel("Search Fields:");
		commands_panel = initializeJPanel("Actions:");
		number_area=initializeJPanel("");
		field_for_numbers=new JTextField(10);
		field_for_numbers.setEditable(false);
		number_buttons_panel=initializeJPanel("");

		class_c = new GridBagConstraints();
		class_c.anchor = GridBagConstraints.CENTER;
		class_c.weightx = 1.0;
		class_c.gridwidth = GridBagConstraints.REMAINDER;

		open_selection = new JButton("Open Settings");
		clone_selection = new JButton("Clone Setting");
		delete_selection = new JButton("Delete Setting");

		rider_box = new JComboBox();
		ref_rider = new Vector<Integer>();

		year_box = new JComboBox();
		ref_year = new Vector<Integer>();

		model_box = new JComboBox();
		ref_model = new Vector<Integer>();

		ability_box = new JComboBox();
		ref_ability = new Vector<Integer>();
		
		current_results_button=1; //initialize the current results page to 1
		current_results_panel=0; //initialize the current results panel to 0
		number_of_results_buttons=1;	
	}

	public JPanel initializeJPanel(String title) {
		JPanel t_panel = new JPanel();
		t_panel.setBorder(BorderFactory.createCompoundBorder(
				BorderFactory.createTitledBorder(title), 
				BorderFactory.createEmptyBorder(0,0,0,0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}

	public void setupSelectionArea() {
		JPanel t_panel1 = initializeJPanel("");
		JPanel t_panel2 = initializeJPanel("");
		GridBagConstraints c = new GridBagConstraints();
		c.weightx = 1.0;

		setupRiderBox(t_panel1, rider_box, "Rider", ref_rider, c);
		setupBox(t_panel1, ability_box, "Ability", "rider_ability",
				"description", ref_ability, c);
		setupBox(t_panel2, year_box, "Year", "bike_year", "year", ref_year, c);
		setupBox(t_panel2, model_box, "Model", "bike_brand_model",
				"brand,model", ref_model, c);

		c.gridwidth = GridBagConstraints.REMAINDER;
		criteria_panel.add(t_panel1, c);
		criteria_panel.add(t_panel2, c);
		search_panel.add(criteria_panel, class_c);
	}

	public void setupRiderBox(JPanel t_panel, JComboBox c_box,
			String box_label, Vector<Integer> ref_vect,
			GridBagConstraints parent_c) {
		putBlankFirstPosition(c_box, ref_vect);
		ResultSet rs = null;
		rs =  active_db_connection.db_calls.getRiderNames();
		try {
			if (rs.first()) {
				do {
					ref_vect.add(rs.getInt("row_id"));
					c_box.addItem(rs.getString("name"));
				} while (rs.next());
			}
		} catch (SQLException e) {
			System.err.println("Add_Customer: Problem retrieving data.");
			e.printStackTrace();
		}
		if (ref_vect.size() > 0) {
			c_box.setSelectedIndex(0);
		}
		c_box.addPopupMenuListener(this);//for the menu being displayed

		parent_c.insets = new Insets(10, 35, 10, 10);
		t_panel.add(new JLabel(box_label), parent_c);
		parent_c.insets = new Insets(10, 0, 10, 35);
		t_panel.add(c_box, parent_c);
	}

	public void putBlankFirstPosition(JComboBox c_box,
			Vector<Integer> ref_vec) {
		// Add a blank space at the top of the selections,
		// and add a corresponding zero to the reference vector

		c_box.addItem("");
		ref_vec.insertElementAt(0, 0);
	}

	public void setupBox(JPanel parent_panel, JComboBox c_box,
			String box_label, String table, String field,
			Vector<Integer> ref_vect, GridBagConstraints parent_c) {
		Vector<String> items = active_db_connection.db_calls.getAllValues(table, field,field, ref_vect);

		putBlankFirstPosition(c_box, ref_vect);

		for (int i = 0; i < items.size(); i++) {
			c_box.addItem(items.elementAt(i));
		}
		if (items.size() > 0) {
			c_box.setSelectedIndex(0);
		}
		c_box.addPopupMenuListener(this);//for the menu being displayed
		parent_c.insets = new Insets(10, 35, 10, 10);
		parent_panel.add(new JLabel(box_label), parent_c);
		parent_c.insets = new Insets(10, 0, 10, 35);
		parent_panel.add(c_box, parent_c);
	}

	public void setupResultsArea() {
		class_table = new JTable();
		model = (DefaultTableModel) class_table.getModel();
		ListSelectionModel selection_model = class_table.getSelectionModel();
		selection_model.addListSelectionListener(this);

		JScrollPane areaScrollPane = new JScrollPane(class_table);
		areaScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		areaScrollPane.setPreferredSize(new Dimension(800, 250));
		areaScrollPane.setBorder(BorderFactory.createCompoundBorder(
				BorderFactory.createCompoundBorder(
						BorderFactory.createTitledBorder("Results"), 
						BorderFactory.createEmptyBorder(0, 0, 0, 0)), 
						areaScrollPane.getBorder()));

		createNumbersArea();
		results_panel.add(number_area,class_c);
		results_panel.add(areaScrollPane,class_c);
		search_panel.add(results_panel,class_c);
	}
	private void createNumbersArea() {
		GridBagConstraints c=new GridBagConstraints();
		c.insets=new Insets(0,0,5,0);
		number_area.add(new JLabel("Total Matching Settings:"),c);
		c.insets=new Insets(0,0,0,0);
		c.gridwidth=1;
		number_area.add(field_for_numbers, c);
		number_area.add(number_buttons_panel,c);
	}    

	private void clearTable() {
		Vector<String> data_vect = new Vector<String>();
		Vector<String> col_id_vect = new Vector<String>();

		model.setDataVector(data_vect, col_id_vect);
		model.fireTableDataChanged();
	}

	public void getWorkOrders(Integer page) {
		ResultSet rs = null;
		clearTable();
		getNumberWorkOrders();//get the number of workorders and build the results button panel

		rs = active_db_connection.db_calls.findWorkOrders(
				page,
				ref_rider.elementAt(rider_box.getSelectedIndex()), 
				ref_year.elementAt(year_box.getSelectedIndex()), 
				ref_model.elementAt(model_box.getSelectedIndex()), 
				ref_ability.elementAt(ability_box.getSelectedIndex()));

		try {
			if (rs.first()) {
				Vector<String> col_names = new Vector<String>();
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 0; i < rsmd.getColumnCount(); i++) {
					col_names.add(rsmd.getColumnLabel(i + 1));// get to the list of the columns to request
					model.addColumn(rsmd.getColumnLabel(i + 1));// add to the list of display columns
				}

				do {
					// Get the data from the resultSet
					Vector<String> data = new Vector<String>();
					for (int i = 0; i < col_names.size(); i++) {
						data.add(rs.getString(col_names.elementAt(i)));
					}
					model.addRow(data); // add this result to the table
				} while (rs.next());

				// resize the columns each time we get new results
				for (int i = 0; i < class_table.getColumnCount(); i++) {
					TableColumn this_col = class_table.getColumnModel().getColumn(i);
					//make the bike col a little bigger
					if (i==3)this_col.setPreferredWidth(150);
					else this_col.sizeWidthToFit();
				}
			}
		} catch (SQLException e) {
			System.err.println("Find_Settings_Table: Problem retrieving data.");
			e.printStackTrace();
		}
	}
	
	private int determineNumberResultsButtons(Integer total_number, Integer records_per_page){
		Integer t_number_of_results_buttons=total_number / records_per_page;
		if(total_number % records_per_page >0){
			t_number_of_results_buttons++;//if there is a partial page, add one more page
		}
		return t_number_of_results_buttons;
	}

	private void rebuildResultsPanel(){
		//remove any existing results buttons first
		Component[] panel_components=number_buttons_panel.getComponents();
		int max=panel_components.length;
		for(int i=0;i<max;i++) {
			number_buttons_panel.remove(panel_components[i]);
		}
		p_frame.updateUI();
		
		GridBagConstraints c = new GridBagConstraints();
		c.anchor = GridBagConstraints.CENTER;
		c.weightx = 1.0;
		c.insets = new Insets(0,0,5,5);
		JLabel label=new JLabel("Result Pages ");
		number_buttons_panel.add(label,c);
		
		//if the current results panel is non-zero, then put in a previous button
		if (current_results_panel>0){
			JButton button=new JButton("<<");
			button.addActionListener(this);
			button.setActionCommand("prev set");
			number_buttons_panel.add(button,c);
		}
		int base=current_results_panel*number_results_buttons_per_panel;
		for (int i=base+1; i<=number_of_results_buttons; i++){
			if (i<=(base+number_results_buttons_per_panel)){
				JButton button=new JButton(i+"");
				button.addActionListener(this);
				button.setActionCommand(i+"");
				number_buttons_panel.add(button,c);
			}
			//if we are over the number of buttons for the panel, then put in a next button
			if (i>(base+number_results_buttons_per_panel)){
				JButton button=new JButton(">>");
				button.addActionListener(this);
				button.setActionCommand("next set");
				number_buttons_panel.add(button,c);
				break;//only go to the limit per panel
			}
		}
		p_frame.updateUI();			
	}
	
	public void getNumberWorkOrders() {
		ResultSet rs_numbers = null;
		rs_numbers = active_db_connection.db_calls.getNumberOfWorkOrders(
				ref_rider.elementAt(rider_box.getSelectedIndex()), 
				ref_year.elementAt(year_box.getSelectedIndex()), 
				ref_model.elementAt(model_box.getSelectedIndex()), 
				ref_ability.elementAt(ability_box.getSelectedIndex()));
		try {

			if (rs_numbers.first()) {
				Integer total_number=rs_numbers.getInt("total");
				Integer records_per_page=rs_numbers.getInt("records per page");
				field_for_numbers.setText("     "+total_number);
				number_of_results_buttons=determineNumberResultsButtons(total_number,records_per_page);
				rebuildResultsPanel();
			}
		} catch (SQLException e) {
			System.err.println("Find_Settings_Table: Problem retrieving data.");
			e.printStackTrace();
		}
	}
	
	public void setUpSelectionButton() {
		GridBagConstraints c = new GridBagConstraints();
		c.weightx = 1.0;
		c.insets = new Insets(10, 35, 10, 35);

		open_selection.setActionCommand("Open Settings");
		open_selection.addActionListener(this);

		clone_selection.setActionCommand("Clone Setting");
		clone_selection.addActionListener(this);
		clone_selection.setEnabled(false);// Disable this button except when
		// one row is selected

		delete_selection.setActionCommand("Delete Settings");
		delete_selection.addActionListener(this);
		delete_selection.setEnabled(false);// Disable this button except when
		// one or more rows are selected

		commands_panel.add(open_selection, c);
		commands_panel.add(clone_selection, c);
		commands_panel.add(delete_selection, c);

		search_panel.add(commands_panel, class_c);
	}

	public void openSelectedSettings() {
		// get the rows the user has selected
		int[] selected_rows = class_table.getSelectedRows();

		p_frame.setVisible(false);
		// for each select row, get the setting id which is in column 0
		// open a new window for each setting
		for (int i = 0; i < selected_rows.length; i++) {
			// get the work order id which is in the 0th column
			Integer work_order = new Integer((String) model.getValueAt(
					selected_rows[i], 0));
			Boolean editable = determineEditable(work_order);
			Settings_Frame settings_frame = new Settings_Frame(work_order,
					editable, desktop,active_db_connection);

			if (!editable) {
				JOptionPane.showMessageDialog(
						null,
						"This work order is in use, this work order has been opened READ ONLY.",
						"Warning", JOptionPane.WARNING_MESSAGE, null);
			}

			Active_Work_GUIs.active_settings_frames.add(settings_frame);
			if (editable) {
				active_db_connection.db_calls.insertOpenWorkOrder(work_order);
			}
		}

		// to minimize problems, remove the selection from the user's table
		// after they have opened a window with the
		// setting
		for (int i = selected_rows.length - 1; i >= 0; i--) {
			model.removeRow(selected_rows[i]);
		}
		p_frame.dispose();// close the find_settings frame
	}

	public Boolean determineEditable(Integer work_order) {
		// This checks the db to see if the work order is in use
		// if the db returns a 1 the work order is in use
		// if the db returns a 0 the work order is not in use
		Boolean response = false;
		ResultSet rs = null;
		rs = active_db_connection.db_calls.workOrderIsEditable(work_order);
		try {
			if (rs.first()) {
				int numeric_response = rs.getInt("response");
				if (numeric_response == 1)
					response = true;
				if (numeric_response == 0)
					response = false;
			}
		} catch (SQLException e) {
			System.err.println("Find_Settings_Table:  Problem checking status of work_order.");
			e.printStackTrace();
		}
		return response;
	}

	public void deleteSelectedSettings() {
		Boolean delete_all=false;
		String response=null;
		
		// get the rows the user has selected
		int[] selected_rows = class_table.getSelectedRows();

		// for each select row, get the setting id which is in column 0
		// open a new window for each setting
		for (int i = 0; i < selected_rows.length; i++) {
			// get the work order id which is in the 0th column
			Integer work_order = new Integer((String) model.getValueAt(
					selected_rows[i], 0));

			if (delete_all){
				//don't prompt the user, just go ahead and delete the work order
				active_db_connection.db_calls.deleteWorkOrder(work_order);
			}

			//Double check with the user that the want to delete these settings
			if (!delete_all){
				response=verifyWorkOrderDelete(work_order);
				if (response.equals("single yes")){
					//only delete the active work_order in the loop
					active_db_connection.db_calls.deleteWorkOrder(work_order);	
				}
				if (response.equals("all yes")){
					//delete the active work order in the loop and
					//flip the flag so the user won't by prompted any more
					active_db_connection.db_calls.deleteWorkOrder(work_order);
					delete_all=true; 
				}
				if (response.equals("cancel")){
					return;
				}
			}
		}

		// to minimize problems, remove the selection from the user's table
		// after they have opened a window with the
		// setting
		for (int i = selected_rows.length - 1; i >= 0; i--) {
			model.removeRow(selected_rows[i]);
		}
	}

    private String verifyWorkOrderDelete(int work_order) {
		String response="cancel";
    	Object usr_options[] = { "Yes","Yes to All","Cancel" };
		Integer usr_response=JOptionPane.showOptionDialog(null, null, "Delete Setting "+work_order,
				JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE, null, usr_options,
				usr_options[0]);
		
		if (usr_response==0){
			response="single yes";
		}
		
		if (usr_response==1){
			response="all yes";		
		}

		if (usr_response==2){
			response="cancel";
		}

		return response;
    } 
	
	public void cloneSetting() {
		// get the rows the user has selected
		int[] selected_rows = class_table.getSelectedRows();

		// only clone if only one setting is selected
		// if more than one is selected just return out of this method
		if (selected_rows.length != 1)
			return;

		// for each select row, get the setting id which is in column 0
		// get the work order id which is in the 0th column
		Integer work_order = new Integer((String) model.getValueAt(
				selected_rows[0], 0));
		// System.out.println("Cloning work order "+work_order);
		active_db_connection.db_calls.cloneWorkOrder(work_order, "New Spec", "Dont Revise");
		// the zero is a flag indicating
		// we do not want to clone everything
		// customer comments, tech support comments, payment info, and shipping
		// info will not be cloned with this flag turned off
		getWorkOrders(current_results_button);
	}

	public void disablePanelComponents() {
		// make the table cells uneditable
		class_table.setDefaultEditor(Object.class, null);
	}

	public void valueChanged(ListSelectionEvent e) {
		// This method is invoked twice when a user selects or deselects a row
		// in the table
		// It only allows one setting to be cloned at a time by only enabling
		// the clone button when
		// only one row is selected
		if ((class_table.getSelectedRows()).length == 1)
			clone_selection.setEnabled(true);
		else
			clone_selection.setEnabled(false);
		if ((class_table.getSelectedRows()).length >= 1)
			delete_selection.setEnabled(true);
		else
			delete_selection.setEnabled(false);
	}

	public void popupMenuCanceled(PopupMenuEvent e) {
	}

	public void popupMenuWillBecomeVisible(PopupMenuEvent e) {
	}

	public void popupMenuWillBecomeInvisible(PopupMenuEvent e) {
		// Get the Work Orders based on the criteria the user has selected every
		// time one of the criteria
		// combo_boxes popup menu is closed after being opened
		current_results_button=1; //user has selected a new criteria so go back to the first selection
		current_results_panel=0; //user has selected a new criteria so go back to the first selection
		number_of_results_buttons=1;//user has selected a new criteria so go back to the first selection	
		getWorkOrders(current_results_button);
	}

	public void actionPerformed(ActionEvent e) {
		The_Desktop.setCursorWait(true);

		String action_command=e.getActionCommand();

		try{
			Integer int_result=Integer.parseInt(action_command);
			if (int_result>0) {
				current_results_button=int_result;//set the current selected page
				getWorkOrders(current_results_button);
			}
		}catch (NumberFormatException exc) {
		}
		
		if (action_command.equals("prev set")) {
			current_results_panel--;
			rebuildResultsPanel();
		}
		if (action_command.equals("next set")) {
			current_results_panel++;
			rebuildResultsPanel();
		}
		
		if (action_command.equals("Open Settings")) {
			openSelectedSettings();
		}
		if (action_command.equals("Delete Settings")) {
			deleteSelectedSettings();
		}
		if (action_command.equals("Clone Setting")) {
			cloneSetting();
		}
		The_Desktop.setCursorWait(false);
	}//end method actionPerformed

}//end class Find_Settings_Table

