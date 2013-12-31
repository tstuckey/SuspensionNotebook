package base;
import javax.swing.BorderFactory;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import db_info.DB_Connection;

import java.awt.Color;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.sql.*;

public class Item_Revision_Panel {
    JPanel rev_info_panel;
        
    JTextField revision_field;
    GridBagConstraints class_c;
    String suspension_identifier=null;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Item_Revision_Panel(Active_Work_Order work_order,JPanel parent_panel,String identifier,
    						   GridBagConstraints parent_c,DB_Connection active_db_connection) {
    	current_work_order=work_order;
        suspension_identifier=identifier;
        this.active_db_connection=active_db_connection;
        initializeClassVariables();
        setupTextAreas();
        getDBInfo();
        disablePanelComponents();
        
        parent_panel.add(rev_info_panel,parent_c);
    }
    
    private void initializeClassVariables() {
        rev_info_panel=initializeJPanel("");
               
        class_c = new GridBagConstraints();
        class_c.anchor=GridBagConstraints.CENTER;
        class_c.weightx = 1.0;
        
        revision_field = new JTextField(5);
    }
    
    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }
    
    private void setupTextAreas() {
        addTextField(rev_info_panel,suspension_identifier+" Revision",revision_field,class_c,"continue row");
    }
    
    private void addTextField(JPanel t_panel, String t_label, JTextField tf,
            GridBagConstraints c, String end_row) {
    	tf.setBorder( BorderFactory.createLineBorder(Color.white));
    	tf.setDisabledTextColor(Color.black);
        c.insets=new Insets(5,35,5,10);
        t_panel.add(new JLabel(t_label),c);
        
        c.insets=new Insets(5,0,5,35);
        if (end_row.equals("end row")) {
            c.gridwidth=GridBagConstraints.REMAINDER;
        }
        t_panel.add(tf, c);
        c.gridwidth=1; //reset gridwidth
    }
    
    
    private void getDBInfo() {
        ResultSet rs=null;
        
        rs=active_db_connection.db_calls.getRevision(current_work_order.work_order_id);
        try {
            if (rs.first()) {
                if (suspension_identifier.equals("Shock")){	revision_field.setText(replaceNulls(rs.getString("shock_rev")));}
                if (suspension_identifier.equals("Fork")){	revision_field.setText(replaceNulls(rs.getString("fork_rev")));}
            }
        }catch (SQLException e) {
            System.err.println("Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    private String replaceNulls(String input) {
    	//handle both nulls and zero amounts as returns from the db
            if ((input==null)||(input.equals("0"))) return "";
            else return input;
        }  
    
    public void enablePanelComponents() {
        enableTextField(revision_field);
    }
    
    public void disablePanelComponents() {
        disableTextField(revision_field);
    }
    
    public void enableTextField(JTextField tf) {
        tf.setEnabled(true);
        tf.setBackground(Color.white);
    }
    
    public void disableTextField(JTextField tf) {
    	tf.setEnabled(false);
    	tf.setBackground(Color.lightGray);
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        
    }
    
}//end class Item_Revision_Panel
