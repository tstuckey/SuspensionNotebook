package base;
import java.util.*;
import javax.swing.*;

import db_info.DB_Connection;

import java.awt.Component;
import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.sql.*;

public class Work_Order_Shipping_Info implements ItemListener {
    JPanel shipping_methods_panel;
    JPanel checkbox_panel;
    GridBagConstraints class_c;
    
    Work_Order_Shipping_Account_Info shipping_account_info;
    Work_Order_Shipping_Address_Info shipping_address_info;
    
    Vector<String> all_shipping_methods;
    Vector<Integer> all_shipping_methods_ref;
    
    Vector<String> valid_shipping_descriptions;
    
    Vector<JCheckBox> displayed_shipping_descriptions;
    
    String ship_method_selected;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Work_Order_Shipping_Info(Active_Work_Order work_order, JPanel parent_panel,
            GridBagConstraints parent_c, DB_Connection active_db_connection) {
        current_work_order=work_order;
        
        this.active_db_connection=active_db_connection;
        initializeClassVariables();
        getShippingInfo(current_work_order);
        createServicesCheckBox();
        
        class_c.gridwidth=GridBagConstraints.REMAINDER;
        shipping_account_info=new Work_Order_Shipping_Account_Info(current_work_order,shipping_methods_panel,
                ship_method_selected,class_c, active_db_connection);
        shipping_address_info=new Work_Order_Shipping_Address_Info(current_work_order,shipping_methods_panel,
                ship_method_selected,class_c,active_db_connection);
        verifyAcctInfo();//this is only needed upon instantiation because the acct information
        //is instantiated after the checkboxes are created
        disablePanelComponents();
        
        parent_panel.add(shipping_methods_panel,parent_c);
    }
    
