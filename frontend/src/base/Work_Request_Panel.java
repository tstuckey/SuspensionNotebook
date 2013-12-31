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

public class Work_Request_Panel implements ActionListener,ItemListener {
    String Work_Identifier;
    
    Vector<String> all_standard_work;
    Vector<Integer> all_standard_work_ref;
    
    Vector<String> valid_standard_work_descriptions;
    Vector<String> valid_standard_work_comments;
    
    Vector<JCheckBox> displayed_standard_work;
    Vector<JTextField> displayed_standard_work_comments;
    
    JPanel the_parent_panel;
    JPanel standard_work_panel;
    JPanel box_panel;
    GridBagConstraints class_c;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Work_Request_Panel(Active_Work_Order work_order, JPanel parent_panel,
            GridBagConstraints parent_c, String t_prod_id, DB_Connection active_db_connection) {
        current_work_order=work_order;
        the_parent_panel=parent_panel;
        Work_Identifier=t_prod_id; //set the Service Identifier to either "Fork" or "Shock"
        this.active_db_connection=active_db_connection;
        standard_work_panel=initializeJPanel("");
        initializeClassVariables();
        getServices(current_work_order);
        createServicesCheckBox(standard_work_panel);
        disablePanelComponents();
        the_parent_panel.add(standard_work_panel,parent_c);
    }
    
    private void initializeClassVariables()
    //This method is used instead of in the class variables declaration section because we need to call it again
    //when things are updated
    {
        class_c = new GridBagConstraints();
        class_c.anchor=GridBagConstraints.NORTHWEST;

        all_standard_work=new Vector<String>();
        all_standard_work_ref = new Vector<Integer>();
        
        valid_standard_work_descriptions=new Vector<String>();
        valid_standard_work_comments=new Vector<String>();
        
        displayed_standard_work=new Vector<JCheckBox>();
        displayed_standard_work_comments=new Vector<JTextField>();
        
        box_panel=initializeJPanel(Work_Identifier+" Standard Work");
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
        
        JButton add_product_button = new JButton("Add Standard Work");
        add_product_button.setActionCommand("add standard work");
        add_product_button.addActionListener(this);
        c.gridwidth=GridBagConstraints.REMAINDER;
        c.insets=new Insets(0,0,5,0);        
        box_panel.add(add_product_button,c);
        c.insets=new Insets(0,0,0,0);    
                
        if (Work_Identifier.equals("Fork")) {
            all_standard_work=active_db_connection.db_calls.getAllValues("fork_work","description","row_id",all_standard_work_ref);
        }
        if (Work_Identifier.equals("Shock")) {
            all_standard_work=active_db_connection.db_calls.getAllValues("shock_work","description","row_id",all_standard_work_ref);
        }
        
        for (int i=0;i<all_standard_work.size();i++) {
            JCheckBox t_checkbox=new JCheckBox(all_standard_work.elementAt(i));
            JTextField t_field=initializeJTextField(10);
            displayed_standard_work.add(t_checkbox);
            t_checkbox.addItemListener(this);
            c.anchor=GridBagConstraints.NORTHWEST; 
            c.gridwidth=1;
            box_panel.add(t_checkbox,c);
            
            //see if this work order uses this additional product
            //if the "valid_standard_work_descriptions" vector contains the product in the vector "all_standard_work"
            //at this point, mark the box with a check mark and add the textbox with the corresponding description
            int prod_index=valid_standard_work_descriptions.indexOf(all_standard_work.elementAt(i));
            c.anchor=GridBagConstraints.NORTHEAST;
            c.gridwidth=GridBagConstraints.REMAINDER;
            if (prod_index>=0) {
                t_checkbox.setSelected(true);//mark it with a checkmark
                //now create a textfield with the user's comment if there was one
                addTextField(box_panel, t_field,valid_standard_work_comments.elementAt(prod_index),c);
            } else {
                //add a blank textfield in case the user wants to add something later
            	addTextField(box_panel, t_field,"",c);
            }
            displayed_standard_work_comments.add(t_field);
        }
        parent_panel.add(box_panel, c);
    }
    public JTextField initializeJTextField(int cols) {
    	JTextField tf = new JTextField(cols);
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
        
        if (Work_Identifier.equals("Fork")) {
            rs=active_db_connection.db_calls.getForkStandardWork(work_order.work_order_id);
        }
        if (Work_Identifier.equals("Shock")) {
            rs=active_db_connection.db_calls.getShockStandardWorkFromWorkOrder(work_order.work_order_id);
        }
        try {
            if (rs.first()) {
                do
                {
                    valid_standard_work_descriptions.add(rs.getString("Description"));//add to the class Vector
                    valid_standard_work_comments.add(rs.getString("Comments"));//add to the class Vector
                }while (rs.next());
            }
        }catch (SQLException e) {
            System.err.println("Work_Request_Panel: Problem retrieving data.");
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
    	active_db_connection.db_calls.removeStandardWorkFromWorkOrder(t_work_order.work_order_id, Work_Identifier);
        
        for (int i=0;i<displayed_standard_work.size();i++) {
            if (displayed_standard_work.elementAt(i).isSelected()) {
                //for the next call, remember the displayed_standard_work and the all_standard_work_ref vectors are both referencing
                //the same location; displayed_standard_work references the JCheckBox object and all_standard_work_ref references the
                //db identifers for the String displayed beside the JCheckBox
            	active_db_connection.db_calls.saveStandardWork(t_work_order.work_order_id,
                        Work_Identifier,
                        all_standard_work_ref.elementAt(i),
                        displayed_standard_work_comments.elementAt(i).getText().trim()
                        );
            }
        }
    }
    
    public void actionPerformed(ActionEvent e) {
        String cmd=e.getActionCommand();
        if (cmd.equals("add standard work")) {
            String result=JOptionPane.showInputDialog(null, "Type in New Work Description");
            if  ( (result !=null)&&(!(result.trim()).equals("")) ) {
                if (!all_standard_work.contains(result)) {
                    if (Work_Identifier.equals("Fork")) {
                    	active_db_connection.db_calls.addForkStandardWork(result);
                    } else {
                    	active_db_connection.db_calls.addShockStandardWork(result);
                    }
                    
                    /*Update the boxes with the new selection*/
                    standard_work_panel.remove(box_panel);
                    initializeClassVariables();
                    getServices(current_work_order);
                    createServicesCheckBox(standard_work_panel);
                    standard_work_panel.add(box_panel,class_c);
                } else {
                    JOptionPane.showMessageDialog(null, "Work Already Present", "Warning",
                            JOptionPane.WARNING_MESSAGE,null);
                }
            }
        }
        
    }//end method actionPerformed
    
}//end class Work_Request_Panel

