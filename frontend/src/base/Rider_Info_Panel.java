package base;

import java.util.*;
import javax.swing.*;

import db_info.DB_Connection;

import java.awt.Color;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;

public class Rider_Info_Panel implements ActionListener {
	JPanel rider_info;
	GridBagConstraints class_c;

	JComboBox rider_box;
	Vector<Integer> ref_rider;

	JComboBox ability_box;
	Vector<Integer> ref_ability;

	JComboBox weight_box;
	Vector<Integer> ref_weight;

	JComboBox height_box;
	Vector<Integer> ref_height;

	JComboBox shop_box;
	Vector<Integer> ref_shop;

	JComboBox service_box;
	Vector<Integer> ref_service;

	//JTextArea support_id_area;
	JTextField phone1_field;
	JTextField phone2_field;

	Active_Work_Order current_work_order;
	DB_Connection active_db_connection;
	public Rider_Info_Panel(Active_Work_Order work_order,JPanel parent_panel,
			GridBagConstraints parent_c, DB_Connection active_db_connection) {
		current_work_order=work_order;
		this.active_db_connection=active_db_connection;

		initializeClassVariables();
		setupTextFields();
		getDBInfo();
		disablePanelComponents();

		parent_panel.add(rider_info, parent_c);
	}

	private void initializeClassVariables() {
		rider_info=initializeJPanel("Rider Info");

		class_c = new GridBagConstraints();
		class_c.anchor=GridBagConstraints.NORTHWEST;

		rider_box=new JComboBox();
		ref_rider= new Vector<Integer>();

		ability_box=new JComboBox();
		ref_ability= new Vector<Integer>();

		weight_box=new JComboBox();
		ref_weight= new Vector<Integer>();

		height_box=new JComboBox();
		ref_height= new Vector<Integer>();

		shop_box=new JComboBox();
		ref_shop= new Vector<Integer>();

		service_box=new JComboBox();
		ref_service= new Vector<Integer>();

		phone1_field = new JTextField();
		phone2_field = new JTextField();
	
		rider_box.setActionCommand("rider action");
		rider_box.addActionListener(this);
	}

