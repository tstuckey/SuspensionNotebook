package base;
import javax.swing.*;

import db_info.DB_Connection;

import java.awt.Color;
import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.sql.*;

public class Work_Order_Shipping_Address_Info implements ItemListener {
    JPanel shipping_address_panel;
    
    JPanel use_rider_address_panel;
    JPanel the_address_panel;
    GridBagConstraints class_c;
    
    JCheckBox use_rider_shipping_address;
    
    JTextField phone1_field;
    JTextField phone2_field;
    JTextField address1_field;
    JTextField address2_field;
    JTextField address3_field;
    JTextField city_field;
    JTextField state_field;
    JTextField country_field;
    JTextField zip_field;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Work_Order_Shipping_Address_Info(Active_Work_Order work_order, JPanel parent_panel,
            String ship_method_selected,GridBagConstraints parent_c, DB_Connection active_db_connection) {
        current_work_order=work_order;
        this.active_db_connection=active_db_connection;
        initializeClassVariables();
        setupTextFields();
        getDBInfo();
        disablePanelComponents();
        
        parent_panel.add(shipping_address_panel,parent_c);
    }
    
    
    private void initializeClassVariables()
    //This method is used instead of in the class variables declaration section because we need to call it again
    //when things are upate
    {
        shipping_address_panel=initializeJPanel("Shipping Address Info");
        use_rider_address_panel=initializeJPanel("");
        the_address_panel=initializeJPanel("");
        
        class_c = new GridBagConstraints();
        class_c.anchor=GridBagConstraints.NORTHWEST;
        class_c.weightx = 1.0;
        
        phone1_field = initializeJTextField(15);
        phone2_field = initializeJTextField(15);
        address1_field = initializeJTextField(25);
        address2_field = initializeJTextField(25);
        address3_field = initializeJTextField(25);
        city_field = initializeJTextField(25);
        state_field = initializeJTextField(25);
        country_field = initializeJTextField(15);
        zip_field = initializeJTextField(8);
        
        use_rider_shipping_address=new JCheckBox("Use Rider Address?");
    }
    public JTextField initializeJTextField(int cols) {
        JTextField tf = new JTextField(cols);
        return tf;
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
        use_rider_shipping_address.addItemListener(this);
        class_c.insets=new Insets(5,5,5,5);
        use_rider_address_panel.add(use_rider_shipping_address,class_c);
        
        addTextField(the_address_panel,"Phone 1",phone1_field,class_c,"continue row");
        addTextField(the_address_panel,"Phone 2",phone2_field,class_c,"end row");
        addTextField(the_address_panel,"Address",address1_field,class_c,"continue row");
        addTextField(the_address_panel,"Address",address2_field,class_c,"continue row");
        addTextField(the_address_panel,"Address",address3_field,class_c,"end row");
        addTextField(the_address_panel,"City",city_field,class_c,"continue row");
        addTextField(the_address_panel,"State",state_field,class_c,"continue row");
        addTextField(the_address_panel,"Country",country_field,class_c,"continue row");
        addTextField(the_address_panel,"Zip",zip_field,class_c,"continue row");
        
        class_c.gridwidth=GridBagConstraints.REMAINDER;
        shipping_address_panel.add(use_rider_address_panel,class_c);
        shipping_address_panel.add(the_address_panel,class_c);
    }
    
    private void addTextField(JPanel t_panel, String t_label, JTextField tf,
            GridBagConstraints c, String end_row) {
        //tf.setLineWrap(true);
        tf.setDisabledTextColor(Color.black);
        c.insets=new Insets(5,0,0,5);
        t_panel.add(new JLabel(t_label),c);
        
        c.insets=new Insets(0,0,0,5);
        if (end_row.equals("end row")) {
            c.gridwidth=GridBagConstraints.REMAINDER;
        }
        t_panel.add(tf, c);
        c.gridwidth=1; //reset gridwidth
    }
    
