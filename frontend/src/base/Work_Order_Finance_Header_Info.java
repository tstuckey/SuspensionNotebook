package base;


import javax.swing.*;

import db_info.DB_Connection;

import java.awt.Color;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.sql.*;

public class Work_Order_Finance_Header_Info{
    JPanel control_numbers_panel;
    JTextField quote_area;
    JTextField sales_order_area;
    JTextField invoice_area;
    
    Integer labor_discount;
    Integer parts_discount;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Work_Order_Finance_Header_Info(Active_Work_Order work_order,
            JPanel parent_panel, GridBagConstraints parent_c, DB_Connection active_db_connection) {
        current_work_order=work_order;
        this.active_db_connection=active_db_connection;
        
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder("Information"),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        initializeClassVariables();
        setupTextFields(t_panel, c);
        getDBInfo();
        disablePanelComponents();
        
        parent_panel.add(t_panel,parent_c);
    }
    
    private void initializeClassVariables() {
        control_numbers_panel=initializeJPanel("");
        
        quote_area=initializeJTextField(10);
        sales_order_area=initializeJTextField(10);
        invoice_area=initializeJTextField(10);
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
    
    
    public void setupTextFields(JPanel t_panel, GridBagConstraints parent_c) {
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        c.weightx = 1.0;
        
        addTextField(control_numbers_panel, "Quote","#",quote_area,c);
        addTextField(control_numbers_panel, "Sales Order","#",sales_order_area,c);
        addTextField(control_numbers_panel, "Invoice","#",invoice_area,c);
        
        t_panel.add(control_numbers_panel,parent_c);
        
        clearTextFields();
    }
    
    public void addTextField(JPanel t_panel, String label_1,String label_2, JTextField tf,
            GridBagConstraints c) {
        tf.setBorder( BorderFactory.createLineBorder(Color.white));
        tf.setDisabledTextColor(Color.black);
        c.insets=new Insets(5,0,0,5);
        t_panel.add(new JLabel(label_1),c);
        
        c.insets=new Insets(0,0,0,5);
        t_panel.add(new JLabel(label_2),c);
        c.gridwidth=GridBagConstraints.REMAINDER;
        t_panel.add(tf, c);
        c.gridwidth=1; //reset gridwidth
    }
    
    private void getDBInfo() {
        ResultSet rs=null;
        rs=active_db_connection.db_calls.getFinanceHeaderInfo(current_work_order.work_order_id);
        
        try {
            if (rs.first()) {
                quote_area.setText(rs.getString("quote number"));
                sales_order_area.setText(rs.getString("sales order"));
                invoice_area.setText(rs.getString("invoice number"));
            }
        }catch (SQLException e) {
            System.err.println("Work_Order_Finance_Header:  Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    
    private void clearTextFields() {
        quote_area.setText("");
        sales_order_area.setText("");
        invoice_area.setText("");
    }
    
    public void enablePanelComponents() {
        enableTextField(quote_area);
        enableTextField(sales_order_area);
        enableTextField(invoice_area);
    }
    
    public void disablePanelComponents() {
        disableTextField(quote_area);
        disableTextField(sales_order_area);
        disableTextField(invoice_area);
    }
    
    private void enableTextField(JTextField ta) {
        ta.setEnabled(true);
        ta.setBackground(Color.white);
    }
    
    private void disableTextField(JTextField ta) {
        ta.setEnabled(false);
        ta.setBackground(Color.lightGray);
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
    	active_db_connection.db_calls.saveFinanceHeaderInfo(t_work_order.work_order_id, quote_area.getText(),
                sales_order_area.getText(), invoice_area.getText());
    }
    
}//end class Work_Order_Finance_Header_Info
