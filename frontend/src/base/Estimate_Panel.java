package base;

import java.util.*;
import java.util.zip.DataFormatException;
import javax.swing.*;
import utilities.UnitFormatting;
import db_info.DB_Connection;
import java.awt.Color;
import java.awt.Component;
import java.awt.event.*;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.sql.*;

public class Estimate_Panel implements ItemListener, ActionListener, FocusListener, KeyListener {
    String Work_Identifier;
    GridBagConstraints class_c;
    JPanel estimate_panel;
    JPanel springs_panel;
    JPanel dollars_panel;
    
    JTextField spring_rate_field;
    
    JTextField labor_area;
    JTextField fluid_area;
    JTextField spring_area;
    JTextField parts_area;
    JTextField coatings_area;
    JTextField other_area;
    
    Integer  labor_discount;
    Integer  fluid_discount;
    Integer  spring_discount;
    Integer  parts_discount;
    Integer  coatings_discount;
    Integer  other_discount;
    
    Double labor_discount_percentage;
    Double fluid_discount_percentage;
    Double spring_discount_percentage;
    Double parts_discount_percentage;
    Double coatings_discount_percentage;
    Double other_discount_percentage;
    
    public Double subtotal;
    
    JComboBox labor_discount_box;
    JComboBox fluid_discount_box;
    JComboBox spring_discount_box;
    JComboBox parts_discount_box;
    JComboBox coatings_discount_box;
    JComboBox other_discount_box;
    
    Vector<Integer> ref_labor_discount;
    Vector<Integer> ref_fluid_discount;
    Vector<Integer> ref_spring_discount;
    Vector<Integer> ref_parts_discount;
    Vector<Integer> ref_coatings_discount;
    Vector<Integer> ref_other_discount;
    
    JPanel need_springs_panel;
    
    JCheckBox yes_need_spring;
    JCheckBox no_need_spring;
    
    Integer Need_Springs=-1;//O=No, 1=Yes
    public Boolean Costs_OK=true;//set the flag to indicate the costs are valid
    JComboBox local_ghost_box;
    Active_Work_Order current_work_order;
    DB_Connection active_db_connection;
    public Estimate_Panel(Active_Work_Order work_order, JComboBox ghost_box,
            JPanel parent_panel,
            GridBagConstraints parent_c, String t_prod_id, DB_Connection active_db_connection) {
        local_ghost_box=ghost_box;
        current_work_order=work_order;
        Work_Identifier=t_prod_id; //set the Service Identifier to either "Fork" or "Shock"
        this.active_db_connection=active_db_connection;
        
        initializeClassVariables();
        setupTextFieldsComboBoxes();
        buildSpringsCheckBoxes();
        getDBInfo();
        disablePanelComponents();
        
        parent_panel.add(estimate_panel, parent_c);
    }
    
