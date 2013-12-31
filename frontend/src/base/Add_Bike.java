package base;
import javax.swing.*;

import db_info.DB_Connection;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.util.Vector;
import java.sql.*;

public class Add_Bike implements ActionListener {
	GridBagConstraints class_c;
	JComboBox existing_customers_box;
    Vector<Integer> ref_existing_customers;
    
    //JTextField existing_support_id_area;
    JTextField existing_phone1_area;
    JTextField existing_phone2_area;
    JTextField existing_address1_area;
    JTextField existing_address2_area;
    JTextField existing_address3_area;
    JTextField existing_city_area;
    JTextField existing_state_area;
    JTextField existing_country_area;
    JTextField existing_zip_area;
    JButton edit_button;
    JButton update_button;
    JButton cancel_button;
    
    JTextField new_first_name_area;
    JTextField new_last_name_area;
    //JTextField new_support_id_area;
    JTextField new_phone1_area;
    JTextField new_phone2_area;
    JTextField new_address1_area;
    JTextField new_address2_area;
    JTextField new_address3_area;
    JTextField new_city_area;
    JTextField new_state_area;
    JTextField new_country_area;
    JTextField new_zip_area;
    JButton add_button;

    DB_Connection active_db_connection;
    
    public Add_Bike(JPanel parent_panel,DB_Connection active_db_connection) {
    	initializeClassVariables();
    	this.active_db_connection=active_db_connection;
        setupExistingCustomerInfoArea(parent_panel,class_c);
        class_c.gridy=1;
        setupNewCustomerInfoArea(parent_panel,class_c);
    }//end constructor
    
