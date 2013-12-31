package base;
import java.util.*;
import javax.swing.*;

import java.awt.Color;
import java.awt.Component;
import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.sql.*;
import javax.swing.JOptionPane;

import db_info.DB_Connection;

public class Additional_Products implements ActionListener,ItemListener {
    String product_identifier;
    
    Vector<String> all_products;
    Vector<Integer> all_products_ref;
    
    Vector<String> valid_product_descriptions;
    Vector<String> valid_product_comments;
    
    Vector<JCheckBox> displayed_products;
    Vector<JTextField> displayed_products_comments;
    
    JPanel the_parent_panel;
    JPanel add_products_panel;
    JPanel box_panel;
    GridBagConstraints class_c;
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Additional_Products(Active_Work_Order this_work_order, JPanel parent_panel,
            GridBagConstraints parent_c, String t_prod_id, DB_Connection active_db_connection) {
        current_work_order=this_work_order;
        the_parent_panel=parent_panel;
        product_identifier=t_prod_id; //set the Product Identifier to either "Fork" or "Shock"
        this.active_db_connection=active_db_connection;
    	add_products_panel=initializeJPanel("");
        initializeClassVariables();
        getProducts(current_work_order);
        createProductsCheckBox(add_products_panel);
        disableSubComponents();
                
        the_parent_panel.add(add_products_panel,parent_c);
    }
    
