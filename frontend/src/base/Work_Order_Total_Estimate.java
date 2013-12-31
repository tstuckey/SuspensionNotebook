package base;

import javax.swing.*;


import java.awt.Color;
import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.text.DecimalFormat;

public class Work_Order_Total_Estimate implements ActionListener {
    JPanel estimate_total_panel;
    
    Estimate_Panel shock_estimate;
    Estimate_Panel fork_estimate;
    
    JTextField total_estimate_field;
    
    Active_Work_Order current_work_order;
    public Work_Order_Total_Estimate(Active_Work_Order work_order, Work_Order_Shock_Info shock_info,
            Work_Order_Fork_Info fork_info, JComboBox ghost_box,
            JPanel parent_panel,GridBagConstraints parent_c) {
        current_work_order=work_order;
        
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(""),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        
        t_panel.setLayout(new GridBagLayout());
        GridBagConstraints c = new GridBagConstraints();
        c.weightx = 1.0;
        
        initializeClassVariables(ghost_box,shock_info, fork_info);
        setupTextField(t_panel, c);
        updateEstimateTotal();//Update the total based on the fork and shock estimate info
        disablePanelComponents();
        
        parent_panel.add(t_panel,parent_c);
    }
    
    private void initializeClassVariables(JComboBox ghost_box,Work_Order_Shock_Info shock_info,
            Work_Order_Fork_Info fork_info) {
        ghost_box.setActionCommand("ghost action");
        ghost_box.addActionListener(this);
        
        estimate_total_panel=initializeJPanel("");
        
        total_estimate_field=new JTextField(5);
        //Make the class shock and fork estimates reference those passed into the class
        shock_estimate=shock_info.shock_estimate;
        fork_estimate=fork_info.fork_estimate;
    }
    
    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }
    
    public void setupTextField(JPanel t_panel, GridBagConstraints parent_c) {
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        c.weightx = 1.0;
        
        addTextField(estimate_total_panel, "Total Estimate",total_estimate_field,c);
        
        t_panel.add(estimate_total_panel,parent_c);
        clearTextFields();
    }
    
    public void addTextField(JPanel t_panel, String label_1, JTextField tf,
            GridBagConstraints c) {
        tf.setBorder( BorderFactory.createLineBorder(Color.white));
        tf.setDisabledTextColor(Color.black);
        c.insets=new Insets(5,35,5,10);
        t_panel.add(new JLabel(label_1),c);
        
        c.insets=new Insets(5,0,5,0);
        t_panel.add(new JLabel("$"),c);
        //c.gridwidth=GridBagConstraints.REMAINDER;
        t_panel.add(tf, c);
        c.gridwidth=1; //reset gridwidth
    }
    
    private void clearTextFields() {
        total_estimate_field.setText("0");
    }
    
    public void enablePanelComponents() {
    }
    
    public void disablePanelComponents() {
        disableTextField(total_estimate_field);
    }
    
    private void disableTextField(JTextField tf) {
        tf.setEnabled(false);
        tf.setBackground(Color.lightGray);
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
    }
    
    private String formatToTwoPlaces(Double total) {
        DecimalFormat df=new DecimalFormat("####.##");
        String result=df.format(total);
        
        return result;
    }
    
    public void updateEstimateTotal() {
        //if the estimates are valid, total them up for display
        if ((shock_estimate.Costs_OK)&&(fork_estimate.Costs_OK)) {
            Double total=new Double(shock_estimate.subtotal+fork_estimate.subtotal);
            total_estimate_field.setText(formatToTwoPlaces(total));
        } else {
            total_estimate_field.setText("Invalid fork or shock estimates.");
        }
        total_estimate_field.repaint();
    }
    
    public void actionPerformed(ActionEvent e) {
        String cmd=e.getActionCommand();
        if (cmd.equals("ghost action")) {
            updateEstimateTotal();
        }
    }//end method actionPerformed
}//end class Work_Order_Total_Estimate
