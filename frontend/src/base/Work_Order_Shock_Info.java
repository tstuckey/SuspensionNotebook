package base;
import javax.swing.*;

import db_info.DB_Connection;


import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;

public class Work_Order_Shock_Info{
    
    Work_Request_Panel shock_work_requested;
    Additional_Services_Request_Panel shock_services_requested;
    Estimate_Panel shock_estimate;
    public Work_Order_Shock_Info(Active_Work_Order work_order, JComboBox ghost_box,
            JPanel parent_panel, GridBagConstraints parent_c,DB_Connection active_db_connection) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(""),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        
        t_panel.setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        shock_work_requested=new Work_Request_Panel(work_order, t_panel,c,"Shock",active_db_connection);
        c.gridwidth=GridBagConstraints.REMAINDER;
        shock_services_requested=new Additional_Services_Request_Panel(work_order, t_panel,c,"Shock",active_db_connection);
        shock_estimate=new Estimate_Panel(work_order,ghost_box,t_panel,c,"Shock",active_db_connection);
        
        parent_panel.add(t_panel,parent_c);
    }
    
    
    public void enablePanelComponents() {
        shock_work_requested.enablePanelComponents();
        shock_services_requested.enablePanelComponents();
        shock_estimate.enablePanelComponents();
    }
    
    public void disablePanelComponents() {
        shock_work_requested.disablePanelComponents();
        shock_services_requested.disablePanelComponents();
        shock_estimate.disablePanelComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        shock_work_requested.saveInfo(t_work_order);
        shock_services_requested.saveInfo(t_work_order);
        shock_estimate.saveInfo(t_work_order);
    }
    
}//end class Work_Order_Shock_Info
