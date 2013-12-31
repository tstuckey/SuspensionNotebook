package base;
import javax.swing.*;

import db_info.DB_Connection;


import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;

public class Work_Order_Estimate_Info{
    JComboBox ghost_box=new JComboBox();//only so Work_Order_Total_Estimate can listen on this
    
    Work_Order_Shock_Info shock_info;
    Work_Order_Fork_Info fork_info;
    Work_Order_Total_Estimate total_info;
    public Work_Order_Estimate_Info(Active_Work_Order work_order, JTabbedPane tabbedPane,DB_Connection active_db_connection) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(""),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        
        t_panel.setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        //adding a blank meaningless item to the ghost_box so it can be referenced and the event fire
        ghost_box.addItem("0");
        
        shock_info=new Work_Order_Shock_Info(work_order,ghost_box,t_panel,c, active_db_connection);
        c.gridwidth=GridBagConstraints.REMAINDER;
        fork_info=new Work_Order_Fork_Info(work_order,ghost_box,t_panel,c,active_db_connection);
        total_info=new Work_Order_Total_Estimate(work_order,shock_info,fork_info,ghost_box,t_panel,c);
        tabbedPane.add("Estimate Info", t_panel);
    }
    
    
    public void enablePanelComponents() {
        shock_info.enablePanelComponents();
        fork_info.enablePanelComponents();
    }
    
    public void disablePanelComponents() {
        fork_info.disablePanelComponents();
        shock_info.disablePanelComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        fork_info.saveInfo(t_work_order);
        shock_info.saveInfo(t_work_order);
    }
    
}//end class Work_Order_Estimate_Info
