package base;

import javax.swing.JComboBox;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableColumn;
import javax.swing.table.TableColumnModel;
import java.awt.Dimension;
import javax.swing.*;

import utilities.MyColor_CellRenderer;
import utilities.MyJTable;
import utilities.TableDescriptor;
import utilities.UnitFormatting;

import db_info.DB_Connection;

import java.awt.Color;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.util.Vector;
import java.util.zip.DataFormatException;
import java.sql.*;

public class Fork_Arrival_Table implements ActionListener, TableModelListener, KeyListener, FocusListener {
	JPanel arrival_panel;
	MyJTable table;
	DefaultTableModel model;
	GridBagConstraints class_c;
	JScrollPane scrollPane;
	
	JComboBox fork_leaking_box;
	
	Active_Setting current_setting;
	Integer arrival_fork_leaking_ref;
	Long arrival_fork_spec;
	Boolean table_valid;
	DB_Connection active_db_connection;
	public Fork_Arrival_Table(Active_Setting this_setting, JPanel parent_panel,
			String title,GridBagConstraints parent_c, DB_Connection active_db_connection) {
		current_setting=this_setting;
		this.active_db_connection=active_db_connection;
		initializeClassVariables(title, parent_panel);
		disableComponents();
		checkTableValues();

		SetupChangeListeners();
		parent_panel.add(arrival_panel, parent_c);
	}//end constructor

	public void initializeClassVariables(String title,JPanel parent_panel){
		arrival_fork_spec=null;
		getArrivalSpecs(current_setting);

		fork_leaking_box=new JComboBox();
		arrival_panel=initializeJPanel(title);
		
		class_c = new GridBagConstraints();
		class_c.anchor=GridBagConstraints.NORTHWEST;
		
		table = new MyJTable();
		table.setBackground(Color.cyan);
		model = (DefaultTableModel)table.getModel();
		table.setAttributes(table);
		
		setUpComponentConditions(arrival_panel,class_c);
		
		forkInitializeCols(table, model);//initialize the columns
		forkInitializeRows(arrival_fork_spec, model);
		table_valid=true;
		
		Update_Table_Calculations();
	}

