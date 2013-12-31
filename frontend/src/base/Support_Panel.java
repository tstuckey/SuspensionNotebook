package base;

import javax.swing.*;

import db_info.DB_Connection;

import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.sql.*;

public class Support_Panel {
    JPanel support_panel;
    GridBagConstraints c;
    
    String  cust_comments=null;
    String  t_spt_comments=null;
    
    Comments customer_comments;
    Comments tech_support_comments;
    Active_Work_Order current_work_order;
    
    DB_Connection active_db_connection;
    public Support_Panel(Active_Work_Order work_order,JPanel parent_panel, GridBagConstraints parent_c,DB_Connection active_db_connection) {
        current_work_order=work_order;
        this.active_db_connection=active_db_connection;
        support_panel=new JPanel();
        support_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder("Support"),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        
        support_panel.setLayout(new GridBagLayout());
        c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;

        retrieveComments(current_work_order);
        customer_comments = new Comments(support_panel, "Customer Comments", c, cust_comments,null, "disabled","big box");
        c.gridwidth=GridBagConstraints.REMAINDER;
        tech_support_comments = new Comments(support_panel, "Tech Support Comments", c, t_spt_comments,null, "disabled","big box");
        
        parent_panel.add(support_panel, parent_c);
    }
    
    public void retrieveComments(Active_Work_Order work_order) {
        //This method retrieves the customer comments and the tech support comments for this_setting
        ResultSet rs=null;
        
        rs=active_db_connection.db_calls.getSupportComments(work_order.work_order_id);
        
        try {
            if (rs.first()) {
                cust_comments=rs.getString("Customer Comments");
                t_spt_comments=rs.getString("Tech Support Comments");
            }
        }catch (SQLException e) {
            System.err.println("Support_Panel:  Problem retrieving data.");
        }
    }
    
    public void enablePanelComponents() {
        customer_comments.enableComponents();
        tech_support_comments.enableComponents();
    }
    
    public void disablePanelComponents() {
        customer_comments.disableComponents();
        tech_support_comments.disableComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
    	active_db_connection.db_calls.updateSupportComments(t_work_order.work_order_id,
        		                       customer_comments.textArea.getText().trim(),
        		                       tech_support_comments.textArea.getText().trim() );
    }

}
