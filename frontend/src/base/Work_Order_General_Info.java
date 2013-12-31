package base;


import javax.swing.*;

import db_info.DB_Connection;


import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;

public class Work_Order_General_Info {
    Overall_Info_Panel overall_info;
    Rider_Info_Panel rider_info;
    Bike_Info_Panel bike_info;
    Riding_Info riding_info;
    Support_Panel support_panel;
    DB_Connection active_db_connection;
    public Work_Order_General_Info(Active_Work_Order work_order, JTabbedPane tabbedPane, DB_Connection active_db_connection) {
        JPanel t_panel=new JPanel();
        this.active_db_connection=active_db_connection;
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(""),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        
        t_panel.setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        overall_info=new Overall_Info_Panel(work_order,t_panel,c,active_db_connection);
        rider_info=new Rider_Info_Panel(work_order,t_panel,c,active_db_connection);
        bike_info=new Bike_Info_Panel(work_order,t_panel,c,active_db_connection);
        c.gridwidth=GridBagConstraints.REMAINDER;
        riding_info=new Riding_Info(work_order,t_panel,c, active_db_connection);
        support_panel=new Support_Panel(work_order,t_panel,c, active_db_connection);
        tabbedPane.add("General Info", t_panel);
    }
    
    
    public void enablePanelComponents() {
        overall_info.enablePanelComponents();
        rider_info.enablePanelComponents();
        bike_info.enablePanelComponents();
        riding_info.enablePanelComponents();
        support_panel.enablePanelComponents();
    }
    
    public void disablePanelComponents() {
        overall_info.disablePanelComponents();
        rider_info.disablePanelComponents();
        bike_info.disablePanelComponents();
        riding_info.disablePanelComponents();
        support_panel.disablePanelComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        overall_info.saveInfo(t_work_order);
        rider_info.saveInfo(t_work_order);
        bike_info.saveInfo(t_work_order);
        riding_info.saveInfo(t_work_order);
        support_panel.saveInfo(t_work_order);
    }
    
}//end class Work_Order_General_Info
