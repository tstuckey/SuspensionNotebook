package base;

import java.util.*;
import javax.swing.*;

import db_info.DB_Connection;

import java.awt.Component;
import java.awt.event.*;
import java.awt.GridLayout;
import java.awt.GridBagConstraints;
import java.sql.*;

public class Riding_Type_Panel implements ActionListener,ItemListener {
    JPanel box_panel;
    
    Vector<String> all_riding_type;
    Vector<Integer> all_riding_type_ref;
    Vector<String> valid_riding_type;
    Vector<JCheckBox> displayed_riding_type;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Riding_Type_Panel(Active_Work_Order work_order,JPanel parent_panel, 
    						 GridBagConstraints parent_c, DB_Connection active_db_connection) {
        current_work_order=work_order;
        this.active_db_connection=active_db_connection;
        
        initializeClassVariables();
        getRidingType(current_work_order);
        createRidingTypeCheckBox(box_panel);
        disablePanelComponents();
        
        parent_panel.add(box_panel, parent_c);
    }
    
    private void initializeClassVariables() {
        all_riding_type = new Vector<String>();
        all_riding_type_ref = new Vector<Integer>();
        valid_riding_type = new Vector<String>();
        
        displayed_riding_type=new Vector<JCheckBox>();
        box_panel=new JPanel(new GridLayout(0,1));
        box_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder("Riding Type"),
                BorderFactory.createEmptyBorder(0,0,0,0)));
    }
    
    
    private void getRidingType(Active_Work_Order work_order) {
        ResultSet rs=null;
        
        rs=active_db_connection.db_calls.getRidingType(work_order.work_order_id);
        try {
            if (rs.first()) {
                do
                {
                    valid_riding_type.add(rs.getString("Riding Type"));
                }while (rs.next());
            }
        }catch (SQLException e) {
            System.err.println("Riding_Type_Panel: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    private void createRidingTypeCheckBox(JPanel box_panel) {
        Vector<String> items=active_db_connection.db_calls.getAllValues("riding_type","description","description",all_riding_type_ref);
        for (int i=0;i<items.size();i++) {
            JCheckBox t_checkbox=new JCheckBox(items.elementAt(i));
            displayed_riding_type.add(t_checkbox);
            t_checkbox.addItemListener(this);
            if (valid_riding_type.contains(t_checkbox.getText())) {
                t_checkbox.setSelected(true);//mark it with a checkmark
            }
            box_panel.add(t_checkbox);
        }
    }
    
    /** Listens to the check boxes. */
    public void itemStateChanged(ItemEvent e) {
        //Now that we know which button was pushed, find out
        //whether it was selected or deselected.
        if (e.getStateChange() == ItemEvent.DESELECTED) {
        }
        
    }
    
    public void enablePanelComponents() {
        Component[] panel_components;
        panel_components=box_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(true);
        }
    }
    
    public void disablePanelComponents() {
    	Component[] panel_components;
        panel_components=box_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(false);
        }
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        //Before we add new riding_type information, we need to remove the old associations for this setting
    	active_db_connection.db_calls.removeRidingTypesFromWorkOrder(t_work_order.work_order_id);
        
        for (int i=0;i<displayed_riding_type.size();i++) {
            if (displayed_riding_type.elementAt(i).isSelected()) {
                //for the next call, remember the displayed_riding_type and the all_riding_type_ref vectors are both referencing
                //the same location; displayed_riding_type references the JCheckBox object and all_riding_type_ref references the
                //db identifers for the String displayed beside the JCheckBox
            	active_db_connection.db_calls.saveRidingTypes(t_work_order.work_order_id,
                        all_riding_type_ref.elementAt(i));
            }
        }
        
    }
    
    public void actionPerformed(ActionEvent e) {
    }
}//end class Riding_Type_Panel
