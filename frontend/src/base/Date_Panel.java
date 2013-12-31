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

public class Date_Panel{
    JPanel rev_info_panel;
    
    Item_Revision_Panel shock_revision;
    Item_Revision_Panel fork_revision;  
    JTextField date_field;
    GridBagConstraints class_c;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Date_Panel(JPanel parent_panel,Active_Work_Order work_order,
    		          GridBagConstraints parent_c, DB_Connection active_db_connection) {
        current_work_order=work_order;
        this.active_db_connection=active_db_connection;
        
        initializeClassVariables();
        setupTextFields();
        getDBInfo();
        disablePanelComponents();
        
        parent_panel.add(rev_info_panel,parent_c);
    }
    
    private void initializeClassVariables() {
        rev_info_panel=initializeJPanel("");
        
        class_c = new GridBagConstraints();
       
        class_c.anchor=GridBagConstraints.CENTER;
        class_c.weightx = 1.0;
        
        date_field = new JTextField();
        
        shock_revision= new Item_Revision_Panel(current_work_order,rev_info_panel,"Shock",class_c, active_db_connection);
        fork_revision= new Item_Revision_Panel(current_work_order,rev_info_panel,"Fork",class_c, active_db_connection);
    }
    
    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }
    
    private void setupTextFields() {
        addTextField(rev_info_panel,"Date of Last Revision",date_field,8,"continue row");
    }
    
    private void addTextField(JPanel parent_panel, String t_label, JTextField t_field,
            Integer cols,String end_row) {
    	JPanel t_panel=initializeJPanel("");
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.CENTER;
        c.weightx = 1.0;
        c.insets=new Insets(5,35,5,10);
        
        t_field.setBorder( BorderFactory.createLineBorder(Color.white));
    	t_field.setDisabledTextColor(Color.black);
    	t_field.setColumns(cols);
        
        t_panel.add(new JLabel(t_label),c);
        
        c.insets=new Insets(5,0,5,35);
        if (end_row.equals("end row")) {
            c.gridwidth=GridBagConstraints.REMAINDER;
        }
        t_panel.add(t_field, c);
        parent_panel.add(t_panel,class_c);
    }
    
    private void getDBInfo() {
        ResultSet rs=null;
        
        rs=active_db_connection.db_calls.getChangeDate(current_work_order.this_setting.setting_id);
        try {
            if (rs.first()) {
                date_field.setText(rs.getString("Date"));
            }
        }catch (SQLException e) {
            System.err.println("Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    public void enablePanelComponents() {
        enableTextField(date_field);
    }
    
    public void disablePanelComponents() {
        disableTextField(date_field);
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

      
}//end class Date_Panel
