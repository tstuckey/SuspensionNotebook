package base;
import java.util.*;
import javax.swing.*;

import db_info.DB_Connection;

import java.awt.Component;
import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.sql.*;

public class Work_Order_Payment_Info implements ItemListener {
    JPanel payment_methods_panel;
    JPanel checkbox_panel;
    GridBagConstraints class_c;
    
    Work_Order_Credit_Card_Info credit_card_info;
    
    Vector<String> all_payment_methods;
    Vector<Integer> all_payment_methods_ref;
    
    Vector<String> valid_payment_descriptions;
    
    Vector<JCheckBox> displayed_payment_descriptions;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Work_Order_Payment_Info(Active_Work_Order work_order, JPanel parent_panel,
            GridBagConstraints parent_c, DB_Connection active_db_connection) {
        current_work_order=work_order;
        
        this.active_db_connection=active_db_connection;
        initializeClassVariables();
        getPaymentInfo(current_work_order);
        createServicesCheckBox();
        
        credit_card_info=new Work_Order_Credit_Card_Info(current_work_order,payment_methods_panel,class_c, active_db_connection);
        disablePanelComponents();
        
        parent_panel.add(payment_methods_panel,parent_c);
    }
    
    private void initializeClassVariables()
    //This method is used instead of in the class variables declaration section because we need to call it again
    //when things are upate
    {
        payment_methods_panel=initializeJPanel("");
        checkbox_panel=initializeJPanel("Method of Payment");
        
        class_c = new GridBagConstraints();
        class_c.anchor=GridBagConstraints.NORTHWEST;
        
        all_payment_methods=new Vector<String>();
        all_payment_methods_ref = new Vector<Integer>();
        
        valid_payment_descriptions=new Vector<String>();
        
        displayed_payment_descriptions=new Vector<JCheckBox>();
        
    }
    
    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }
    
    
    
    private void getPaymentInfo(Active_Work_Order work_order) {
        ResultSet rs=null;
        
        rs=active_db_connection.db_calls.getPaymentMethod(work_order.work_order_id);
        
        try {
            if (rs.first()) {
                do
                {
                    valid_payment_descriptions.add(rs.getString("Description"));//add to the class Vector
                }while (rs.next());
            }
        }catch (SQLException e) {
            System.err.println("Work_Order_Payment_Info: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    private void createServicesCheckBox() {
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        c.gridwidth=GridBagConstraints.REMAINDER;
        
        all_payment_methods=active_db_connection.db_calls.getAllValues("payment_method","description","description",all_payment_methods_ref);
        
        for (int i=0;i<all_payment_methods.size();i++) {
            JCheckBox t_checkbox=new JCheckBox(all_payment_methods.elementAt(i));
            displayed_payment_descriptions.add(t_checkbox);
            t_checkbox.addItemListener(this);
            checkbox_panel.add(t_checkbox,c);
            //
            //see if this finance entry uses this payment method
            //if the "valid_payment_descriptions" vector contains the payment method in the vector "all_payment_methods"
            //at this point, mark the box with a check mark and add the textbox with the corresponding description
            int prod_index=valid_payment_descriptions.indexOf(all_payment_methods.elementAt(i));
            if (prod_index>=0) {
                t_checkbox.setSelected(true);//mark it with a checkmark
            }
        }
        payment_methods_panel.add(checkbox_panel, class_c);
    }
    
    public void enablePanelComponents() {
        Component[] panel_components;
        panel_components=checkbox_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(true);
        }
        
        credit_card_info.enablePanelComponents();
    }
    
    public void disablePanelComponents() {
        Component[] panel_components;
        panel_components=checkbox_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(false);
        }
        
        credit_card_info.disablePanelComponents();
    }
    
    /** Listens to the check boxes. */
    public void itemStateChanged(ItemEvent e) {
        Object source = e.getItemSelectable();
        if (credit_card_info !=null) {
            String checkbox_name=((JCheckBox)source).getText();
            if ( (checkbox_name.startsWith("Credit"))&&
                    (e.getStateChange()==ItemEvent.SELECTED)) {
                credit_card_info.enablePanelComponents();
            }
            if ( (checkbox_name.startsWith("Credit"))&&
                    (e.getStateChange()==ItemEvent.DESELECTED)) {
                credit_card_info.disablePanelComponents();
                credit_card_info.clearTextFields();
            }
        }
    }
    
    
    public void saveInfo(Active_Work_Order t_work_order) {
        //Before we add new additional prodcts information, we need to remove the old associations for this setting
    	active_db_connection.db_calls.removePaymentMethodFromWorkOrder(t_work_order.work_order_id);
        
        for (int i=0;i<displayed_payment_descriptions.size();i++) {
            if (displayed_payment_descriptions.elementAt(i).isSelected()) {
                //for the next call, remember the displayed_payment_descriptions and the all_payment_methods_ref vectors are both referencing
                //the same location; displayed_payment_descriptions references the JCheckBox object and all_payment_methods_ref references the
                //db identifers for the String displayed beside the JCheckBox
            	active_db_connection.db_calls.savePaymentMethod(t_work_order.work_order_id, all_payment_methods_ref.elementAt(i));
            }
        }
        credit_card_info.saveInfo(t_work_order);
    }
    
}//end class Work_Order_Payment_Info