    private void initializeClassVariables()
    //This method is used instead of in the class variables declaration section because we need to call it again
    //when things are updated
    {
        class_c = new GridBagConstraints();
        class_c.anchor=GridBagConstraints.NORTHWEST;
                
    	all_products=new Vector<String>();
        all_products_ref = new Vector<Integer>();
        
        valid_product_descriptions=new Vector<String>();
        valid_product_comments=new Vector<String>();
        
        displayed_products=new Vector<JCheckBox>();
        displayed_products_comments=new Vector<JTextField>();
        
        box_panel=initializeJPanel(product_identifier+" Additional Products");
    }
    
    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }    
        
    private void createProductsCheckBox(JPanel parent_panel) {
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.CENTER;
        
        JButton add_product_button = new JButton("Add Product");
        add_product_button.setActionCommand("add product");
        add_product_button.addActionListener(this);
        c.gridwidth=GridBagConstraints.REMAINDER;
        c.insets=new Insets(0,0,5,0);
        box_panel.add(add_product_button,c);
        c.insets=new Insets(0,0,0,0);
        
        if (product_identifier.equals("Fork")) {
            all_products=active_db_connection.db_calls.getAllValues("fork_additional_products","description","row_id",all_products_ref);
        }
        if (product_identifier.equals("Shock")) {
            all_products=active_db_connection.db_calls.getAllValues("shock_additional_products","description","row_id",all_products_ref);
        }
        
        for (int i=0;i<all_products.size();i++) {
            JCheckBox t_checkbox=new JCheckBox(all_products.elementAt(i));
            JTextField t_field=initializeJTextField(10);
            displayed_products.add(t_checkbox);
            t_checkbox.addItemListener(this);
            c.anchor=GridBagConstraints.NORTHWEST; 
            c.gridwidth=1;
            box_panel.add(t_checkbox,c);
            
            //see if this setting uses this additional product
            //if the "valid_product_descriptions" vector contains the product in the vector "all_products"
            //at this point, mark the box with a check mark and add the textbox with the corresponding description
            int prod_index=valid_product_descriptions.indexOf(all_products.elementAt(i));
            c.anchor=GridBagConstraints.NORTHEAST;
            c.gridwidth=GridBagConstraints.REMAINDER;
            if (prod_index>=0) {
                t_checkbox.setSelected(true);//mark it with a checkmark
                //now create a textfield with the user's comment if there was one
                addTextField(box_panel, t_field,valid_product_comments.elementAt(prod_index),c);
            } else {
                //add a blank textfield in case the user wants to add something later
                addTextField(box_panel, t_field,"",c);
            }
            displayed_products_comments.add(t_field);
        }
        parent_panel.add(box_panel, class_c);
    }
    public JTextField initializeJTextField(int cols) {
        JTextField tf = new JTextField(cols);
        return tf;
    } 
    public void addTextField(JPanel t_panel,JTextField t_field, String text, GridBagConstraints c) {
    	t_field.setBorder( BorderFactory.createLineBorder(Color.white));
    	t_field.setText(text);
    	t_field.setDisabledTextColor(Color.black);
        t_panel.add(t_field, c);
      }
    
    
    private void getProducts(Active_Work_Order current_work_order) {
        ResultSet rs=null;
        
        if (product_identifier.equals("Fork")) {
            rs=active_db_connection.db_calls.getSettingsForkAdditionalProducts(current_work_order.work_order_id);
        } else {
            rs=active_db_connection.db_calls.getSettingsShockAdditionalProducts(current_work_order.work_order_id);
        }
        try {
            if (rs.first()) {
                do
                {
                    valid_product_descriptions.add(rs.getString("Description"));//add to the class Vector
                    valid_product_comments.add(rs.getString("Comments"));//add to the class Vector
                }while (rs.next());
            }
        }catch (SQLException e) {
            System.err.println("Additional_Products: Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    public void enableSubComponents() {
        Component[] panel_components;
        panel_components=box_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(true);
            if (panel_components[i].getClass().getName().contains("JTextField")) {
                enableTextField((JTextField)panel_components[i]);
            }
        }
    }
    
    public void disableSubComponents() {
        Component[] panel_components;
        panel_components=box_panel.getComponents();
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
    
    
    /** Listens to the check boxes. */
    public void itemStateChanged(ItemEvent e) {
        //Now that we know which button was pushed, find out
        //whether it was selected or deselected
        if (e.getStateChange() == ItemEvent.DESELECTED) {
        }
    }
    
    
    public void saveInfo(Active_Work_Order t_work_order) {
        //Before we add new additional products information, we need to remove the old associations for this setting
    	active_db_connection.db_calls.removeAdditionalProductsFromWorkOrder(t_work_order.work_order_id, product_identifier);
        
        for (int i=0;i<displayed_products.size();i++) {
            if (displayed_products.elementAt(i).isSelected()) {
                //for the next call, remember the displayed_products and the all_products_ref vectors are both referencing
                //the same location; displayed_products references the JCheckBox object and all_products_ref references the
                //db identifers for the String displayed beside the JCheckBox
            	active_db_connection.db_calls.saveAdditionalProducts(t_work_order.work_order_id,
                        product_identifier,all_products_ref.elementAt(i),
                        displayed_products_comments.elementAt(i).getText().trim()
                        );
            }
        }
    }
    
    public void actionPerformed(ActionEvent e) {
        String cmd=e.getActionCommand();
        if (cmd.equals("add product")) {
            String result=JOptionPane.showInputDialog(null, "Type in New Product Description");
            if  ( (result !=null)&&(!(result.trim()).equals("")) ) {
                if (!all_products.contains(result)) {
                    if (product_identifier.equals("Fork")) {
                    	active_db_connection.db_calls.addForkAdditionalProduct(result);
                    } else {
                    	active_db_connection.db_calls.addShockAdditionalProduct(result);
                    }
                    
                    /*Update the boxes with the new selection*/
                    add_products_panel.remove(box_panel);
                    initializeClassVariables();
                    getProducts(current_work_order);
                    createProductsCheckBox(add_products_panel);
                    add_products_panel.add(box_panel,class_c);
                } else {
                    JOptionPane.showMessageDialog(null, "Product Already Present", "Warning",
                            JOptionPane.WARNING_MESSAGE,null);
                }
            }
        }
    }
    
}//end class Additional_Products

