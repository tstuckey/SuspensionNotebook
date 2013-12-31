package base;


import javax.swing.*;

import db_info.DB_Connection;

import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;


public class Riding_Info {
    Terrain_Info_Panel terrain_info;
    Riding_Type_Panel riding_type_info;
    
    public Riding_Info(Active_Work_Order work_order, JPanel parent_panel, 
    				   GridBagConstraints parent_c, DB_Connection active_db_connection) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder("Terrain and Type"),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        
        t_panel.setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        terrain_info=new Terrain_Info_Panel(work_order,t_panel,c,active_db_connection);
        riding_type_info=new Riding_Type_Panel(work_order,t_panel,c, active_db_connection);
        parent_panel.add(t_panel, parent_c);
    }
    
    
    public void enablePanelComponents() {
        terrain_info.enablePanelComponents();
        riding_type_info.enablePanelComponents();
    }
    
    public void disablePanelComponents() {
        terrain_info.disablePanelComponents();
        riding_type_info.disablePanelComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        terrain_info.saveInfo(t_work_order);
        riding_type_info.saveInfo(t_work_order);
    }
    
}//end class Riding_Info
