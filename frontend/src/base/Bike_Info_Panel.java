package base;

import java.util.*;
import javax.swing.*;

import db_info.DB_Connection;

import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.sql.*;

public class Bike_Info_Panel implements ActionListener{
	JPanel rider_info;
	GridBagConstraints class_c;
	
	JComboBox year_box;
	Vector<Integer> ref_year;

	JComboBox model_box;
	Vector<Integer> ref_model;

	JComboBox shock_brand_box;
	Vector<Integer> ref_shock_brand;

	JComboBox fork_brand_box;
	Vector<Integer> ref_fork_brand;

	Active_Work_Order current_work_order;
	
	String existing_model=null;
	DB_Connection active_db_connection;
	public Bike_Info_Panel(Active_Work_Order work_order,JPanel parent_panel,
			GridBagConstraints parent_c, DB_Connection active_db_connection) {
		current_work_order=work_order;
		this.active_db_connection=active_db_connection;
		initializeClassVariables();
		setupTextAreas(rider_info);
		initializeComponents();
		disablePanelComponents();

		parent_panel.add(rider_info, parent_c);
	}

	public void initializeClassVariables() {
		rider_info=initializeJPanel("Bike Info");
		
		year_box=new JComboBox();
		ref_year= new Vector<Integer>();

		model_box=new JComboBox();
		ref_model= new Vector<Integer>();

		shock_brand_box=new JComboBox();
		ref_shock_brand= new Vector<Integer>();

		fork_brand_box=new JComboBox();
		ref_fork_brand= new Vector<Integer>();

		model_box.setActionCommand("model action");
		shock_brand_box.setActionCommand("shock brand action");
		fork_brand_box.setActionCommand("fork brand action");
		model_box.addActionListener(this);
		shock_brand_box.addActionListener(this);
		fork_brand_box.addActionListener(this);
		
		class_c = new GridBagConstraints();
		class_c.anchor=GridBagConstraints.NORTHWEST;
	}

	public JPanel initializeJPanel(String title) {
		JPanel t_panel = new JPanel();
		t_panel.setBorder(BorderFactory.createCompoundBorder(BorderFactory
				.createTitledBorder(title), BorderFactory.createEmptyBorder(0,
				0, 0, 0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}
	public void setupTextAreas(JPanel rider_info) {
		JPanel bike_part1=initializeJPanel("");

		GridBagConstraints c = new GridBagConstraints();
		c.anchor=GridBagConstraints.NORTHWEST;
		addComboBox(bike_part1, "Bike Year",year_box,ref_year,"bike_year","year",c);
		addComboBox(bike_part1, "Bike Model",model_box,ref_model,"bike_brand_model","brand,model",c);
		addComboBox(bike_part1, "Shock Brand",shock_brand_box,ref_shock_brand,"suspension_brand","name",c);
		addComboBox(bike_part1, "Fork Brand",fork_brand_box,ref_fork_brand,"suspension_brand","name",c);

		rider_info.add(bike_part1,class_c);
	}

	public void addComboBox(JPanel t_panel, String t_label, JComboBox c_box,
			Vector<Integer> ref_c_box,String table_name, String lookup_field,
			GridBagConstraints c) {
		c.insets=new Insets(5,0,0,5);
		t_panel.add(new JLabel(t_label),c);

		setupComboBox(c_box,ref_c_box, table_name, lookup_field);

		c.insets=new Insets(0,0,0,5);
		c.gridwidth=GridBagConstraints.REMAINDER;

		t_panel.add(c_box, c);
		c.gridwidth=1; //reset gridwidth
	}

	public void setupComboBox(JComboBox c_box, Vector<Integer> c_box_ref,
			String table_name, String lookup_field) {
		Vector<String> items1;
		
		items1=active_db_connection.db_calls.getAllValues(table_name,lookup_field,lookup_field,c_box_ref);
		//Add a blank space at the top of the selections,
		//and add a corresponding zero to the reference vector
		putBlankFirstPosition(c_box, c_box_ref);

		for (int i=0;i<items1.size();i++) {
			c_box.addItem(items1.elementAt(i));
		}
		if (items1.size()>0) {
			c_box.setSelectedIndex(0);
		}
	}
	public void putBlankFirstPosition(JComboBox c_box,
			Vector<Integer> ref_vec) {
		// Add a blank space at the top of the selections,
		// and add a corresponding zero to the reference vector
		c_box.addItem("");
		ref_vec.insertElementAt(0, 0);
	}
	public void disablePanelComponents() {
		disableComboBox(year_box);
		disableComboBox(model_box);
		disableComboBox(shock_brand_box);
		disableComboBox(fork_brand_box);
	}


	public void disableComboBox(JComboBox c_box) {
		c_box.setEnabled(false);
	}

	public void enablePanelComponents() {
		enableComboBox(year_box);
		enableComboBox(model_box);
		enableComboBox(shock_brand_box);
		enableComboBox(fork_brand_box);
	}

	public void enableComboBox(JComboBox c_box) {
		c_box.setEnabled(true);
	}

	private void alignComboBox(JComboBox c_box, String db_string) {
		for(int i=0;i<c_box.getItemCount();i++)
			if ( ((String)c_box.getItemAt(i)).equals(db_string) ) {
				c_box.setSelectedIndex(i);
				return;
			}
		c_box.setSelectedIndex(0);
	}

	private void initializeComponents() {
		ResultSet rs=null;

		rs=active_db_connection.db_calls.getBikeInfo(current_work_order.work_order_id);
		try {
			if (rs.first()) {
				alignComboBox(year_box,rs.getString("Year"));
				String model=rs.getString("Brand")+" "+rs.getString("Model");
				existing_model=model;//so other classes can reference the model that was already associated with this work order
				alignComboBox(model_box,model);
				alignComboBox(shock_brand_box,rs.getString("Shock Brand"));
				alignComboBox(fork_brand_box,rs.getString("Fork Brand"));
				updateSuspensionBrandReferences();
			}
		}catch (SQLException e) {
			System.err.println("Bike_Info_Panel: Problem retrieving data.");
			e.printStackTrace();
		}
	}

	public void saveInfo(Active_Work_Order t_work_order) {
		active_db_connection.db_calls.saveBikeInfo(t_work_order.work_order_id,ref_year.elementAt(year_box.getSelectedIndex()),
				ref_model.elementAt(model_box.getSelectedIndex()),
				ref_fork_brand.elementAt(shock_brand_box.getSelectedIndex()),
				ref_shock_brand.elementAt(fork_brand_box.getSelectedIndex())       
		);
	}

	private void updateSuspensionBrandReferences(){
		current_work_order.selected_shock_brand=(String)shock_brand_box.getSelectedItem();
		current_work_order.selected_fork_brand=(String)fork_brand_box.getSelectedItem();
	}
	
	private void maybeDisableGeneralInformation(){
		Settings_Frame current_setting_ref=Active_Work_GUIs.determineCurrentSettingsFrame(current_work_order);
		if (current_setting_ref!=null){
				    current_setting_ref.all_info.fork_info.component_info.maybeDisableGeneralInformation();
				    current_setting_ref.all_info.shock_info.component_info.maybeDisableGeneralInformation();
		}
	}
	
	public void actionPerformed(ActionEvent ae) {
		if (ae.getActionCommand().equals("model action")) {
			maybeDisableGeneralInformation();
		}
		if (ae.getActionCommand().equals("shock brand action")) {
			updateSuspensionBrandReferences();
		}
		if (ae.getActionCommand().equals("fork brand action")) {
			updateSuspensionBrandReferences();
		}
	}
}//end class Bike_Info_Panel
