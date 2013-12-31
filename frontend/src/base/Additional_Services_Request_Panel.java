package base;

import java.util.*;
import javax.swing.*;

import java.awt.Color;
import java.awt.Component;
import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.sql.*;
import javax.swing.JOptionPane;

import db_info.DB_Connection;

public class Additional_Services_Request_Panel extends JPanel implements ActionListener,ItemListener {
    String Service_Identifier;
    
    Vector<String> all_services;
    Vector<Integer> all_services_ref;
    
    Vector<String> valid_service_descriptions;
    Vector<String> valid_service_comments;
    
    Vector<JCheckBox> displayed_services;
    Vector<JTextField> displayed_services_comments;
    
    JPanel the_parent_panel;
    JPanel add_services_panel;
    JPanel box_panel;
    GridBagConstraints class_c;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Additional_Services_Request_Panel(Active_Work_Order work_order, JPanel parent_panel,
            GridBagConstraints parent_c, String t_prod_id, DB_Connection active_db_connection) {
        current_work_order=work_order;
        the_parent_panel=parent_panel;
        Service_Identifier=t_prod_id; //set the Service Identifier to either "Fork" or "Shock"
        this.active_db_connection=active_db_connection;
        add_services_panel=initializeJPanel("");
        initializeClassVariables();
        getServices(current_work_order);
        createServicesCheckBox(add_services_panel);
        disablePanelComponents();
                
        parent_panel.add(add_services_panel,parent_c);
    }
    