    private void initializeClassVariables() {
        estimate_panel=initializeJPanel("");
    	springs_panel=initializeJPanel("");
        dollars_panel=initializeJPanel(Work_Identifier+" Cost Estimate");
        
        class_c = new GridBagConstraints();
        
        labor_discount=0;
        fluid_discount=0;
        spring_discount=0;
        parts_discount=0;
        coatings_discount=0;
        other_discount=0;
        
        labor_discount_percentage=new Double(0);
        fluid_discount_percentage=new Double(0);
        spring_discount_percentage=new Double(0);
        parts_discount_percentage=new Double(0);
        coatings_discount_percentage=new Double(0);
        other_discount_percentage=new Double(0);
        
        subtotal=new Double("0");
        
        labor_area = initializeJTextField(10);
        fluid_area = initializeJTextField(10);
        spring_area = initializeJTextField(10);
        parts_area = initializeJTextField(10);
        coatings_area = initializeJTextField(10);
        other_area = initializeJTextField(10);
        
        //Probably need to set up a new focus traversal policy for the jtables here so they advance when ENTER is pressed instead of just TAB
        labor_discount_box=new JComboBox();
        labor_discount_box.setActionCommand("discount");
        labor_discount_box.addActionListener(this);
        fluid_discount_box=new JComboBox();
        fluid_discount_box.setActionCommand("discount");
        fluid_discount_box.addActionListener(this);
        spring_discount_box=new JComboBox();
        spring_discount_box.setActionCommand("discount");
        spring_discount_box.addActionListener(this);
        parts_discount_box=new JComboBox();
        parts_discount_box.setActionCommand("discount");
        parts_discount_box.addActionListener(this);
        coatings_discount_box=new JComboBox();
        coatings_discount_box.setActionCommand("discount");
        coatings_discount_box.addActionListener(this);
        other_discount_box=new JComboBox();
        other_discount_box.setActionCommand("discount");
        other_discount_box.addActionListener(this);
        
        ref_labor_discount=new Vector<Integer>();
        ref_fluid_discount=new Vector<Integer>();
        ref_spring_discount=new Vector<Integer>();
        ref_parts_discount=new Vector<Integer>();
        ref_coatings_discount=new Vector<Integer>();
        ref_other_discount=new Vector<Integer>();
        
        need_springs_panel=initializeJPanel(Work_Identifier+" Spring Required?");
        
        yes_need_spring=new JCheckBox("Yes");
        no_need_spring=new JCheckBox("No");
        
        spring_rate_field=initializeJTextField(10);
        spring_rate_field.setName("spring rate");
    }
    public JTextField initializeJTextField(int cols) {
        JTextField tf = new JTextField(cols);
        tf.addFocusListener(this);
        tf.addKeyListener(this);
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
    
    public void setupTextFieldsComboBoxes() {
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        addTextField(dollars_panel, "Labor ",labor_area,c);
        buildComboBox(labor_discount_box,ref_labor_discount,"Labor Discount",dollars_panel,c);
        addTextField(dollars_panel, "Fluid ",fluid_area,c);
        buildComboBox(fluid_discount_box,ref_fluid_discount,"Fluid Discount",dollars_panel,c);
        addTextField(dollars_panel, "Springs ",spring_area,c);
        buildComboBox(spring_discount_box,ref_spring_discount,"Springs Discount",dollars_panel,c);
        addTextField(dollars_panel, "Parts ",parts_area,c);
        buildComboBox(parts_discount_box,ref_parts_discount,"Parts Discount",dollars_panel,c);
        addTextField(dollars_panel, "Coatings ",coatings_area,c);
        buildComboBox(coatings_discount_box,ref_coatings_discount,"Coatings Discount",dollars_panel,c);
        addTextField(dollars_panel, "Other ",other_area,c);
        buildComboBox(other_discount_box,ref_other_discount,"Other Discount",dollars_panel,c);
        
        estimate_panel.add(dollars_panel,class_c);
        
        clearTextFields();
    }
    
    public void addTextField(JPanel t_panel, String t_label, JTextField t_field,
            GridBagConstraints parent_c) {
        
    	parent_c.anchor=GridBagConstraints.NORTHWEST;
    	t_field.setBorder( BorderFactory.createLineBorder(Color.white));
        t_field.setDisabledTextColor(Color.black);
        parent_c.insets=new Insets(0,0,0,5);
        t_panel.add(new JLabel(t_label),parent_c);
        parent_c.insets=new Insets(0,0,0,0);
        t_panel.add(new JLabel("$"),parent_c);
        t_panel.add(t_field, parent_c);
        parent_c.gridwidth=1; //reset gridwidth
    }
    
    private Vector<String> populateDiscountVector(){
    Vector<String> items=new Vector<String>();
    items.add("10");
    items.add("15");
    items.add("20");
    items.add("25");
    items.add("30");
    items.add("35");
    items.add("40");
    items.add("45");
    items.add("50");
    items.add("60");
    items.add("75");
    items.add("100");
    return items;
    }
    
    public void buildComboBox(JComboBox c_box, Vector<Integer> c_box_ref,String label,
            JPanel parent_panel, GridBagConstraints parent_c) {
    	parent_c.anchor=GridBagConstraints.NORTHEAST;
    	Vector<String> items=populateDiscountVector();
        putBlankFirstPosition(c_box, c_box_ref);
        
        for (int i=0;i<items.size();i++) {
            c_box.addItem(items.elementAt(i)+"%");
        }
        
        if (items.size()>0) {
            c_box.setSelectedIndex(0);
        }
        parent_c.insets=new Insets(0,0,0,5);
        parent_panel.add(new JLabel(label),parent_c);
        parent_c.insets=new Insets(0,0,0,0);
        parent_c.gridwidth=GridBagConstraints.REMAINDER;
        
        parent_panel.add(c_box, parent_c);
        parent_c.gridwidth=1; //reset gridwidth
    }
    
    private void getDBInfo() {
        ResultSet rs=null;
        if (Work_Identifier.equals("Fork")) {
            rs=active_db_connection.db_calls.getForkEstimateInfo(current_work_order.work_order_id);
        }
        if (Work_Identifier.equals("Shock")) {
            rs=active_db_connection.db_calls.getShockEstimateInfo(current_work_order.work_order_id);
        }
        try {
            if (rs.first()) {
                labor_area.setText(rs.getString("labor"));
                alignComboBox(labor_discount_box,rs.getString("labor_discount"));
                fluid_area.setText(rs.getString("fluid"));
                alignComboBox(fluid_discount_box,rs.getString("fluid_discount"));
                spring_area.setText(rs.getString("springs"));
                alignComboBox(spring_discount_box,rs.getString("springs_discount"));
                parts_area.setText(rs.getString("parts"));
                alignComboBox(parts_discount_box,rs.getString("parts_discount"));
                coatings_area.setText(rs.getString("coatings"));
                alignComboBox(coatings_discount_box,rs.getString("coatings_discount"));
                other_area.setText(rs.getString("other"));
                alignComboBox(other_discount_box,rs.getString("other_discount"));
                
                //Quick format cleanup
                if (rs.getString("labor")==null) labor_area.setText("0");
                if (rs.getString("fluid")==null) fluid_area.setText("0");
                if (rs.getString("springs")==null) spring_area.setText("0");
                if (rs.getString("parts")==null) parts_area.setText("0");
                if (rs.getString("coatings")==null) coatings_area.setText("0");
                if (rs.getString("other")==null) other_area.setText("0");
            }
        }catch (SQLException e) {
            System.err.println("Estimate_Panel:Problem retrieving data.");
            e.printStackTrace();
        }
        
        rs=null;
        if (Work_Identifier.equals("Fork")) {
            rs=active_db_connection.db_calls.getForkNeedSpringsInfo(current_work_order.work_order_id);
        }
        if (Work_Identifier.equals("Shock")) {
            rs=active_db_connection.db_calls.getShockNeedSpringsInfo(current_work_order.work_order_id);
        }
        try {
            if (rs.first()) {
                if (Work_Identifier.equals("Fork")) {
                    Need_Springs=rs.getInt("need_fork_spring");//O=No, 1=Yes
                }
                if (Work_Identifier.equals("Shock")) {
                    Need_Springs=rs.getInt("need_shock_spring");//O=No, 1=Yes
                }
                
                //If the shock needed a spring, align the spring_rate_combobox
                //with the appropriate spring rate
                if (Need_Springs==0) {
                    yes_need_spring.setSelected(false);
                    no_need_spring.setSelected(true);
                }
                if (Need_Springs==1) {
                    yes_need_spring.setSelected(true);
                    no_need_spring.setSelected(false);
                    //If the shock needed a spring, align the spring_rate_combobox
                    //with the appropriate spring rate
                    spring_rate_field.setText(UnitFormatting.replaceNulls(rs.getString("Rate"),
							UnitFormatting.rate_measure,
							UnitFormatting.rate_limit,"Double"));
                }
            }
        }
        catch (SQLException e) {
            System.err.println("Estimate_Panel:Problem retrieving data.");
            e.printStackTrace();
        }
		catch (DataFormatException e) {
			System.err.println("Estimate_Panel:  Problem with format of initial data");
			e.printStackTrace();
		}	
    }
    
    private void buildSpringsCheckBoxes() {
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        yes_need_spring.addItemListener(this);
        need_springs_panel.add(yes_need_spring,c);
        c.gridwidth=GridBagConstraints.REMAINDER;
        need_springs_panel.add(spring_rate_field,c);
        
        no_need_spring.addItemListener(this);
        need_springs_panel.add(no_need_spring,c);
        
        c.gridwidth=GridBagConstraints.REMAINDER;
        
        c.ipadx=50;
        springs_panel.add(need_springs_panel, c);
        
        estimate_panel.add(springs_panel, class_c);
    }
    
    
    private void putBlankFirstPosition(JComboBox c_box, Vector <Integer> ref_vec) {
        //Add a blank space at the top of the selections,
        //and add a corresponding zero to the reference vector
        c_box.addItem("");
        ref_vec.insertElementAt(0,0);
    }
    
    private void clearTextFields() {
        labor_area.setText("0");
        fluid_area.setText("0");
        spring_area.setText("0");
        parts_area.setText("0");
        coatings_area.setText("0");
        other_area.setText("0");
    }
    
    public void disablePanelComponents() {
        disableTextField(labor_area);
        disableTextField(fluid_area);
        disableTextField(spring_area);
        disableTextField(parts_area);
        disableTextField(coatings_area);
        disableTextField(other_area);
        
        labor_area.setEnabled(false);
        fluid_area.setEnabled(false);
        spring_area.setEnabled(false);
        parts_area.setEnabled(false);
        coatings_area.setEnabled(false);
        other_area.setEnabled(false);
        disableComboBox(labor_discount_box);
        disableComboBox(fluid_discount_box);
        disableComboBox(spring_discount_box);
        disableComboBox(parts_discount_box);
        disableComboBox(coatings_discount_box);
        disableComboBox(other_discount_box);
        disableTextField(spring_rate_field);
        disableComponentArray(need_springs_panel);
    }
    
    public void disableComponentArray(JPanel t_panel) {
        Component[] panel_components;
        panel_components=t_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            panel_components[i].setEnabled(false);
        }
    }
    
