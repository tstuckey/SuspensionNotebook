package base;

import javax.swing.*;

import db_info.DB_Connection;


import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;

public class Work_Order_Finance_Info {
    Work_Order_Finance_Header_Info header_info;
    Work_Order_Shipping_Info shipping_info;
    Work_Order_Payment_Info payment_info;
    
    GridBagConstraints class_c;
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Work_Order_Finance_Info(Active_Work_Order work_order,Work_Order_Estimate_Info estimate_info,
            JTabbedPane tabbedPane, DB_Connection active_db_connection) {
        current_work_order=work_order;
        this.active_db_connection=active_db_connection;
        
        JPanel t_panel=initializeJPanel("");
        initializeClassVariables(t_panel,estimate_info);
        disablePanelComponents();
        
        tabbedPane.add("Payment",t_panel);
    }
	private JPanel initializeJPanel(String title) {
		JPanel t_panel = new JPanel();
		t_panel.setBorder(BorderFactory.createCompoundBorder(BorderFactory
				.createTitledBorder(title), BorderFactory.createEmptyBorder(0,
						0, 0, 0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}  
	
    private void initializeClassVariables(JPanel this_panel,Work_Order_Estimate_Info estimate_info) {
        JPanel part1=initializeJPanel("");
        JPanel part2=initializeJPanel("");
        
        class_c = new GridBagConstraints();
        class_c.anchor=GridBagConstraints.NORTHWEST;
        header_info=new Work_Order_Finance_Header_Info(current_work_order,part1, class_c,active_db_connection);
        class_c.gridwidth=GridBagConstraints.REMAINDER;
        payment_info=new Work_Order_Payment_Info(current_work_order,part1,class_c, active_db_connection);
        shipping_info=new Work_Order_Shipping_Info(current_work_order,part2, class_c, active_db_connection);
    
        this_panel.add(part1,class_c);
        this_panel.add(part2,class_c);
    }
    
    public void disablePanelComponents() {
        header_info.disablePanelComponents();
        shipping_info.disablePanelComponents();
        payment_info.disablePanelComponents();
    }
    
    public void enablePanelComponents() {
        header_info.enablePanelComponents();
        shipping_info.enablePanelComponents();
        payment_info.enablePanelComponents();
    }
    
    
    public void saveInfo(Active_Work_Order t_work_order) {
        header_info.saveInfo(t_work_order);
        shipping_info.saveInfo(t_work_order);
        payment_info.saveInfo(t_work_order);
    }
    
}//end class Work_Order_Finance_Info
