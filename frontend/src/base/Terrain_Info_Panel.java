package base;

import java.util.*;
import javax.swing.*;

import db_info.DB_Connection;

import java.awt.Component;
import java.awt.event.*;
import java.awt.GridLayout;
import java.awt.GridBagConstraints;
import java.sql.*;

public class Terrain_Info_Panel implements ActionListener,ItemListener {
    JPanel box_panel;
    
    Vector<String> all_terrain;
    Vector<Integer> all_terrain_ref;
    Vector<String> valid_terrain;
    Vector<JCheckBox> displayed_terrain;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Terrain_Info_Panel(Active_Work_Order work_order,JPanel parent_panel, GridBagConstraints parent_c, DB_Connection active_db_connection) {
        current_work_order=work_order;
        this.active_db_connection=active_db_connection;
        
        initializeClassVariables();
        getTerrain(current_work_order);
        createTerrainCheckBox(box_panel);
        disablePanelComponents();        
        parent_panel.add(box_panel, parent_c);
    }
    
    private void initializeClassVariables() {
        all_terrain = new Vector<String>();
        all_terrain_ref = new Vector<Integer>();
        valid_terrain = new Vector<String>();
        
        displayed_terrain=new Vector<JCheckBox>();
        box_panel=new JPanel(new GridLayout(0,1));
        box_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder("Terrain"),
                BorderFactory.createEmptyBorder(0,0,0,0)));
    }
    
    private void getTerrain(Active_Work_Order work_order) {
        ResultSet rs=null;
        rs=active_db_connection.db_calls.getTerrain(work_order.work_order_id);
        try {
            if (rs.first()) {
                do
                {
                    valid_terrain.add(rs.getString("Terrain"));
                }while (rs.next());
            }
        }catch (SQLException e) {
            System.err.println("Terrain_Info_Panel: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    private void createTerrainCheckBox(JPanel box_panel) {
        Vector<String> items=active_db_connection.db_calls.getAllValues("terrain","description","description",all_terrain_ref);
        for (int i=0;i<items.size();i++) {
            JCheckBox t_checkbox=new JCheckBox(items.elementAt(i));
            displayed_terrain.add(t_checkbox);
            t_checkbox.addItemListener(this);
            if (valid_terrain.contains(t_checkbox.getText())) {
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
        //Before we add new additional prodcts information, we need to remove the old associations for this setting
    	active_db_connection.db_calls.removeTerrainFromWorkOrder(t_work_order.work_order_id);
        
        for (int i=0;i<displayed_terrain.size();i++) {
            if (displayed_terrain.elementAt(i).isSelected()) {
                //for the next call, remember the displayed_terrain and the displayed_terrain_ref vectors are both referencing
                //the same location; displayed_terrain references the JCheckBox object and all_terrain_ref references the
                //db identifers for the String displayed beside the JCheckBox
            	active_db_connection.db_calls.saveTerrain(t_work_order.work_order_id,
                        all_terrain_ref.elementAt(i));
            }
        }
        
    }
    
    public void actionPerformed(ActionEvent e) {
    }
}//end class Terrain_Info_Panel