    public void initializeClassVariables(){
    	class_c=new GridBagConstraints();
    	existing_customers_box=new JComboBox();
        ref_existing_customers=new Vector<Integer>();
        
        //existing_support_id_area = Initialize_JTextArea();
        existing_phone1_area = initializeJTextField(10);
        existing_phone2_area = initializeJTextField(10);
        existing_address1_area = initializeJTextField(10);
        existing_address2_area = initializeJTextField(10);
        existing_address3_area = initializeJTextField(10);
        existing_city_area = initializeJTextField(10);
        existing_state_area = initializeJTextField(10);
        existing_country_area = initializeJTextField(10);
        existing_zip_area = initializeJTextField(10);
        
        new_first_name_area = initializeJTextField(10);
        new_last_name_area = initializeJTextField(10);
        //new_support_id_area = Initialize_JTextField();
        new_phone1_area = initializeJTextField(10);
        new_phone2_area = initializeJTextField(10);
        new_address1_area = initializeJTextField(10);
        new_address2_area = initializeJTextField(10);
        new_address3_area = initializeJTextField(10);
        new_city_area = initializeJTextField(10);
        new_state_area = initializeJTextField(10);
        new_country_area = initializeJTextField(10);
        new_zip_area = initializeJTextField(10);    	
    }
    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }    
    
    public JTextField initializeJTextField(int cols) {
        JTextField tf = new JTextField();
        tf.setColumns(cols);
        return tf;
    }  
    
    public void addTextField(JPanel t_panel, String t_label, JTextField t_field,
            GridBagConstraints c, String end_row) {
        JPanel local_panel=new JPanel();
              
        c.insets=new Insets(5,0,0,5);
        local_panel.add(new JLabel(t_label),c);
        
        c.insets=new Insets(0,0,0,5);
        if (end_row.equals("end row")) {
            c.gridwidth=GridBagConstraints.REMAINDER;
        }
        
        local_panel.add(t_field, c);
        t_panel.add(local_panel,c);
        c.gridwidth=1; //reset gridwidth
        c.insets=new Insets(0,0,0,0);
    }    
    
    public void setupExistingCustomerInfoArea(JPanel parent_panel, GridBagConstraints parent_c) {
        JPanel existing_customer_panel=initializeJPanel("Existing Customers");

        GridBagConstraints c = new GridBagConstraints();
        setupExistingCustomerBox(existing_customer_panel,c);
        setupExistingCustomerAttributes(existing_customer_panel,c);
        
        parent_panel.add(existing_customer_panel,parent_c);
    }
    

    
    public void setupExistingCustomerBox(JPanel parent_panel, GridBagConstraints parent_c) {
        JPanel t_panel=initializeJPanel("");
        GridBagConstraints c = new GridBagConstraints();
        ResultSet rs=null;
        rs =active_db_connection.db_calls.getRiderNames();
        try {
            if (rs.first()) {
				do
				{
                 ref_existing_customers.add(rs.getInt("row_id"));
                 existing_customers_box.addItem(rs.getString("name"));
				}while (rs.next());       
            }
        }catch (SQLException e) {
            System.err.println("Add_Customer: Problem retrieving data.");
            e.printStackTrace();
        }      
        
        if (ref_existing_customers.size()>0) {
            existing_customers_box.setSelectedIndex(0);
        }
        existing_customers_box.setActionCommand("old customer action");
        existing_customers_box.addActionListener(this);
        
        c.insets=new Insets(5,0,0,5);
        t_panel.add(new JLabel("Customer Name"),parent_c);
        
        c.insets=new Insets(0,0,0,5);
        c.gridwidth=GridBagConstraints.REMAINDER;
        t_panel.add(existing_customers_box,c);
        
        parent_panel.add(t_panel,parent_c);
    }
    
    public void setupExistingCustomerAttributes(JPanel parent_panel, GridBagConstraints parent_c) {
        JPanel rider_attribs=initializeJPanel("");
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
                
        //Add_TextArea(rider_attribs,"Support ID",existing_support_id_area,c,"continue row");
        addTextField(rider_attribs," Phone 1",existing_phone1_area,c,"continue row");
        addTextField(rider_attribs," Phone 2",existing_phone2_area,c,"end row");
        addTextField(rider_attribs,"Address",existing_address1_area,c,"continue row");
        addTextField(rider_attribs,"Address",existing_address2_area,c,"continue row");
        addTextField(rider_attribs,"Address",existing_address3_area,c,"end row");
        addTextField(rider_attribs,"   City",existing_city_area,c,"continue row");
        addTextField(rider_attribs,"  State",existing_state_area,c,"continue row");
        addTextField(rider_attribs,"Country",existing_country_area,c,"end row");
        addTextField(rider_attribs,"    Zip",existing_zip_area,c,"continue row");
        
        JPanel update_panel=setupUpdateButtons();
        rider_attribs.add(update_panel, c);
        parent_panel.add(rider_attribs, parent_c);
        updateTextFields(); //pull the address info for the selected rider
        setEditableExistingTextFields(false);//make the address uneditable to start
    }
    
    
    private JPanel setupUpdateButtons(){
    	GridBagConstraints c=new GridBagConstraints();
    	//c.weightx = 1.0;
    	JPanel update_panel=initializeJPanel("");
        edit_button=new JButton("Edit");
        edit_button.setActionCommand("edit address");
        edit_button.addActionListener(this);
        edit_button.setEnabled(true);
        
        update_button=new JButton("Update Address for this Rider");
        update_button.setActionCommand("update address");
        update_button.addActionListener(this);
        update_button.setEnabled(false);
        
        cancel_button=new JButton("Cancel");
        cancel_button.setActionCommand("cancel edit");
        cancel_button.addActionListener(this);
        cancel_button.setEnabled(false);
        
        update_panel.add(edit_button, c);
        update_panel.add(update_button, c);
        update_panel.add(cancel_button, c);	
        
        return update_panel;
    }
    
    public void setupNewCustomerInfoArea(JPanel parent_panel, GridBagConstraints parent_c) {
        JPanel new_customer_panel=initializeJPanel("New Customers");

        GridBagConstraints c = new GridBagConstraints();
        setupNewCustomerArea(new_customer_panel,c);
        setupNewCustomerAttributes(new_customer_panel,c);
        
        parent_panel.add(new_customer_panel,parent_c);
    }
    
    public void setupNewCustomerArea(JPanel parent_panel, GridBagConstraints parent_c) {
        JPanel t_panel=initializeJPanel("");
        GridBagConstraints c = new GridBagConstraints();
               
        addTextField(t_panel,"First Name",new_first_name_area,c,"end row");
        addTextField(t_panel,"Last Name",new_last_name_area,c,"continue row");
      
        parent_panel.add(t_panel, parent_c);
    }
    
    public void setupNewCustomerAttributes(JPanel parent_panel, GridBagConstraints parent_c) {
        JPanel rider_attribs=initializeJPanel("");
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        //Add_TextField(rider_attribs,"Support ID",new_support_id_area,c,"continue row");
        addTextField(rider_attribs,"Phone 1",new_phone1_area,c,"continue row");
        addTextField(rider_attribs,"Phone 2",new_phone2_area,c,"end row");
        addTextField(rider_attribs,"Address",new_address1_area,c,"continue row");
        addTextField(rider_attribs,"Address",new_address2_area,c,"continue row");
        addTextField(rider_attribs,"Address",new_address3_area,c,"end row");
        addTextField(rider_attribs,"City",new_city_area,c,"continue row");
        addTextField(rider_attribs,"State",new_state_area,c,"continue row");
        addTextField(rider_attribs,"Country",new_country_area,c,"end row");
        addTextField(rider_attribs,"Zip",new_zip_area,c,"continue row");
        
        add_button=new JButton("Add Rider and Address");
        add_button.setActionCommand("add new rider and address");
        add_button.addActionListener(this);
        
        rider_attribs.add(add_button, c);

        parent_panel.add(rider_attribs, parent_c);
    }  
    private void setEditableExistingTextFields(Boolean state) {
        existing_phone1_area.setEditable(state);
        existing_phone2_area.setEditable(state);
        existing_address1_area.setEditable(state);
        existing_address2_area.setEditable(state);
        existing_address3_area.setEditable(state);
        existing_city_area.setEditable(state);
        existing_state_area.setEditable(state);
        existing_country_area.setEditable(state);
        existing_zip_area.setEditable(state);
    }
    
    private void clearExistingTextFields() {
        existing_phone1_area.setText("");
        existing_phone2_area.setText("");
        existing_address1_area.setText("");
        existing_address2_area.setText("");
        existing_address3_area.setText("");
        existing_city_area.setText("");
        existing_state_area.setText("");
        existing_country_area.setText("");
        existing_zip_area.setText("");
    }
    private void clearNewTextFields() {
        new_first_name_area.setText("");
        new_last_name_area.setText("");
        new_phone1_area.setText("");
        new_phone2_area.setText("");
        new_address1_area.setText("");
        new_address2_area.setText("");
        new_address3_area.setText("");
        new_city_area.setText("");
        new_state_area.setText("");
        new_country_area.setText("");
        new_zip_area.setText("");
    }    
    private void updateTextFields() {
        ResultSet rs=null;
        
        if (ref_existing_customers.size()==0)return;//don't try to pull info if they're aren't any customers
        Integer rider_id=ref_existing_customers.elementAt(existing_customers_box.getSelectedIndex());
        clearExistingTextFields();
        
        //need to make the following call dynamic for active rider_id
        rs=active_db_connection.db_calls.getRiderInfo(rider_id);
        try {
            if (rs.first()) {
                existing_phone1_area.setText(rs.getString("Phone at Address"));
                existing_phone2_area.setText(rs.getString("Alt Phone"));
                existing_address1_area.setText(rs.getString("Address 1"));
                existing_address2_area.setText(rs.getString("Address 2"));
                existing_address3_area.setText(rs.getString("Address 3"));
                existing_city_area.setText(rs.getString("City"));
                existing_state_area.setText(rs.getString("State"));
                existing_country_area.setText(rs.getString("Country"));
                existing_zip_area.setText(rs.getString("Zip"));
            }
        }catch (SQLException e) {
            System.err.println("Add_Customer: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    private Integer createAddress() {
        ResultSet rs=null;
        int new_address=0;
        rs=active_db_connection.db_calls.addAddress(new_address1_area.getText(), new_address2_area.getText(), new_address3_area.getText(), 
        						new_city_area.getText(), new_state_area.getText(),new_country_area.getText(), 
        						new_zip_area.getText(), new_phone1_area.getText(), new_phone2_area.getText());
         try {
            if (rs.first()) {
                new_address=rs.getInt("new_address");
                }
         }catch (SQLException e) {
         System.err.println("Add_Address: Problem retrieving data.");
         e.printStackTrace();
         }
         return new_address;
    }    

    private void createRider(Integer address_ref) {
    	active_db_connection.db_calls.addRider(new_first_name_area.getText(), new_last_name_area.getText(), address_ref); 
    }    
    
    private void updateRiderAddress(){
    	active_db_connection.db_calls.updateAddress(ref_existing_customers.elementAt(existing_customers_box.getSelectedIndex()),
    			existing_phone1_area.getText(), existing_phone2_area.getText(), existing_address1_area.getText(),
    			existing_address2_area.getText(), existing_address3_area.getText(), existing_city_area.getText(),
    			existing_state_area.getText(), existing_country_area.getText(), existing_zip_area.getText());
    }
    
    private void refreshAfterNewRider(){
    	clearNewTextFields();
    	existing_customers_box.removeActionListener(this);
    	
    	ref_existing_customers.removeAllElements();
        existing_customers_box.removeAllItems();
    
        ResultSet rs=null;
        //get the new names
        rs =active_db_connection.db_calls.getRiderNames();
        try {
            if (rs.first()) {
				do
				{
                 ref_existing_customers.add(rs.getInt("row_id"));
                 existing_customers_box.addItem(rs.getString("name"));
				}while (rs.next());       
            }
        }catch (SQLException e) {
            System.err.println("Add_Customer: Problem retrieving data.");
            e.printStackTrace();
        }      
        existing_customers_box.addActionListener(this);
    }
    
    public void actionPerformed(ActionEvent e) {
        if ((e.getActionCommand()).equals("add new rider and address")) {
            createRider(createAddress());//create the address, create the rider, and associate the two
            refreshAfterNewRider();
        }
        if ((e.getActionCommand()).equals("update address")) {
            updateRiderAddress();
        }
        if ((e.getActionCommand()).equals("old customer action")) {
        	updateTextFields();
        }
        
        if ((e.getActionCommand()).equals("edit address")) {
        	setEditableExistingTextFields(true);
        	edit_button.setEnabled(false);
        	cancel_button.setEnabled(true);
        	update_button.setEnabled(true);
        }        
        if ((e.getActionCommand()).equals("cancel edit")) {
        	setEditableExistingTextFields(false);
        	edit_button.setEnabled(true);
        	cancel_button.setEnabled(false);
        	update_button.setEnabled(false);            
        }        
        if ((e.getActionCommand()).equals("update address")) {
        	setEditableExistingTextFields(false);
        	edit_button.setEnabled(true);
        	cancel_button.setEnabled(false);
        	update_button.setEnabled(false);
        }        

    }//end method actionPerformed
    
    
}//end class Add_Customer

