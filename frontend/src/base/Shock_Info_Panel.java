package base;

import javax.swing.*;

import db_info.DB_Connection;


import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;

public class Shock_Info_Panel {
    JPanel t_panel;
	Shock_Arrival_Table shock_arrival;
	Shim_Table shock_compression;
    Shim_Table shock_compression_adjuster;
    Shim_Table shock_rebound;
    Shock_Adjustments_Table shock_adjustments;
    General_Component_Info component_info;
    DB_Connection active_db_connnection;
    public Shock_Info_Panel(Active_Work_Order this_work_order,JTabbedPane parent_tab, DB_Connection active_db_connection) {
        t_panel=initializeJPanel("");
        JTabbedPane shock_tabs=new JTabbedPane(JTabbedPane.LEFT);
        
        JPanel shock_info=initializeJPanel("Shock Info");
        JPanel arrival_panel=initializeJPanel("");
        JPanel shim_panel=initializeJPanel("");
        JPanel adjustments_panel=initializeJPanel("");

        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        c.gridwidth=GridBagConstraints.REMAINDER;
        shock_arrival= new Shock_Arrival_Table(this_work_order.this_setting, arrival_panel,"Arrival Settings",c, active_db_connection);
        c.gridwidth=1;//reset to default
        shock_compression = new Shim_Table(this_work_order,shim_panel,"Shock Compression",c,active_db_connection);
        shock_rebound = new Shim_Table(this_work_order,shim_panel,"Shock Tension",c,active_db_connection);
        c.gridwidth=GridBagConstraints.REMAINDER;
        shock_compression_adjuster = new Shim_Table(this_work_order,shim_panel,"Shock Comp Adj",c,active_db_connection);
        shock_adjustments  = new Shock_Adjustments_Table(this_work_order.this_setting,adjustments_panel, "Shock Adjustments",c,active_db_connection);
        
        shock_info.add(arrival_panel,c);
        shock_info.add(shim_panel,c);
        shock_info.add(adjustments_panel,c);
        
        JPanel shock_info2=initializeJPanel("");
        component_info=new General_Component_Info(this_work_order,"Shock",shock_info2,c, active_db_connection);
                
        shock_tabs.addTab("Settings", shock_info);
        shock_tabs.add("Stock Info",shock_info2);
        
        t_panel.add(shock_tabs,c);
        parent_tab.addTab("Shock Info",t_panel);
    }
    
	private JPanel initializeJPanel(String title) {
		JPanel t_panel = new JPanel();
		t_panel.setBorder(BorderFactory.createCompoundBorder(BorderFactory
				.createTitledBorder(title), BorderFactory.createEmptyBorder(0,
						0, 0, 0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}  
    
    public void enableSubComponents() {
        shock_compression.enableComponents();
        shock_compression_adjuster.enableComponents();
        shock_rebound.enableComponents();
        shock_adjustments.enableComponents();
        shock_arrival.enableComponents();
        component_info.enableComponents();
    }
    
    public void disableSubComponents() {
        shock_compression.disableComponents();
        shock_compression_adjuster.disableComponents();
        shock_rebound.disableComponents();
        shock_adjustments.disableComponents();
        shock_arrival.disableComponents();
        component_info.disableComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        shock_compression.saveInfo(t_work_order);
        shock_compression_adjuster.saveInfo(t_work_order);
        shock_rebound.saveInfo(t_work_order);
        shock_adjustments.saveInfo(t_work_order);
        shock_arrival.saveInfo(t_work_order);
        component_info.saveInfo(t_work_order);
    }
 
}