    private void initializeClassVariables()
    //This method is used instead of in the class variables declaration section because we need to call it again
    //when things are upate
    {
        class_c = new GridBagConstraints();
        class_c.anchor=GridBagConstraints.CENTER;
        class_c.weightx = 1.0;        
        
    	all_services=new Vector<String>();
        all_services_ref = new Vector<Integer>();
        
        valid_service_descriptions=new Vector<String>();
        valid_service_comments=new Vector<String>();
        
        displayed_services=new Vector<JCheckBox>();
        displayed_services_comments=new Vector<JTextField>();
        
        box_panel=initializeJPanel(Service_Identifier+" Services");
    }
    
    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }    
        
    
    private void createServicesCheckBox(JPanel parent_panel) {
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.CENTER;
        c.weightx = 1.0;
        
        JButton add_product_button = new JButton("Add Service");
        add_product_button.setActionCommand("add service");
        add_product_button.addActionListener(this);
        c.gridwidth=GridBagConstraints.REMAINDER;
        c.insets=new Insets(0,0,5,0);
        box_panel.add(add_product_button,c);
        c.insets=new Insets(0,0,0,0);        
        
        if (Service_Identifier.equals("Fork")) {
            all_services=active_db_connection.db_calls.getAllValues("fork_additional_services","description","row_id",all_services_ref);
        }
        if (Service_Identifier.equals("Shock")) {
            all_services=active_db_connection.db_calls.getAllValues("shock_additional_services","description","row_id",all_services_ref);
        }
        
        for (int i=0;i<all_services.size();i++) {
            JCheckBox t_checkbox=new JCheckBox(all_services.elementAt(i));
            JTextField t_field=initializeJTextField(10);
            displayed_services.add(t_checkbox);
            t_checkbox.addItemListener(this);
            c.anchor=GridBagConstraints.NORTHWEST;
            c.gridwidth=1;
            box_panel.add(t_checkbox,c);
            
            //see if this work order uses this additional product
            //if the "valid_service_descriptions" vector contains the product in the vector "all_services"
            //at this point, mark the box with a check mark and add the textbox with the corresponding description
            int prod_index=valid_service_descriptions.indexOf(all_services.elementAt(i));
            c.anchor=GridBagConstraints.NORTHEAST;
            c.gridwidth=GridBagConstraints.REMAINDER;
            if (prod_index>=0) {
                t_checkbox.setSelected(true);//mark it with a checkmark
                //now create a textfield with the user's comment if there was one
                addTextField(box_panel, t_field,valid_service_comments.elementAt(prod_index),c);
            } else {
                //add a blank textfield in case the user wants to add something later
                addTextField(box_panel, t_field,"",c);
            }
            displayed_services_comments.add(t_field);
        }
        parent_panel.add(box_panel, class_c);
    }
    public JTextField initializeJTextField(int cols) {
        JTextField tf = new JTextField();
        tf.setColumns(cols);
        return tf;
    } 
    
    public void addTextField(JPanel t_panel,JTextField t_field, String text,
            GridBagConstraints c) {
    	t_field.setBorder( BorderFactory.createLineBorder(Color.white));
    	t_field.setText(text);
    	t_field.setDisabledTextColor(Color.black);
        t_panel.add(t_field, c);
    }
    
    
    private void getServices(Active_Work_Order work_order) {
        ResultSet rs=null;
        
        if (Service_Identifier.equals("Fork")) {
            rs=active_db_connection.db_calls.getForkAdditionalServices(work_order.work_order_id);
        }
        if (Service_Identifier.equals("Shock")) {
            rs=active_db_connection.db_calls.getShockAdditionalServices(work_order.work_order_id);
        }
        try {
            if (rs.first()) {
                do
                {
                    valid_service_descriptions.add(rs.getString("Description"));//add to the class Vector
                    valid_service_comments.add(rs.getString("Comments"));//add to the class Vector
                }while (rs.next());
            }
        }catch (SQLException e) {
            System.err.println("Additional_Services_Request_Panel: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    public void enablePanelComponents() {
        Component[] panel_components;
        panel_components=box_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(true);
            if (panel_components[i].getClass().getName().contains("JTextField")) {
                enableTextField((JTextField)panel_components[i]);
            }
        }
    }
    
    public void disablePanelComponents() {
        Component[] panel_components;
        panel_components=box_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(false);
            if (panel_components[i].getClass().getName().contains("JTextField")) {
                disableTextField((JTextField)panel_components[i]);
            }
        }
    }
    
    private void enableTextField(JTextField tf) {
        tf.setEnabled(true);
        tf.setBackground(Color.white);
    }
    
    private void disableTextField(JTextField tf) {
        tf.setEnabled(false);
        tf.setBackground(Color.lightGray);
    }
    
    /** Listens to the check boxes. */
    public void itemStateChanged(ItemEvent e) {
        //Now that we know which button was pushed, find out
        //whether it was selected or deselected
        if (e.getStateChange() == ItemEvent.DESELECTED) {
        }
    }
    
    
    public void saveInfo(Active_Work_Order t_work_order) {
        //Before we add new additional prodcts information, we need to remove the old associations for this setting
    	active_db_connection.db_calls.removeAdditionalServicesFromWorkOrder(t_work_order.work_order_id, Service_Identifier);
        
        for (int i=0;i<displayed_services.size();i++) {
            if (displayed_services.elementAt(i).isSelected()) {
                //for the next call, remember the displayed_services and the all_services_ref vectors are both referencing
                //the same location; displayed_services references the JCheckBox object and all_services_ref references the
                //db identifers for the String displayed beside the JCheckBox
            	active_db_connection.db_calls.saveAdditionalServices(t_work_order.work_order_id,
                        Service_Identifier,
                        all_services_ref.elementAt(i),
                        displayed_services_comments.elementAt(i).getText().trim()
                        );
            }
        }
    }
    
    public void actionPerformed(ActionEvent e) {
        String cmd=e.getActionCommand();
        if (cmd.equals("add service")) {
            String result=JOptionPane.showInputDialog(null, "Type in New Service Description");
            if  ( (result !=null)&&(!(result.trim()).equals("")) ) {
                if (!all_services.contains(result)) {
                    if (Service_Identifier.equals("Fork")) {
                    	active_db_connection.db_calls.addForkAdditionalService(result);
                    } else {
                    	active_db_connection.db_calls.addShockAdditionalService(result);
                    }
                    
                    /*Update the boxes with the new selection*/
                    add_services_panel.remove(box_panel);
                    initializeClassVariables();
                    getServices(current_work_order);
                    createServicesCheckBox(add_services_panel);
                    add_services_panel.add(box_panel,class_c);
                } else {
                    JOptionPane.showMessageDialog(null, "Product Already Present", "Warning",
                            JOptionPane.WARNING_MESSAGE,null);
                }
            }
        }
        
    }//end method actionPerformed
    
}//end class Additional_Services_Request_Panel

