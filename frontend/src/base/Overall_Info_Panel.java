package base;
import java.util.*;
import javax.swing.*;

import db_info.DB_Connection;

import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.sql.*;

public class Overall_Info_Panel implements ItemListener {
    JPanel calling_panel;
    GridBagConstraints calling_c = new GridBagConstraints();
    
    JPanel general_panel;
    
    JPanel turnaround_time_panel;
    JPanel replace_springs_panel;
    JPanel replace_bearing_panel;
    JPanel overall_work_permission_panel;
    
    JCheckBox yes_to_replace_springs;
    JCheckBox no_to_replace_springs;
    JCheckBox call_to_replace_springs;
    
    JCheckBox yes_to_replace_bearing;
    JCheckBox no_to_replace_bearing;
    JCheckBox call_to_replace_bearing;
    
    JCheckBox call_prior_to_work;
    
    JComboBox turnaround_box;
    Vector<Integer> ref_turnaround;
    
    Integer Call_Prior_to_Work; //0 is No, 1 is Yes
    Integer OK_to_Replace; //0=No, 1=Yes, 2=Call
    Integer OK_to_Replace_Bearing; //0=No, 1=Yes, 2=Call
    
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Overall_Info_Panel(Active_Work_Order work_order,JPanel parent_panel,
            GridBagConstraints parent_c, DB_Connection active_db_connection) {
        current_work_order=work_order;
        calling_panel=parent_panel;
        calling_c=parent_c;//store the incoming GridBagConstraint argument in the class variable
        this.active_db_connection=active_db_connection;
        
        initializeClassVariables();
        buildSpringsCheckBoxes();
        getDBInfo();
        disablePanelComponents();
    }
    