    public void disableComboBox(JComboBox c_box) {
        c_box.setEnabled(false);
    }
    
    public void enablePanelComponents() {
        enableTextField(labor_area);
        enableTextField(fluid_area);
        enableTextField(spring_area);
        enableTextField(parts_area);
        enableTextField(coatings_area);
        enableTextField(other_area);
        
        enableComboBox(labor_discount_box);
        enableComboBox(fluid_discount_box);
        enableComboBox(spring_discount_box);
        enableComboBox(parts_discount_box);
        enableComboBox(coatings_discount_box);
        enableComboBox(other_discount_box);
        enableTextField(spring_rate_field);
        enableComponentArray(need_springs_panel);
    }
    
    public void enableComponentArray(JPanel t_panel) {
        Component[] panel_components;
        panel_components=t_panel.getComponents();
        int max=panel_components.length;
        for(int i=0;i<max;i++) {
            //for the user interface to logically operate correctly, we need to
            //exclude the spring_rate_combobox form our mass enabling
            //its enabling is tied to the "yes_need_spring" checkbox
            if (panel_components[i]!=spring_rate_field) {
                panel_components[i].setEnabled(true);
            }
        }
    }
    
    public void enableComboBox(JComboBox c_box) {
        c_box.setEnabled(true);
    }
    
