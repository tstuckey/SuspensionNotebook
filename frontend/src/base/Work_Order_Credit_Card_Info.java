package base;


import javax.swing.*;

import db_info.DB_Connection;

import java.awt.Color;
import java.awt.Component;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.sql.*;

public class Work_Order_Credit_Card_Info {
    JPanel credit_card_panel;
    GridBagConstraints class_c;
    
    JTextField name_on_card;
    JTextField number_on_card;
    JTextField security_code;
    JTextField expiration;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Work_Order_Credit_Card_Info(Active_Work_Order work_order, JPanel parent_panel,
            GridBagConstraints parent_c,DB_Connection active_db_connection) {
        current_work_order=work_order;
        this.active_db_connection=active_db_connection;
        initializeClassVariables();
        setupTextAreas();
        getDBInfo(current_work_order);
        disablePanelComponents();
        
        parent_panel.add(credit_card_panel,parent_c);
    }
    
    private void initializeClassVariables()
    //This method is used instead of in the class variables declaration section because we need to call it again
    //when things are update
    {
        credit_card_panel=initializeJPanel("Credit Card Info");
        
        class_c = new GridBagConstraints();
        class_c.anchor=GridBagConstraints.NORTHWEST;
        
        name_on_card = initializeJTextField(10);
        number_on_card= initializeJTextField(10);
        security_code = initializeJTextField(10);
        expiration = initializeJTextField(10);
    }
    public JTextField initializeJTextField(int cols) {
        JTextField tf = new JTextField();
        tf.setColumns(cols);
        return tf;
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
        addTextField(credit_card_panel, "Name on Card",name_on_card,25,class_c);
        addTextField(credit_card_panel, "CC number",number_on_card,16,class_c);
        addTextField(credit_card_panel, "Security Code",security_code,4,class_c);
        addTextField(credit_card_panel, "Exp Date",expiration,10,class_c);
    }
    
    private void addTextField(JPanel t_panel, String t_label, JTextField tf,
            Integer cols,GridBagConstraints c) {
    	tf.setBorder( BorderFactory.createLineBorder(Color.white));
    	tf.setDisabledTextColor(Color.black);
    	tf.setColumns(cols);
        c.insets=new Insets(5,0,0,5);
        t_panel.add(new JLabel(t_label),c);
        
        c.insets=new Insets(0,0,0,5);
        c.gridwidth=GridBagConstraints.REMAINDER;
        t_panel.add(tf, c);
        c.gridwidth=1; //reset gridwidth
    }
    
    private void getDBInfo(Active_Work_Order work_order) {
        ResultSet rs=null;
        rs=active_db_connection.db_calls.getCreditCardInfo(work_order.work_order_id);
        
        try {
            if (rs.first()) {
                name_on_card.setText(rs.getString("name_on_card"));
                number_on_card.setText(rs.getString("number_on_card"));
                security_code.setText(rs.getString("security_code"));
                expiration.setText(rs.getString("expiration"));
            }
        }catch (SQLException e) {
            System.err.println("Work_Order_Credit_Card_Info: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    public void enablePanelComponents() {
        Component[] panel_components;
        panel_components=credit_card_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(true);
            if (panel_components[i].getClass().getName().contains("JTextField")) {
                enableTextField((JTextField)panel_components[i]);
            }
        }
    }
    
    public void disablePanelComponents() {
        Component[] panel_components;
        panel_components=credit_card_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(false);
            if (panel_components[i].getClass().getName().contains("JTextField")) {
                disableTextField((JTextField)panel_components[i]);
            }
        }
    }
    
    private void enableTextField(JTextField tf) {
    	tf.setEnabled(true);
    	tf.setBackground(Color.white);
    }
    
    private void disableTextField(JTextField tf) {
    	tf.setEnabled(false);
        tf.setBackground(Color.lightGray);
    }
    
    
    public void clearTextFields() {
        name_on_card.setText("");
        number_on_card.setText("");
        security_code.setText("");
        expiration.setText("");
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
    	active_db_connection.db_calls.saveCreditCardInfo(t_work_order.work_order_id,
                name_on_card.getText().trim(),
                number_on_card.getText().trim(),
                security_code.getText().trim(),
                expiration.getText().trim());
    }
    
}//end class Work_Order_Credit_Card_Info

