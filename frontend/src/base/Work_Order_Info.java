package base;


import javax.swing.*;
import javax.swing.event.*;

import db_info.DB_Connection;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;

public class Work_Order_Info implements ChangeListener {
	Work_Order_General_Info general_info;
    Work_Order_Estimate_Info estimate_info;
    Work_Order_Finance_Info finance_info;
    
    public Work_Order_Info(Active_Work_Order work_order, JTabbedPane parent_tabbedPane, DB_Connection active_db_connection) {
    	JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder("Basic Info"),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        
        t_panel.setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        JTabbedPane tabbedPane=new JTabbedPane(JTabbedPane.TOP);
        general_info=new Work_Order_General_Info(work_order, tabbedPane,active_db_connection);
        estimate_info=new Work_Order_Estimate_Info(work_order, tabbedPane, active_db_connection);
        finance_info=new Work_Order_Finance_Info(work_order,estimate_info,tabbedPane, active_db_connection);
        
        tabbedPane.addChangeListener(this);
        t_panel.add(tabbedPane,c);
        parent_tabbedPane.add("Work Order", t_panel);
    }
    
    
    public void enableSubComponents() {
        general_info.enablePanelComponents();
        estimate_info.enablePanelComponents();
        finance_info.enablePanelComponents();
    }
    
    public void disableSubComponents() {
        general_info.disablePanelComponents();
        estimate_info.disablePanelComponents();
        finance_info.disablePanelComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        general_info.saveInfo(t_work_order);
        estimate_info.saveInfo(t_work_order);
        finance_info.saveInfo(t_work_order);
    }
    
    public void stateChanged(ChangeEvent e) {
        //This is invoked every time the user changes tabs in the Work_Order Information
    }

}//end class Work_Order_Info