    private void enableTextField(JTextField ta) {
        ta.setEnabled(true);
        ta.setBackground(Color.white);
    }
    
    private void disableTextField(JTextField ta) {
        ta.setEnabled(false);
        ta.setBackground(Color.lightGray);
    }
    
    private void alignComboBox(JComboBox c_box, String db_string) {
	//do nothing if the string was null, just return
        if (db_string==null) return;
	    
        for(int i=0;i<c_box.getItemCount();i++)
            if ( ((String)c_box.getItemAt(i)).equals(db_string) ) {
            c_box.setSelectedIndex(i);
            return;
            }
        c_box.setSelectedIndex(0);
    }
    
    private double convertTextFieldsToDecimals(String input) {
        try {
            Double result=new Double(input);
            return result;
        }catch (NumberFormatException num_except) {
            return -1;
        }
        
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
		if (!Costs_OK){
			JOptionPane.showMessageDialog(null,
					"There is one or more data format errors in\n "+this.Work_Identifier+" cost estimate for the data to be saved.",
					"Warning",JOptionPane.WARNING_MESSAGE,null);
			return;
		}  	
    	
    	String rate;
    	Double labor_cost;
        Double fluid_cost;
        Double springs_cost;
        Double parts_cost;
        Double coatings_cost;
        Double other_cost;
    	try{
    	 rate=UnitFormatting.genDoubleValue(spring_rate_field.getText(), 
        		                                  UnitFormatting.rate_measure, 
        		                                  UnitFormatting.rate_limit);
        //Need_Springs is  0 for No, 1 for Yes
         labor_cost=convertTextFieldsToDecimals(labor_area.getText());
         fluid_cost=convertTextFieldsToDecimals(fluid_area.getText());
         springs_cost=convertTextFieldsToDecimals(spring_area.getText());
         parts_cost=convertTextFieldsToDecimals(parts_area.getText());
         coatings_cost=convertTextFieldsToDecimals(coatings_area.getText());
         other_cost=convertTextFieldsToDecimals(other_area.getText());
    	}
        catch (Exception e){
        	 rate=new Double("0").toString();
        	 labor_cost=new Double("0");
             fluid_cost=new Double("0");
             springs_cost=new Double("0");
             parts_cost=new Double("0");
             coatings_cost=new Double("0");
             other_cost=new Double("0");
        }
        
        if (Costs_OK) {
            if (Work_Identifier.equals("Fork")) {
            	active_db_connection.db_calls.saveForkEstimate(t_work_order.work_order_id,
                        labor_cost, (String)labor_discount_box.getSelectedItem(),
                        fluid_cost, (String)fluid_discount_box.getSelectedItem(),
                        springs_cost, (String)spring_discount_box.getSelectedItem(),
                        parts_cost, (String)parts_discount_box.getSelectedItem(),
                        coatings_cost, (String)coatings_discount_box.getSelectedItem(),
                        other_cost, (String)other_discount_box.getSelectedItem(),
                        Need_Springs, Double.valueOf(rate));
            }
            if (Work_Identifier.equals("Shock")) {
            	active_db_connection.db_calls.saveShockEstimate(t_work_order.work_order_id,
                        labor_cost, (String)labor_discount_box.getSelectedItem(),
                        fluid_cost, (String)fluid_discount_box.getSelectedItem(),
                        springs_cost, (String)spring_discount_box.getSelectedItem(),
                        parts_cost, (String)parts_discount_box.getSelectedItem(),
                        coatings_cost, (String)coatings_discount_box.getSelectedItem(),
                        other_cost, (String)other_discount_box.getSelectedItem(),
                        Need_Springs, Double.valueOf(rate));
            }
        }

    }
    