    private void initializeClassVariables() {
        general_panel=new JPanel();
        general_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder("Overall Info"),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        general_panel.setLayout(new GridBagLayout());
        
        turnaround_time_panel=initializeJPanel("Turnaround Time");
        replace_springs_panel=initializeJPanel("OK to Replace Springs?");
        replace_bearing_panel=initializeJPanel("OK to Replace Shock Inlet Bearing?");
        overall_work_permission_panel=initializeJPanel("Work Permission");
        
        yes_to_replace_springs=new JCheckBox("Yes");
        no_to_replace_springs=new JCheckBox("No");
        call_to_replace_springs=new JCheckBox("Call");
        
        yes_to_replace_bearing=new JCheckBox("Yes");
        no_to_replace_bearing=new JCheckBox("No");
        call_to_replace_bearing=new JCheckBox("Call");
        
        call_prior_to_work=new JCheckBox("call customer prior to work?");
        
        turnaround_box=new JComboBox();
        ref_turnaround=new Vector<Integer>();
        setupComboBox(turnaround_time_panel,turnaround_box, ref_turnaround, "days","num_days");
        
        calling_panel.add(general_panel, calling_c);
    }
    
    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }
    
    public void setupComboBox(JPanel t_panel, JComboBox c_box, Vector<Integer> c_box_ref,
            String table_name, String lookup_field) {
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        c.gridwidth=1;
        
        Vector<String> items1;
        
        items1=active_db_connection.db_calls.getAllValues(table_name,lookup_field,"row_id",c_box_ref);
        //Add a blank space at the top of the selections,
        //and add a corresponding zero to the reference vector
        c_box.addItem("");
        c_box_ref.insertElementAt(0,0);
        
        for (int i=0;i<items1.size();i++) {
            c_box.addItem(items1.elementAt(i));
        }
        if (items1.size()>0) {
            c_box.setSelectedIndex(0);
        }
        c.insets=new Insets(5,0,0,5);
        t_panel.add(c_box, c);
    }
    
    
    private void alignComboBox(JComboBox c_box, String db_string) {
        for(int i=0;i<c_box.getItemCount();i++)
            if ( ((String)c_box.getItemAt(i)).equals(db_string) ) {
            c_box.setSelectedIndex(i);
            return;
            }
        c_box.setSelectedIndex(0);
    }
    
    private void getDBInfo() {
        ResultSet rs=null;
        rs=active_db_connection.db_calls.getOverallInfo(current_work_order.work_order_id);
        try {
            if (rs.first()) {
                OK_to_Replace=rs.getInt("ok_to_replace"); //0=No, 1=Yes, 2=Call
                OK_to_Replace_Bearing=rs.getInt("ok_to_replace_bearing"); //0=No, 1=Yes, 2=Call
                Call_Prior_to_Work=rs.getInt("call_prior"); //0 is No, 1 is Yes
                
                if (OK_to_Replace==0) {
                    no_to_replace_springs.setSelected(true);
                }
                if (OK_to_Replace==1) {
                    yes_to_replace_springs.setSelected(true);
                }
                if (OK_to_Replace==2) {
                    call_to_replace_springs.setSelected(true);
                }
                
                if (OK_to_Replace_Bearing==0) {
                    no_to_replace_bearing.setSelected(true);
                }
                if (OK_to_Replace_Bearing==1) {
                    yes_to_replace_bearing.setSelected(true);
                }
                if (OK_to_Replace_Bearing==2) {
                    call_to_replace_bearing.setSelected(true);
                }
                
                //Handle Empty work orders so info does get
                if (rs.getString("ok_to_replace")==null)//handle empty work order
                {
                    no_to_replace_springs.setSelected(false);
                    yes_to_replace_springs.setSelected(false);
                    call_to_replace_springs.setSelected(false);
                }
                if (rs.getString("ok_to_replace_bearing")==null)//handle empty work order
                {
                    no_to_replace_bearing.setSelected(false);
                    yes_to_replace_bearing.setSelected(false);
                    call_to_replace_bearing.setSelected(false);
                }
                
                alignComboBox(turnaround_box,rs.getString("Turn Around"));
                if (Call_Prior_to_Work==1) call_prior_to_work.setSelected(true);
                if (Call_Prior_to_Work==0) call_prior_to_work.setSelected(false);
            }
        }catch (SQLException e) {
            System.err.println("Overall_Info_Panel:Problem retrieving data.");
            e.printStackTrace();
        }
    }
    
    private void buildSpringsCheckBoxes() {
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        c.gridwidth=1;
        
        call_prior_to_work.addItemListener(this);
        overall_work_permission_panel.add(call_prior_to_work, c);
        
        yes_to_replace_springs.addItemListener(this);
        replace_springs_panel.add(yes_to_replace_springs,c);
        no_to_replace_springs.addItemListener(this);
        replace_springs_panel.add(no_to_replace_springs,c);
        call_to_replace_springs.addItemListener(this);
        replace_springs_panel.add(call_to_replace_springs,c);
        
        yes_to_replace_bearing.addItemListener(this);
        replace_bearing_panel.add(yes_to_replace_bearing,c);
        no_to_replace_bearing.addItemListener(this);
        replace_bearing_panel.add(no_to_replace_bearing,c);
        call_to_replace_bearing.addItemListener(this);
        replace_bearing_panel.add(call_to_replace_bearing,c);
        
        GridBagConstraints c2 = new GridBagConstraints();
        
        c2.gridwidth=GridBagConstraints.REMAINDER;
        c2.ipadx=100;
        general_panel.add(turnaround_time_panel, c2);
        general_panel.add(overall_work_permission_panel, c2);
        general_panel.add(replace_springs_panel, c2);
        general_panel.add(replace_bearing_panel, c2);
    }
    
    public void disablePanelComponents() {
        call_prior_to_work.setEnabled(false);
        turnaround_box.setEnabled(false);
        
        yes_to_replace_springs.setEnabled(false);
        no_to_replace_springs.setEnabled(false);
        call_to_replace_springs.setEnabled(false);
        
        yes_to_replace_bearing.setEnabled(false);
        no_to_replace_bearing.setEnabled(false);
        call_to_replace_bearing.setEnabled(false);
    }
    
    public void enablePanelComponents() {
        call_prior_to_work.setEnabled(true);
        turnaround_box.setEnabled(true);
        
        yes_to_replace_springs.setEnabled(true);
        no_to_replace_springs.setEnabled(true);
        call_to_replace_springs.setEnabled(true);
        
        yes_to_replace_bearing.setEnabled(true);
        no_to_replace_bearing.setEnabled(true);
        call_to_replace_bearing.setEnabled(true);
    }
    
    
    public void saveInfo(Active_Work_Order t_work_order) {
        //Need_Springs is  0 for No, 1 for Yes
        //OK_to_Replace is 0 for No, 1 for Yes, 2 for Call
        
    	active_db_connection.db_calls.saveOverallInfo(t_work_order.work_order_id,
                OK_to_Replace, OK_to_Replace_Bearing,
                Call_Prior_to_Work,
                ref_turnaround.elementAt(turnaround_box.getSelectedIndex())
                );
    }
    
    /** Listens to the check boxes. */
    public void itemStateChanged(ItemEvent e) {
        Object source = e.getItemSelectable();
        
        if ((source==call_prior_to_work)&&(e.getStateChange()==ItemEvent.SELECTED)) {
            Call_Prior_to_Work=1;
        }
        
        if ((source==call_prior_to_work)&&(e.getStateChange()==ItemEvent.DESELECTED)) {
            Call_Prior_to_Work=0;
        }
        
        if ((source==yes_to_replace_springs)&&(e.getStateChange()==ItemEvent.SELECTED)) {
            OK_to_Replace=1;
            yes_to_replace_springs.setSelected(true);
            no_to_replace_springs.setSelected(false);
            call_to_replace_springs.setSelected(false);
        }
        
        if ((source==no_to_replace_springs)&&(e.getStateChange()==ItemEvent.SELECTED)) {
            OK_to_Replace=0;
            yes_to_replace_springs.setSelected(false);
            no_to_replace_springs.setSelected(true);
            call_to_replace_springs.setSelected(false);
        }
        
        if ((source==call_to_replace_springs)&&(e.getStateChange()==ItemEvent.SELECTED)) {
            OK_to_Replace=2;
            yes_to_replace_springs.setSelected(false);
            no_to_replace_springs.setSelected(false);
            call_to_replace_springs.setSelected(true);
        }
        
        if ((source==yes_to_replace_bearing)&&(e.getStateChange()==ItemEvent.SELECTED)) {
            OK_to_Replace_Bearing=1;
            yes_to_replace_bearing.setSelected(true);
            no_to_replace_bearing.setSelected(false);
            call_to_replace_bearing.setSelected(false);
        }
        
        if ((source==no_to_replace_bearing)&&(e.getStateChange()==ItemEvent.SELECTED)) {
            OK_to_Replace_Bearing=0;
            yes_to_replace_bearing.setSelected(false);
            no_to_replace_bearing.setSelected(true);
            call_to_replace_bearing.setSelected(false);
        }
        
        if ((source==call_to_replace_bearing)&&(e.getStateChange()==ItemEvent.SELECTED)) {
            OK_to_Replace_Bearing=2;
            yes_to_replace_bearing.setSelected(false);
            no_to_replace_bearing.setSelected(false);
            call_to_replace_bearing.setSelected(true);
        }
    }
    
}//end class Overall_Info_Panel