	private JPanel initializeJPanel(String title) {
		JPanel t_panel=new JPanel();
		t_panel.setBorder( BorderFactory.createCompoundBorder(
				BorderFactory.createTitledBorder(title),
				BorderFactory.createEmptyBorder(0,0,0,0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}

	private void setupTextFields() {
		JPanel rider_part1=initializeJPanel("");
		JPanel rider_part2=initializeJPanel("");

		GridBagConstraints c = new GridBagConstraints();
		c.anchor=GridBagConstraints.NORTHWEST;
		addComboBox(rider_part1, "Name", rider_box,ref_rider,"rider","last_name",c);
		addComboBox(rider_part1, "Ability",ability_box,ref_ability,"rider_ability","description",c);
		addComboBox(rider_part1, "Weight",weight_box,ref_weight,"rider_weight","weight_lbs",c);
		addComboBox(rider_part1, "Height",height_box,ref_height,"rider_height","height_in",c);
		addTextField(rider_part2, "Phone 1",phone1_field,c);
		addTextField(rider_part2, "Phone 2",phone2_field,c);
		addComboBox(rider_part2, "Shop",shop_box,ref_shop,"shop","name",c);
		addComboBox(rider_part2, "Service Location",service_box,ref_service,"service_location","location",c);

		class_c.gridwidth=GridBagConstraints.REMAINDER;
		rider_info.add(rider_part1,class_c);
		rider_info.add(rider_part2,class_c);
		class_c.gridwidth=1;

		clearTextFields();
	}

	private void addComboBox(JPanel t_panel, String t_label, JComboBox c_box,
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

	private void setTheRiders(JComboBox c_box, Vector<Integer> c_box_ref){
		ResultSet rs =active_db_connection.db_calls.getRiderNames();
		try {
			if (rs.first()) {
				do
				{
					c_box_ref.add(rs.getInt("row_id"));
					c_box.addItem(rs.getString("name"));
				}while (rs.next());       
			}
		}catch (SQLException e) {
			System.err.println("Rider_Info_Panel: Problem retrieving data.");
			e.printStackTrace();
		}              
		if (c_box_ref.size()>0) {
			c_box.setSelectedIndex(0);
		}

	}

	public void setupComboBox(JComboBox c_box, Vector<Integer> c_box_ref,
			String table_name, String lookup_field) {
		Vector<String> items1=null;
		Vector<String> items2=null;

		if (table_name.equals("rider"))
			//Handle the names
		{
			putBlankFirstPosition(c_box, c_box_ref);
			setTheRiders(c_box, c_box_ref);
		}else if (table_name.equals("rider_ability"))
		{
			//Handle the ability
			items1=active_db_connection.db_calls.getAllValues(table_name,lookup_field,"row_id",c_box_ref);
			//Add a blank space at the top of the selections,
			//and add a corresponding zero to the reference vector
			putBlankFirstPosition(c_box, c_box_ref);            

			for (int i=0;i<items1.size();i++) {
				c_box.addItem(items1.elementAt(i));
			}
			if (items1.size()>0) {
				c_box.setSelectedIndex(0);
			}
		}else if (table_name.equals("rider_weight"))
			//Handle the weight
		{
			items1=active_db_connection.db_calls.getAllValues(table_name,"weight_lbs","weight_lbs",c_box_ref);
			items2=active_db_connection.db_calls.getAllValues(table_name,"weight_kg","weight_kg",c_box_ref);

			//Add a blank space at the top of the selections,
			//and add a corresponding zero to the reference vector
			putBlankFirstPosition(c_box, c_box_ref);            
			for (int i=0;i<items1.size();i++) {
				c_box.addItem(items1.elementAt(i)+"lbs --- "+items2.elementAt(i)+"kg");
			}
			if (items1.size()>0) {
				c_box.setSelectedIndex(0);
			}

		}else if (table_name.equals("rider_height")) {
			//Handle the height
			items1=active_db_connection.db_calls.getAllValues(table_name,"height_in","height_in",c_box_ref);
			items2=active_db_connection.db_calls.getAllValues(table_name,"height_cm","height_cm",c_box_ref);

			//Add a blank space at the top of the selections,
			//and add a corresponding zero to the reference vector
			putBlankFirstPosition(c_box, c_box_ref);            
			for (int i=0;i<items1.size();i++) {
				c_box.addItem(convertToBigUnits(items1.elementAt(i),"english")+" --- "+
						convertToBigUnits(items2.elementAt(i),"metric"));
			}
			if (items1.size()>0) {
				c_box.setSelectedIndex(0);
			}

		} else {
			//Handle everything else
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
	}

	public void putBlankFirstPosition(JComboBox c_box, Vector <Integer> ref_vec) {
		//Add a blank space at the top of the selections,
		//and add a corresponding zero to the reference vector

		c_box.addItem("");
		ref_vec.insertElementAt(0,0);
	} 

	public void addTextField(JPanel t_panel, String t_label, JTextField t_field,
			GridBagConstraints c) {
		t_field.setColumns(12);
		t_field.setBorder( BorderFactory.createLineBorder(Color.white));
		t_field.setDisabledTextColor(Color.black);
		c.insets=new Insets(5,0,0,5);
		t_panel.add(new JLabel(t_label),c);

		c.insets=new Insets(0,0,0,5);
		c.gridwidth=GridBagConstraints.REMAINDER;
		t_panel.add(t_field, c);
		c.gridwidth=1; //reset gridwidth
	}

	private void clearTextFields() {
		phone1_field.setText("");
		phone2_field.setText("");
	}

	public void disablePanelComponents() {
		//Disable_TextArea(support_id_area);
		disableTextField(phone1_field);
		disableTextField(phone2_field);

		disableComboBox(rider_box);
		disableComboBox(ability_box);
		disableComboBox(weight_box);
		disableComboBox(height_box);
		disableComboBox(shop_box);
		disableComboBox(service_box);
	}


	public void disableComboBox(JComboBox c_box) {
		c_box.setEnabled(false);
	}

	public void enablePanelComponents() {
		/*The Text Areas should never be enabled; this information should not be changed on this interface*/
		enableComboBox(rider_box);
		enableComboBox(ability_box);
		enableComboBox(weight_box);
		enableComboBox(height_box);
		enableComboBox(shop_box);
		enableComboBox(service_box);
	}

	public void enableComboBox(JComboBox c_box) {
		c_box.setEnabled(true);
	}

	public void disableTextField(JTextField tf) {
		tf.setEnabled(false);
		tf.setBackground(Color.lightGray);
	}


	private void alignComboBox(JComboBox c_box, String db_string) {
		for(int i=0;i<c_box.getItemCount();i++)
			if ( ((String)c_box.getItemAt(i)).equals(db_string) ) {
				c_box.setSelectedIndex(i);
				return;
			}
		c_box.setSelectedIndex(0);
	}

	private String convertToBigUnits(String measure, String type) {
		int int_measure=0;
		String result="";

		if (measure!=null) {
			int_measure=new Integer(measure).intValue();
		}

		if (type.equals("metric")) {
			int num_meters=int_measure / 100;
			int num_cm=int_measure % 100;
			result=num_meters+"m "+num_cm+"cm";
			return result;
		}
		if (type.equals("english")) {
			int num_ft=int_measure / 12;
			int num_in=int_measure % 12;
			result=num_ft+"ft "+num_in+"in";
			return result;
		}

		return result;
	}


	private void getDBInfo() {
		ResultSet rs=null;

		rs=active_db_connection.db_calls.getWorkOrderInfo(current_work_order.work_order_id);
		try {
			if (rs.first()) {
				alignComboBox(shop_box,rs.getString("Shop"));
				alignComboBox(service_box,rs.getString("Service Location"));
			}
		}catch (SQLException e) {
			System.err.println("Rider_Info_Panel: Problem retrieving data.");
			e.printStackTrace();
		}

		rs=null;
		rs=active_db_connection.db_calls.getRiderSettingsInfo(current_work_order.work_order_id);
		try {
			if (rs.first()) {
				String rider=null;
				String first_name=rs.getString("First Name");
				String last_name=rs.getString("Last Name");
				if ((first_name==null)||(last_name)==null) rider=null;
				else if (first_name.equals(last_name)) rider=first_name;//for the special riders baseline and stock
				else rider=last_name+", "+first_name;

				alignComboBox(rider_box,rider);
				phone1_field.setText(rs.getString("Rider Phone 1"));
				phone2_field.setText(rs.getString("Rider Phone 2"));
				alignComboBox(ability_box, rs.getString("Riding Ability"));
				String weight=(rs.getString("LB Weight")+"lbs --- "+rs.getString("KG Weight")+"kg");
				String height=convertToBigUnits(rs.getString("IN Height"),"english")+" --- "+
				convertToBigUnits(rs.getString("CM Height"),"metric");
				alignComboBox(weight_box,weight);
				alignComboBox(height_box,height);
			}
		}catch (SQLException e) {
			System.err.println("Rider_Info_Panel: Problem retrieving data.");
			e.printStackTrace();
		}
	}


	public void saveInfo(Active_Work_Order t_work_order) {
		active_db_connection.db_calls.saveRiderSettingsInfo(t_work_order.work_order_id,ref_rider.elementAt(rider_box.getSelectedIndex()),
				ref_ability.elementAt(ability_box.getSelectedIndex()),ref_weight.elementAt(weight_box.getSelectedIndex()),
				ref_height.elementAt(height_box.getSelectedIndex()), ref_shop.elementAt(shop_box.getSelectedIndex()),
				ref_service.elementAt(service_box.getSelectedIndex()));
	}
	
	private void maybeDisableGeneralInformation(){
		Settings_Frame current_setting_ref=Active_Work_GUIs.determineCurrentSettingsFrame(current_work_order);
		if (current_setting_ref!=null){
				    current_setting_ref.all_info.fork_info.component_info.maybeDisableGeneralInformation();
				    current_setting_ref.all_info.shock_info.component_info.maybeDisableGeneralInformation();
		}
	}

	public void actionPerformed(ActionEvent ae) {
		if (ae.getActionCommand().equals("rider action")) {
			maybeDisableGeneralInformation();
		}
	}


	
}//end class Rider_Info_Panel
