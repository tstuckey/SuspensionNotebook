package base;
import javax.swing.*;

import db_info.DB_Connection;

import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;

public class Additional_Products_Info implements ActionListener {
    Additional_Products fork_additional_products;
    Additional_Products shock_additional_products;
    
    DB_Connection active_db_connection;
    public Additional_Products_Info(Active_Work_Order this_work_order,JTabbedPane parent_tab, DB_Connection active_db_connection) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(""),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        
        t_panel.setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        shock_additional_products=new Additional_Products(this_work_order, t_panel, c, "Shock",active_db_connection);
        fork_additional_products=new Additional_Products(this_work_order, t_panel, c, "Fork",active_db_connection);
        
        parent_tab.addTab("Additional Products",t_panel);
    }
    
    
    public void enableSubComponents() {
        fork_additional_products.enableSubComponents();
        shock_additional_products.enableSubComponents();
    }
    
    public void disableSubComponents() {
        fork_additional_products.disableSubComponents();
        shock_additional_products.disableSubComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        fork_additional_products.saveInfo(t_work_order);
        shock_additional_products.saveInfo(t_work_order);
    }
    
    public void actionPerformed(ActionEvent e) {
        if ((e.getActionCommand()).equals("something")) {
            System.out.println("something");
        }
    }
}
