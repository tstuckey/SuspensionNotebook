package base;

import javax.swing.*;

import db_info.DB_Connection;


import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;

public class Work_Order_Fork_Info{
    Work_Request_Panel fork_work_requested;
    Additional_Services_Request_Panel fork_services_requested;
    Estimate_Panel fork_estimate;
    DB_Connection active_db_connection;
    public Work_Order_Fork_Info(Active_Work_Order work_order,JComboBox ghost_box,
            JPanel parent_panel, GridBagConstraints parent_c, DB_Connection active_db_connection) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(""),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        
        t_panel.setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        c.weightx = 1.0;
        
        c.anchor=GridBagConstraints.NORTHWEST;
        
        fork_work_requested=new Work_Request_Panel(work_order, t_panel, c, "Fork",active_db_connection);
        c.gridwidth=GridBagConstraints.REMAINDER;
        fork_services_requested=new Additional_Services_Request_Panel(work_order, t_panel,c,"Fork", active_db_connection);
        fork_estimate=new Estimate_Panel(work_order,ghost_box,t_panel,c, "Fork", active_db_connection);
        
        parent_panel.add(t_panel,parent_c);
    }
    
    
    public void enablePanelComponents() {
        fork_work_requested.enablePanelComponents();
        fork_services_requested.enablePanelComponents();
        fork_estimate.enablePanelComponents();
    }
    
    public void disablePanelComponents() {
        fork_work_requested.disablePanelComponents();
        fork_services_requested.disablePanelComponents();
        fork_estimate.disablePanelComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        fork_work_requested.saveInfo(t_work_order);
        fork_services_requested.saveInfo(t_work_order);
        fork_estimate.saveInfo(t_work_order);
    }
    
}//end class Work_Order_Fork_Info