    private Integer stripPercentage(String discount_rate) {
        Integer result=0;
        
        if (discount_rate != null) {
            String trimmed_discount_rate=discount_rate.trim();
            if (trimmed_discount_rate.length()>0) {
                String digits_only=trimmed_discount_rate.substring(0,trimmed_discount_rate.indexOf("%"));
                try {
                    result=Integer.parseInt(digits_only);
                }catch (NumberFormatException exc) {
                    System.out.println("Discount percentage error.");
                }
            }
        }
        return result;
    }
    
    
    /** Listens to the check boxes. */
    public void itemStateChanged(ItemEvent e) {
        Object source = e.getItemSelectable();
        if ((source==yes_need_spring)&&(e.getStateChange()==1)) {
            Need_Springs=1;
            no_need_spring.setSelected(false);
            yes_need_spring.setSelected(true);
            enableTextField(spring_rate_field);
        }
        if ((source==no_need_spring)&&(e.getStateChange()==1)) {
            Need_Springs=0;
            no_need_spring.setSelected(true);
            yes_need_spring.setSelected(false);
            disableTextField(spring_rate_field);
        }
    }
  
    private Double textToDouble(JTextField tf) {
        Double result;
        
        if (tf.getText().equals("")) {
            result=new Double("0");
        }else {
            try {
                result=new Double(tf.getText());
            }catch (NumberFormatException num_except) {
                //invalid format so just zero out this value
                result=new Double("0");
            }
        }
        return result;
    }
    