	public JPanel initializeJPanel(String title) {
		JPanel t_panel = new JPanel();
		t_panel.setBorder(BorderFactory.createCompoundBorder(
				          BorderFactory.createTitledBorder(title), 
				          BorderFactory.createEmptyBorder(0,
						  0, 0, 0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}  

	public void getArrivalSpecs(Active_Setting current_setting) {
		//This method finds the arrival specs for a given setting
		ResultSet rs=null;

		rs=active_db_connection.db_calls.getArrivalSpecs(current_setting.setting_id);

		try {
			if (rs.first()) {
				arrival_fork_leaking_ref=rs.getInt("fork_leaking");//the binary for the fork leaking or not leaking
				arrival_fork_spec=rs.getLong("arrival_fork_spec"); //the fork spec
			}
		}catch (SQLException e) {
			System.err.println("Fork_Arrival_Table: Problem retrieving data.");
		}
	}

	public void setUpComponentConditions(JPanel parent_panel, GridBagConstraints c) {
		JPanel t_panel=initializeJPanel("");
		buildYesNoBox(fork_leaking_box,t_panel,"Fork Leaking?","fork_leaking_action",arrival_fork_leaking_ref);
		buildArrivalSettingsTablePanel(t_panel);
		parent_panel.add(t_panel,c);
	}

	private void buildYesNoBox(JComboBox cbox, JPanel t_panel, String label_name,
			String t_action,Integer initial_condition) {
		JPanel p_panel=initializeJPanel("");
		Vector<String> choices=new Vector<String>();
		choices.add("No");
		choices.add("Yes");
		for (int i=0;i<choices.size();i++) {
			cbox.addItem(choices.elementAt(i));
		}
		//if the initial_condition is 1 then make the box reference "yes"; otherwise "no"
		if ((initial_condition==null)||(initial_condition==0)) {
			cbox.setSelectedIndex(0);
		} else if (initial_condition==1) {
			cbox.setSelectedIndex(1);
		}
		cbox.setActionCommand(t_action);
		cbox.addActionListener(this);
		GridBagConstraints c = new GridBagConstraints();

		c.insets = new Insets(0,0,5,0);
		c.gridwidth=GridBagConstraints.RELATIVE;
		p_panel.add(new JLabel(label_name), c);
		c.insets = new Insets(0,0,0,0);
		c.gridwidth=GridBagConstraints.REMAINDER;
		p_panel.add(cbox,c);
		t_panel.add(p_panel,class_c);	
	}

	private void buildArrivalSettingsTablePanel(JPanel t_panel){
		JPanel p_panel=initializeJPanel("");
		GridBagConstraints c = new GridBagConstraints();
		c.weightx = 1.0;
				
		table.setPreferredScrollableViewportSize(new Dimension(500, 16));
		scrollPane= new JScrollPane(table);
		
		p_panel.add(scrollPane,c);
		p_panel.setBackground(Color.lightGray);	
		t_panel.add(p_panel,class_c);
	}	
	private void SetupChangeListeners(){
		model.addTableModelListener(this);
		
		table.addFocusListener(this);
		table.addKeyListener(this);
	}	
	
	public void putBlankFirstPosition(JComboBox c_box, Vector <Integer> ref_vec) {
		//Add a blank space at the top of the selections,
		//and add a corresponding zero to the reference vector

		c_box.addItem("");
		ref_vec.insertElementAt(0,0);
	}

	public void forkInitializeCols(JTable table, DefaultTableModel model) {
		model.addColumn("Rate");
		model.addColumn("Comp");
		model.addColumn("Reb");
		model.addColumn("Oil Vol");
		model.addColumn("Oil Ht");
		model.addColumn("Sprg Len");
		model.addColumn("Cham Len");
		model.addColumn("Preload");
		
		TableColumn col_rate=table.getColumnModel().getColumn(0);
		TableColumn col_comp=table.getColumnModel().getColumn(1);
		TableColumn col_reb=table.getColumnModel().getColumn(2);
		TableColumn col_oil_vol=table.getColumnModel().getColumn(3);
		TableColumn col_oil_height=table.getColumnModel().getColumn(4);
		TableColumn col_spring_length=table.getColumnModel().getColumn(5);
		TableColumn col_chamber_length=table.getColumnModel().getColumn(6);
		TableColumn col_preload=table.getColumnModel().getColumn(7);
		
		col_rate.setPreferredWidth(100);
		col_comp.sizeWidthToFit();
		col_reb.sizeWidthToFit();
		col_oil_vol.sizeWidthToFit();
		col_oil_height.sizeWidthToFit();
		col_spring_length.sizeWidthToFit();
		col_chamber_length.sizeWidthToFit();
		col_preload.sizeWidthToFit();
		
		configureColumn(col_rate,"Enter Spring Rate");
		configureColumn(col_comp,"Enter comp");
		configureColumn(col_reb,"Enter reb");
		configureColumn(col_oil_vol,"Enter oil vol");
		configureColumn(col_oil_height,"Enter oil height");
		configureColumn(col_spring_length,"Enter spring length");
		configureColumn(col_chamber_length,"Enter chamber length");
	}

	public void configureColumn(TableColumn col, String tip) {
		//Set up tool tips
		DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();
		renderer.setToolTipText(tip);
		col.setCellRenderer(renderer);

	}//end method Configure_Rate_Column


	private void bringRowsToMinimum(DefaultTableModel model) {
		//This method makes sure there are at least 10 rows in each table
		Vector<String> data;
		int num_blank_rows=1 - model.getRowCount();
		int num_cols=model.getColumnCount(); 
		for (int row=0;row<num_blank_rows;row++) {
			data=new Vector<String>();
			for(int col=0;col<num_cols;col++) {
				data.add("");
			}
			model.addRow(data);
		}

	}

	private void forkInitializeRows(Long arrival_fork_spec,DefaultTableModel model) {
		Vector<String> data;
		ResultSet rs=null;

		if (arrival_fork_spec==null)arrival_fork_spec=new Long(0);
		rs=active_db_connection.db_calls.getArrivalForkSpec(arrival_fork_spec);

		try {
			if (rs.first()) {
				data=new Vector<String>();

				data.add(UnitFormatting.replaceNulls(rs.getString("Rate"),
									    UnitFormatting.rate_measure,
									    UnitFormatting.rate_limit,"Double"));
				data.add(UnitFormatting.replaceNulls(rs.getString("Compression"),
													"",
													UnitFormatting.click_limit,"Integer"));
				data.add(UnitFormatting.replaceNulls(rs.getString("Rebound"),
						 							"",
						 							UnitFormatting.click_limit,"Integer"));
				data.add(UnitFormatting.replaceNulls(rs.getString("Oil_Vol"),
										UnitFormatting.vol_measure,
										UnitFormatting.vol_limit,"Integer"));
				data.add(UnitFormatting.replaceNulls(rs.getString("Oil_Height"),
										UnitFormatting.length_measure,
										UnitFormatting.length_limit,"Integer"));
				data.add(UnitFormatting.replaceNulls(rs.getString("Spring Length"),
										UnitFormatting.length_measure,
										UnitFormatting.length_limit,"Integer"));
				data.add(UnitFormatting.replaceNulls(rs.getString("Chamber Length"),
										UnitFormatting.length_measure,
										UnitFormatting.length_limit,"Integer"));
				data.add("");//for the calculated preload
				model.addRow(data);
			}
			bringRowsToMinimum(model);
		}
		catch (SQLException sql){
			System.err.println("Fork_Arrival_Table: Problem retrieving data.");
		}
		catch (DataFormatException e) {
			System.err.println("Fork_Arrival_Table:  Problem with format of initial data");
			e.printStackTrace();
		}		
	}

	public void disableComponents() {
		fork_leaking_box.setEnabled(false);
		table.setEnabled(false);
	}

	public void enableComponents() {
		fork_leaking_box.setEnabled(true);
		table.setEnabled(true);
	}

	private static Integer Get_Yes_No(String selection) {
		if (selection.equals("Yes")) {
			return 1;
		}else return 0;

	}

	public void saveInfo(Active_Work_Order t_work_order) {
		if ((!table_valid)){
			JOptionPane.showMessageDialog(null,
					"There is one or more data format errors in\n the Fork Arrival table for the data to be saved.",
					"Warning",JOptionPane.WARNING_MESSAGE,null);
			return;
		}
		//This method takes the data out of the table and puts it in the database
		/*Print out the debugging header*/
		Integer Leaking_id=Get_Yes_No((String)fork_leaking_box.getSelectedItem());

		int num_rows=table.getRowCount();//there should only be one row
		for (int pos=0; pos<num_rows; pos++) {
			String springs;
			Integer comp;
			Integer reb;
			Integer Oil_vol;
			Integer Oil_height;
			Integer spring_length;
			Integer chamber_length;
			
			try {
				springs = UnitFormatting.genDoubleValue((String)table.getValueAt(pos, 0),
										 UnitFormatting.rate_measure,
										 UnitFormatting.rate_limit);
				comp = UnitFormatting.genIntegerValue((String)table.getValueAt(pos, 1),"",
					   UnitFormatting.click_limit);
				reb = UnitFormatting.genIntegerValue((String)table.getValueAt(pos, 2),"",
					  UnitFormatting.click_limit);
				Oil_vol = UnitFormatting.genIntegerValue((String)table.getValueAt(pos, 3),
						  UnitFormatting.vol_measure,UnitFormatting.vol_limit);
				Oil_height = UnitFormatting.genIntegerValue((String)table.getValueAt(pos, 4),
							 UnitFormatting.length_measure,UnitFormatting.length_limit);
				spring_length = UnitFormatting.genIntegerValue((String)table.getValueAt(pos, 5),
								UnitFormatting.length_measure,UnitFormatting.length_limit);
				chamber_length = UnitFormatting.genIntegerValue((String)table.getValueAt(pos, 6),
								 UnitFormatting.length_measure,UnitFormatting.length_limit);
			} catch (Exception e) {
				//shouldn't ever get here, settings should already be validated
				//before this
				springs = new Double("0").toString(); 
				comp =new Integer("0");
				reb = new Integer("0");
				Oil_vol = new Integer("0");
				Oil_height = new Integer("0");
				spring_length = new Integer("0");
				chamber_length = new Integer("0");
			}
			active_db_connection.db_calls.saveForkArrivalSettings(t_work_order.this_setting.setting_id, Leaking_id, Double.valueOf(springs),
					comp,reb,Oil_vol, Oil_height,spring_length,chamber_length);
		}
	}
	private String stripUnitForCalculation(String whole_thing){
		if (whole_thing.contains(UnitFormatting.length_measure)){
		String numbers_only=null;
		//get the substring from the first position to the end minus the 3 characters for UnitFormatting.unit_measure
		numbers_only=whole_thing.substring(0, (whole_thing.length()-3 ));
		return numbers_only;
		}else return whole_thing;
	}
	
	public void Update_Table_Calculations() {
		//if the form is invalid, don't try to update any calculations
		if (!(table_valid)){
			return;
		}	
		
		Integer difference=0;

		String spring_length = stripUnitForCalculation((String) table.getValueAt(0,5));
		String chamber_length = stripUnitForCalculation((String) table.getValueAt(0,6));

		if (spring_length.equals(""))
			spring_length = "0";
		if (chamber_length.equals(""))
			chamber_length = "0";

		Integer spring_length_measure = new Integer(spring_length);
		Integer chamber_length_measure = new Integer(chamber_length);

		difference=spring_length_measure-chamber_length_measure;

		// removing the tableChanged listener while we update the table prevents an endless loop
		table.getModel().removeTableModelListener(this);
		table.setValueAt(difference.toString()+UnitFormatting.length_measure , 0,7);
		// table is updated; so add the listener back in
		table.getModel().addTableModelListener(this);
	}

	public void actionPerformed(ActionEvent e) {
	}//end method actionPerformed

	public Boolean checkTableValues(){
		//This method checks the double values on the jtable

		TableDescriptor table_info= new TableDescriptor(table);

		model.removeTableModelListener(this);//remove the change listener while we update the model
		Boolean local_table_valid=true;
		for (int row=0; row<table.getRowCount(); row++){
			for (int col=0; col<table.getColumnCount(); col++){
				String strvalue=(String)model.getValueAt(row,col);


				if (strvalue.equals("")){
					table_info.color_matrix[row][col]=null;
					continue;
				}

				try {
					if (col==0){
						//Rate Value
						String valid_result=UnitFormatting.genDoubleValue(strvalue,
											               UnitFormatting.rate_measure,
											               UnitFormatting.rate_limit);
						model.setValueAt(valid_result+UnitFormatting.rate_measure, row, col);	
						//it was a good value
						table_info.color_matrix[row][col]=null;
					}
					if (col==1){
						//Compression value
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue,"",
											 UnitFormatting.click_limit);
						model.setValueAt(valid_result+"", row, col);	
						//it was a good value
						table_info.color_matrix[row][col]=null;
					}				
					if (col==2){
						//Rebound value
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue,"",
									         UnitFormatting.click_limit);
						model.setValueAt(valid_result+"", row, col);	
						//it was a good value
						table_info.color_matrix[row][col]=null;
					}					
					if (col==3){
						//Oil Vol
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue,
											 UnitFormatting.vol_measure,
											 UnitFormatting.vol_limit);
						model.setValueAt(valid_result+UnitFormatting.vol_measure, row, col);	
						//it was a good value
						table_info.color_matrix[row][col]=null;
					}					
					if (col==4){
						//Oil Height
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue,
											 UnitFormatting.length_measure,
											 UnitFormatting.length_limit);
						model.setValueAt(valid_result+UnitFormatting.length_measure, row, col);	
						//it was a good value
						table_info.color_matrix[row][col]=null;
					}					
					if (col==5){
						//Spring Length
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue, 
											 UnitFormatting.length_measure,
											 UnitFormatting.length_limit);
						model.setValueAt(valid_result+UnitFormatting.length_measure, row, col);	
						//it was a good value
						table_info.color_matrix[row][col]=null;
					}					
					if (col==6){
						//Chamber Length
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue,
											 UnitFormatting.length_measure,
											 UnitFormatting.length_limit);
						model.setValueAt(valid_result+UnitFormatting.length_measure, row, col);
						//it was a good value
						table_info.color_matrix[row][col]=null;
					}					
					if (col==7){
						//Difference between the chamber length and the spring length
						//this is a calculated value so make it gray
						table_info.color_matrix[row][col]=Color.lightGray;
					}					
				

				} catch (Exception e) {
					//it was a bad value
					//so set the int in the difference matrix so the cell will be colored 
					table_info.color_matrix[row][col]=Color.red;
					local_table_valid=false;
				}	
			}//end for col
		}//end for row


		TableColumnModel colModel=table.getColumnModel();
		TableColumn t_column=null;
		for (int cols=0; cols<table.getColumnCount(); cols++){
			t_column = colModel.getColumn(cols);
			t_column.setCellRenderer(new MyColor_CellRenderer(table_info));
		}
				
		model.addTableModelListener(this);//add the change listener back in now that the changes are made
		table.repaint();
		return local_table_valid;
	}
	
	
	public void tableChanged(TableModelEvent e) {
		table_valid=checkTableValues();
		Update_Table_Calculations();
	}

	public void focusGained(FocusEvent fe) {
	}

	public void focusLost(FocusEvent fe) {
		if(fe.toString().contains("JTable"))
			table.clearSelection();
	}
	
	public void keyPressed(KeyEvent ke) {
		
	}

	public void keyReleased(KeyEvent ke) {
		if (ke.getKeyCode()==10){
			//if the user hits the return key move
			checkTableValues();
		}
	}

	public void keyTyped(KeyEvent ke) {
		
	}


}//end class Fork_Arrival_Panel

