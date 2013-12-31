package base;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import db_info.DB_Connection;


import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;

public class Fork_Info_Panel implements ChangeListener {
	Fork_Arrival_Table fork_arrival;
	Shim_Table fork_compression;
    Shim_Table fork_lsv;
    Shim_Table fork_rebound;
    Shim_Table_Measurement fork_bcv;
    Fork_Adjustments_Table fork_adjustments;
    General_Component_Info component_info;
    public Fork_Info_Panel(Active_Work_Order this_work_order,JTabbedPane parent_tab, DB_Connection active_db_connection) {
        JPanel t_panel=initializeJPanel("");
        JTabbedPane fork_tabs=new JTabbedPane(JTabbedPane.LEFT);
    	
    	JPanel fork_info=initializeJPanel("Fork Info");
        JPanel arrival_panel=initializeJPanel("");
        JPanel shim_panel=initializeJPanel("");
        JPanel adjustments_panel=initializeJPanel("");
        
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        c.gridwidth=GridBagConstraints.REMAINDER;
        fork_arrival = new Fork_Arrival_Table(this_work_order.this_setting,arrival_panel,"Arrival Settings",c,active_db_connection);
        c.gridwidth=1;//reset to default
        fork_compression   = new Shim_Table(this_work_order,shim_panel,"Fork Compression",c,active_db_connection);
        fork_lsv           = new Shim_Table(this_work_order,shim_panel,"Fork LSV",c,active_db_connection);
        fork_rebound       = new Shim_Table(this_work_order,shim_panel,"Fork Rebound",c,active_db_connection);
        c.gridwidth=GridBagConstraints.REMAINDER;
        fork_bcv           = new Shim_Table_Measurement(this_work_order,shim_panel,"Fork BCV",c,active_db_connection);
        fork_adjustments   = new Fork_Adjustments_Table(this_work_order.this_setting,adjustments_panel,"Fork Adjustments",c,active_db_connection);
        
        fork_info.add(arrival_panel,c);
        fork_info.add(shim_panel,c);
        fork_info.add(adjustments_panel,c);        

        JPanel fork_info2=initializeJPanel("");
        component_info=new General_Component_Info(this_work_order,"Fork",fork_info2,c,active_db_connection);

        fork_tabs.addTab("Settings", fork_info);
        fork_tabs.add("Stock Info", fork_info2);
        
        t_panel.add(fork_tabs,c);
        parent_tab.addTab("Fork Info",t_panel);
        parent_tab.addChangeListener(this);
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
        fork_compression.enableComponents();
        fork_lsv.enableComponents();
        fork_rebound.enableComponents();
        fork_bcv.enableComponents();
        fork_adjustments.enableComponents();
        fork_arrival.enableComponents();
        component_info.enableComponents();
    }
    
    public void disableSubComponents() {
        fork_compression.disableComponents();
        fork_lsv.disableComponents();
        fork_rebound.disableComponents();
        fork_bcv.disableComponents();
        fork_adjustments.disableComponents();
        fork_arrival.disableComponents();
        component_info.disableComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        fork_compression.saveInfo(t_work_order);
        fork_lsv.saveInfo(t_work_order);
        fork_rebound.saveInfo(t_work_order);
        fork_bcv.saveInfo(t_work_order);
        fork_adjustments.saveInfo(t_work_order);
        fork_arrival.saveInfo(t_work_order);
        component_info.saveInfo(t_work_order);
    }


	public void stateChanged(ChangeEvent evt) {
        //Do float recalculations every time the user changes tabs
		fork_bcv.updateTableCalculations();
	}
}