    private void getDBInfo() {
        ResultSet rs=null;
        rs=active_db_connection.db_calls.getShippingAddressInfo(current_work_order.work_order_id);
        
        try {
            if (rs.first()) {
                phone1_field.setText(rs.getString("phone1"));
                phone2_field.setText(rs.getString("phone2"));
                address1_field.setText(rs.getString("address1"));
                address2_field.setText(rs.getString("address2"));
                address3_field.setText(rs.getString("address3"));
                city_field.setText(rs.getString("City"));
                state_field.setText(rs.getString("State"));
                country_field.setText(rs.getString("Country"));
                zip_field.setText(rs.getString("Zip"));
                
                use_rider_shipping_address.removeItemListener(this);
                if (rs.getInt("use_rider_shipping_address")==1) use_rider_shipping_address.setSelected(true);
                if (rs.getInt("use_rider_shipping_address")==0) use_rider_shipping_address.setSelected(false);
                use_rider_shipping_address.addItemListener(this);
                
            }
        }catch (SQLException e) {
            System.err.println("Work_Order_Shipping_Address_Info: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    private void getRiderAddressInfo()
    //This method is only called when the user selects the checkbox to use the address of the rider associated with
    //the active work order
    {
        ResultSet rs=null;
        rs=active_db_connection.db_calls.getRiderAddressInfo(current_work_order.work_order_id);
        
        try {
            if (rs.first()) {
                phone1_field.setText(rs.getString("phone1"));
                phone2_field.setText(rs.getString("phone2"));
                address1_field.setText(rs.getString("address1"));
                address2_field.setText(rs.getString("address2"));
                address3_field.setText(rs.getString("address3"));
                city_field.setText(rs.getString("City"));
                state_field.setText(rs.getString("State"));
                country_field.setText(rs.getString("Country"));
                zip_field.setText(rs.getString("Zip"));
            }
        }catch (SQLException e) {
            System.err.println("Work_Order_Shipping_Address_Info: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    public void enablePanelComponents() {
        use_rider_shipping_address.setEnabled(true);
        
        if (use_rider_shipping_address.isSelected()) return;
        
        enableTextField(phone1_field);
        enableTextField(phone2_field);
        enableTextField(address1_field);
        enableTextField(address2_field);
        enableTextField(address3_field);
        enableTextField(city_field);
        enableTextField(state_field);
        enableTextField(country_field);
        enableTextField(zip_field);
    }
    
    public void enableTextField(JTextField tf) {
        tf.setEnabled(true);
        tf.setBackground(Color.white);
    }
    
    public void disableTextField(JTextField tf) {
        tf.setEnabled(false);
        tf.setBackground(Color.lightGray);
    }
    
    public void disablePanelComponents() {
        use_rider_shipping_address.setEnabled(false);
        
        disableTextField(phone1_field);
        disableTextField(phone2_field);
        disableTextField(address1_field);
        disableTextField(address2_field);
        disableTextField(address3_field);
        disableTextField(city_field);
        disableTextField(state_field);
        disableTextField(country_field);
        disableTextField(zip_field);
    }
    
    public void clearTextFields() {
        phone1_field.setText("");
        phone2_field.setText("");
        address1_field.setText("");
        address2_field.setText("");
        address3_field.setText("");
        city_field.setText("");
        state_field.setText("");
        country_field.setText("");
        zip_field.setText("");
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        Integer use_rider_shipping_address_status=0;
        if (use_rider_shipping_address.isSelected()) use_rider_shipping_address_status=1;
        
        active_db_connection.db_calls.saveShippingAddressInfo(t_work_order.work_order_id,
                use_rider_shipping_address_status,
                phone1_field.getText(),
                phone2_field.getText(),
                address1_field.getText(),
                address2_field.getText(),
                address3_field.getText(),
                city_field.getText(),
                state_field.getText(),
                country_field.getText(),
                zip_field.getText());
    }
    
    public void itemStateChanged(ItemEvent e) {
        //if the user checks this box populate it with the address on file for the rider
        if (e.getStateChange()==ItemEvent.SELECTED) {
            disablePanelComponents();
            clearTextFields();
            getRiderAddressInfo();
            
            //This gets the info from the db for the rider, but the checkbox may not have been checked
            //the last time the info was stored, but the user wants to use the rider info, so we check it
            //for them
            use_rider_shipping_address.removeItemListener(this);
            use_rider_shipping_address.setSelected(true);
            use_rider_shipping_address.addItemListener(this);
        }
        if (e.getStateChange()==ItemEvent.DESELECTED) {
            enablePanelComponents();
            clearTextFields();
        }
        use_rider_shipping_address.setEnabled(true);
    }
    
    
}//end class Work_Order_Shipping_Address_Info