    private void initializeClassVariables()
    //This method is used instead of in the class variables declaration section because we need to call it again
    //when things are updated
    {
        shipping_methods_panel=initializeJPanel("");
        checkbox_panel=initializeJPanel("Method of Shipping");
        
        class_c = new GridBagConstraints();
        class_c.anchor=GridBagConstraints.NORTHWEST;
        
        all_shipping_methods=new Vector<String>();
        all_shipping_methods_ref = new Vector<Integer>();
        
        valid_shipping_descriptions=new Vector<String>();
        
        ship_method_selected="";
        
        displayed_shipping_descriptions=new Vector<JCheckBox>();
    }
    
    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }
    
    
    
    private void getShippingInfo(Active_Work_Order work_order) {
        ResultSet rs=null;
        
        rs=active_db_connection.db_calls.getShippingInfo(work_order.work_order_id);
        
        try {
            if (rs.first()) {
                do
                {
                    valid_shipping_descriptions.add(rs.getString("Description"));//add to the class Vector
                }while (rs.next());
            }
        }catch (SQLException e) {
            System.err.println("Work_Order_Shipping_Info: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    private void createServicesCheckBox() {
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        c.weightx = 1.0;
        //c.gridwidth=GridBagConstraints.REMAINDER;
        
        all_shipping_methods=active_db_connection.db_calls.getAllValues("ship_method","description","description",all_shipping_methods_ref);
        
        for (int i=0;i<all_shipping_methods.size();i++) {
            JCheckBox t_checkbox=new JCheckBox(all_shipping_methods.elementAt(i));
            displayed_shipping_descriptions.add(t_checkbox);
            t_checkbox.addItemListener(this);
            if ((i+1)%4==0)
            	c.gridwidth=GridBagConstraints.REMAINDER;
            else
            	c.gridwidth=1;
            checkbox_panel.add(t_checkbox,c);
            //
            //see if this finance entry uses this payment method
            //if the "valid_shipping_descriptions" vector contains the payment method in the vector "all_shipping_methods"
            //at this point, mark the box with a check mark and add the textbox with the corresponding description
            int prod_index=valid_shipping_descriptions.indexOf(all_shipping_methods.elementAt(i));
            if (prod_index>=0) {
                t_checkbox.setSelected(true);//mark it with a checkmark
                ship_method_selected=t_checkbox.getText();
            }
        }
        shipping_methods_panel.add(checkbox_panel, class_c);
    }
    
    public void enablePanelComponents() {
        Component[] panel_components;
        panel_components=checkbox_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(true);
        }
        
        shipping_account_info.enablePanelComponents();
        shipping_address_info.enablePanelComponents();
    }
    
    public void disablePanelComponents() {
        Component[] panel_components;
        panel_components=checkbox_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(false);
        }
        
        shipping_account_info.disablePanelComponents();
        shipping_address_info.disablePanelComponents();
    }
    
    public void verifyAcctInfo() {
        for (int i=0;i<displayed_shipping_descriptions.size();i++) {
            JCheckBox ck_box=(displayed_shipping_descriptions.elementAt(i));
            //if the checkbox for "Pickup" is active, then disable the extra acct info panel
            //and shipping address panel
            if ( (ck_box.getText().startsWith("Pickup"))&&
                    (ck_box.isSelected())) {
                shipping_account_info.disablePanelComponents();
                shipping_account_info.clearTextFields();
                
                shipping_address_info.disablePanelComponents();
                shipping_address_info.clearTextFields();
                shipping_address_info.use_rider_shipping_address.setSelected(false);
            }
        }
    }
    
    /** Listens to the check boxes. */
    public void itemStateChanged(ItemEvent e) {
        Object source = e.getItemSelectable();
        
        String selected_checkbox_name=((JCheckBox)source).getText();
        ship_method_selected=selected_checkbox_name;
        
        if ((shipping_account_info !=null)&&
                (shipping_address_info !=null)) {
            if (e.getStateChange()==ItemEvent.SELECTED) {
                shipping_account_info.determineShippingVendor(ship_method_selected);//update the vendor string in
                //shipping account area
                shipping_address_info.enablePanelComponents();
            }
            if ( (selected_checkbox_name.startsWith("Pickup"))&&
                    (e.getStateChange()==ItemEvent.DESELECTED)) {
                shipping_account_info.enablePanelComponents();
                shipping_address_info.enablePanelComponents();
            }
            if ( (selected_checkbox_name.startsWith("Pickup"))&&
                    (e.getStateChange()==ItemEvent.SELECTED)) {
                shipping_account_info.use_shipping_acct.setSelected(false);
                shipping_account_info.disablePanelComponents();
                shipping_account_info.clearTextFields();
                
                shipping_address_info.use_rider_shipping_address.setSelected(false);
                shipping_address_info.disablePanelComponents();
                shipping_address_info.clearTextFields();
            }
        }
        
        //set all the other boxes to false
        for (int i=0;i<displayed_shipping_descriptions.size();i++) {
            JCheckBox ck_box=(displayed_shipping_descriptions.elementAt(i));
            if ( !(selected_checkbox_name.equals(ck_box.getText()))&&
                    (e.getStateChange()==ItemEvent.SELECTED)) {
                ck_box.setSelected(false);
            }
        }
    }
    
    
    public void saveInfo(Active_Work_Order t_work_order) {
        //this loop is a holdover from another type, it supports multiple selections of checkboxes
        for (int i=0;i<displayed_shipping_descriptions.size();i++) {
            if (displayed_shipping_descriptions.elementAt(i).isSelected()) {
                //for the next call, remember the displayed_shipping_descriptions and the all_shipping_methods_ref vectors are both referencing
                //the same location; displayed_shipping_descriptions references the JCheckBox object and all_shipping_methods_ref references the
                //db identifers for the String displayed beside the JCheckBox
            	active_db_connection.db_calls.saveShippingInfo(t_work_order.work_order_id, all_shipping_methods_ref.elementAt(i));
            }
        }
        shipping_account_info.saveInfo(t_work_order);
        shipping_address_info.saveInfo(t_work_order);
    }
    
}//end class Work_Order_Shipping_Info

