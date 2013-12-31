package base;
import javax.swing.*;


import db_info.DB_Connection;

import java.awt.Color;
import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.sql.*;

public class Work_Order_Shipping_Account_Info implements ItemListener {
    JPanel shipping_account_panel;
    
    JPanel use_account_panel;
    JPanel the_account_panel;
    GridBagConstraints class_c;
    
    JCheckBox use_shipping_acct;
    
    JTextField shipping_vendor_area;
    JTextField account_num;
    
    String shipping_vendor_stored_in_db;
    String shipping_vendor;

    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Work_Order_Shipping_Account_Info(Active_Work_Order work_order, JPanel parent_panel,
            String ship_method_selected,GridBagConstraints parent_c, DB_Connection active_db_connection) {
        current_work_order=work_order;
        this.active_db_connection=active_db_connection;
        initializeClassVariables();
        setupTextFields();
        getDBInfo();
        determineShippingVendor(ship_method_selected);
        disablePanelComponents();
        
        parent_panel.add(shipping_account_panel,parent_c);
    }
    
    
    private void initializeClassVariables()
    //This method is used instead of in the class variables declaration section because we need to call it again
    //when things are update
    {
        shipping_account_panel=initializeJPanel("Shipping Account Info");
        use_account_panel=initializeJPanel("");
        the_account_panel=initializeJPanel("");
        
        class_c = new GridBagConstraints();
        class_c.anchor=GridBagConstraints.NORTHWEST;
        
        shipping_vendor="";
        shipping_vendor_stored_in_db="";
        shipping_vendor_area = initializeJTextField(15);
        account_num= initializeJTextField(15);
        
        use_shipping_acct=new JCheckBox("Use Shipping Account?");
    }
    public JTextField initializeJTextField(int cols) {
        JTextField tf = new JTextField(cols);
        return tf;
    } 
    
    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }
    
    private void setupTextFields() {
        use_shipping_acct.addItemListener(this);
        class_c.insets=new Insets(5,35,5,10);
        use_account_panel.add(use_shipping_acct,class_c);
        
        addTextField(the_account_panel, "Shipping Company",shipping_vendor_area,10,class_c);
        addTextField(the_account_panel, "Account Number",account_num,16,class_c);
        
        class_c.gridwidth=GridBagConstraints.REMAINDER;
        shipping_account_panel.add(use_account_panel,class_c);
        shipping_account_panel.add(the_account_panel,class_c);
    }
    
    private void addTextField(JPanel t_panel, String t_label, JTextField tf,
                              Integer cols,GridBagConstraints c) {
        tf.setBorder( BorderFactory.createLineBorder(Color.white));
        tf.setDisabledTextColor(Color.black);
        tf.setColumns(cols);
        c.insets=new Insets(5,0,0,5);
        t_panel.add(new JLabel(t_label),c);
        
        c.insets=new Insets(0,0,0,5);
        c.gridwidth=GridBagConstraints.REMAINDER;
        t_panel.add(tf, c);
        c.gridwidth=1; //reset gridwidth
    }
    
    private void getDBInfo() {
        ResultSet rs=null;
        rs=active_db_connection.db_calls.getShippingAcctInfo(current_work_order.work_order_id);
        
        try {
            if (rs.first()) {
                //store the vendor who is stored in the database
		//this value is used to determine whether the acct information
		//should be pulled again as the user is toggling through the
		//shipping possibilities
                shipping_vendor_stored_in_db=rs.getString("shipping_vendor");

                shipping_vendor_area.setText(rs.getString("shipping_vendor"));
                account_num.setText(rs.getString("account_number"));
                
                use_shipping_acct.removeItemListener(this);
                if (rs.getInt("use_shipping_account")==1) {
                    use_shipping_acct.setSelected(true);
                    enablePanelComponents();
                }
                if (rs.getInt("use_shipping_account")==0) {
                    use_shipping_acct.setSelected(false);
                }
                use_shipping_acct.addItemListener(this);
            }
        }catch (SQLException e) {
            System.err.println("Work_Order_Shipping_Account_Info: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    public void determineShippingVendor(String ship_method_selected) {
        if (ship_method_selected.contains("UPS")) shipping_vendor="UPS";
           else if (ship_method_selected.contains("Fed")) shipping_vendor="FedEx";
                else shipping_vendor="";
        String previous_shipping_vendor=shipping_vendor_area.getText();
        
        //if the shipping vendors have changed, clear the account_num area
        if ((!previous_shipping_vendor.equals(""))&&
                (!previous_shipping_vendor.equals(shipping_vendor))) {
            account_num.setText("");
        }

        //if the shipping vendors have not changed, pull the info again to populate the
	//shipping account info 
        Boolean use_shipping_account=use_shipping_acct.isSelected();
        if ((shipping_vendor_stored_in_db!=null)&&
	    (!shipping_vendor_stored_in_db.equals(""))&&
            (shipping_vendor_stored_in_db.equals(shipping_vendor))  ) {
            getDBInfo(); 
        }
        if (use_shipping_account==true) use_shipping_acct.setSelected(true); 
        if (use_shipping_account==false) use_shipping_acct.setSelected(false); 

        shipping_vendor_area.setText(shipping_vendor);
        shipping_account_panel.repaint();
    }
    
    public void enablePanelComponents() {
        use_shipping_acct.setEnabled(true);
        if (use_shipping_acct.isSelected()) enableTextField(account_num);
    }
    
    public void disablePanelComponents() {
        use_shipping_acct.setEnabled(false);
        disableTextField(shipping_vendor_area);
        disableTextField(account_num);
    }
    
    private void enableTextField(JTextField tf) {
        tf.setEnabled(true);
        tf.setBackground(Color.white);
    }
    
    private void disableTextField(JTextField tf) {
        tf.setEnabled(false);
        tf.setBackground(Color.lightGray);
    }
    
    
    public void clearTextFields() {
        account_num.setText("");
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        Integer use_shipping_acct_status=0;
        if (use_shipping_acct.isSelected()) use_shipping_acct_status=1;
        
        active_db_connection.db_calls.saveShippingAcctInfo(t_work_order.work_order_id,
                use_shipping_acct_status,
                shipping_vendor_area.getText().trim(),
                account_num.getText().trim());
    }

    public void itemStateChanged(ItemEvent e) {
        if (e.getStateChange()==ItemEvent.SELECTED) {
            enablePanelComponents();
        }
        if (e.getStateChange()==ItemEvent.DESELECTED) {
            disablePanelComponents();
            clearTextFields();
        }
        use_shipping_acct.setEnabled(true);
    }
    
    
}//end class Work_Order_Shipping_Account_Info