    public void actionPerformed(ActionEvent e) {
        String cmd=e.getActionCommand();
        if (cmd.equals("discount")) {
        	calculateSubTotal();
        }
    }//end method actionPerformed

    private void calculateSubTotal(){
        labor_discount=stripPercentage((String)labor_discount_box.getSelectedItem());
        fluid_discount=stripPercentage((String)fluid_discount_box.getSelectedItem());
        spring_discount=stripPercentage((String)spring_discount_box.getSelectedItem());
        parts_discount=stripPercentage((String)parts_discount_box.getSelectedItem());
        coatings_discount=stripPercentage((String)coatings_discount_box.getSelectedItem());
        other_discount=stripPercentage((String)other_discount_box.getSelectedItem());
        
        labor_discount_percentage=new Double(1.0-labor_discount/100.0);
        fluid_discount_percentage=new Double(1.0-fluid_discount/100.0);
        spring_discount_percentage=new Double(1.0-spring_discount/100.0);
        parts_discount_percentage=new Double(1.0-parts_discount/100.0);
        coatings_discount_percentage=new Double(1.0-coatings_discount/100.0);
        other_discount_percentage=new Double(1.0-other_discount/100.0);

        subtotal=(textToDouble(labor_area)*labor_discount_percentage)+
                (textToDouble(fluid_area)*fluid_discount_percentage)+
                (textToDouble(spring_area)*spring_discount_percentage)+
                (textToDouble(parts_area)*parts_discount_percentage)+
                (textToDouble(coatings_area)*coatings_discount_percentage)+
                (textToDouble(other_area)*other_discount_percentage);
        
        local_ghost_box.setSelectedIndex(0);//this is just to trip the event handler Work_Order_Total_Estimate
    }
    
    private Boolean checkDoubleValue(JTextField tf){
		//This method checks the value of a given JTextField to see if it is a valid Double
		
		String label;
		Integer limit;
		if ((tf.getName()!=null)&&tf.getName().contains("spring rate")){
			label=UnitFormatting.rate_measure;
			limit=UnitFormatting.rate_limit;
		}
		else{
			label="";
			limit=UnitFormatting.estimate_limit;
		}

		String strvalue=tf.getText();
		//Handle the case of blank entries
		if (strvalue.equals("")){
			tf.setBackground(Color.white);
			return true;
		}

		try {
			String valid_result=UnitFormatting.genDoubleValueMoney(strvalue,
					                           label,limit);
			tf.setText(valid_result+label);
			tf.setBackground(Color.white);
			calculateSubTotal();
		} catch (Exception e) {
			//it was a bad value
			tf.setBackground(Color.red);
			return false;
		}	
		return true;
	}

    public void focusGained(FocusEvent arg0) {
		
	}

	public void focusLost(FocusEvent e) {
        //This processes the JTextFields which hold dollar information
        //If the user values are not valid decimals, the background of the JTextField
        //is turned red; when it becomes valid, it goes back to white; this is processed
        //every time the mouse moves
		JTextField source=(JTextField)e.getComponent();
        
        //only check the data if the TextField is enabled
        if (source.isEnabled()) {
            if (checkDoubleValue(source)){
            	Costs_OK=true;
            }
            else{ 
            	Costs_OK=false;
            }
            source.repaint();
        }		
	}

	public void keyPressed(KeyEvent ke) {
		
	}

	public void keyReleased(KeyEvent ke) {
		if (ke.getKeyCode()==10){
			//if the user hits the return key move
			JTextField source=(JTextField)ke.getComponent();
			checkDoubleValue(source);
		}
	}

	public void keyTyped(KeyEvent ke) {
		
	}
	
}//end class Estimate_Panel
