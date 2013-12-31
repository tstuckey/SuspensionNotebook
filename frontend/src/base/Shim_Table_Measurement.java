package base;

import javax.swing.JComboBox;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.TableColumnModel;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import javax.swing.JPopupMenu;
import java.awt.Dimension;
import javax.swing.BorderFactory;
import javax.swing.JLabel;

import utilities.MyColor_CellRenderer;
import utilities.MyJTable;
import utilities.TableDescriptor;
import utilities.UnitFormatting;

import db_info.DB_Connection;

import java.awt.Color;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.util.Vector;
import java.sql.*;

public class Shim_Table_Measurement implements ActionListener,
		TableModelListener, FocusListener, KeyListener, MouseListener {
	JPanel child_panel;
	JPanel button_panel;
	GridBagConstraints class_c;

	MyJTable table;
	DefaultTableModel model;

	JTextField col_length_field;// for the length of the collar
	JTextField piston_tower_field;// for the rebound piston tower 
	JTextField spring_cup_field;//for the spring cup

	JTextField float_calculation_field;
	JPopupMenu popup;

	String stack_type;
	String reference_table;
	String reference_spec;
	Long spec_id;

	Active_Work_Order current_work_order;
	Active_Setting current_setting;
	
	Boolean outside_table_valid;
	Boolean table_valid;
	DB_Connection active_db_connection;
	public Shim_Table_Measurement(Active_Work_Order this_work_order,
			JPanel parent_panel, String t_stack_type,
			GridBagConstraints parent_c, DB_Connection active_db_connection) {
		stack_type = t_stack_type;
		current_work_order=this_work_order;
		current_setting = this_work_order.this_setting;
		this.active_db_connection=active_db_connection;

		initializeClassVariables();

		JScrollPane scrollPane = new JScrollPane(table);
		class_c.ipadx=250;
		class_c.ipady = 160; // this makes sure there is plenty of space for the table
		child_panel.add(scrollPane, class_c);
		disableComponents();
		checkTableValues();
		
		parent_panel.add(child_panel, parent_c);
	}

	public void initializeClassVariables() {
		child_panel = initializeJPanel(stack_type);
		button_panel = initializeJPanel("");

		class_c = new GridBagConstraints();
		class_c.anchor=GridBagConstraints.NORTHWEST;
		
		popup = new JPopupMenu();
		
		table = new MyJTable();
		model = (DefaultTableModel)table.getModel();
		table.setAttributes(table);
		table.setPreferredScrollableViewportSize(new Dimension(0,0));
		
		col_length_field = initializeJTextField(7);// for the width of the collar
		piston_tower_field = initializeJTextField(7);// for the depth of the collar
		spring_cup_field= initializeJTextField(7);
		float_calculation_field = initializeJTextField(7);
		
		outside_table_valid=true;
		table_valid=true;

		setReferenceTable(stack_type);

		setUpColHeight();
		setUpRebPistonTower();
		setUpSpringCup();
		setupFloatField();
		child_panel.add(button_panel, class_c);

		initializeCols(table, model);
		initializeRows(model);

		setUpTablePopup();
	}

	private JTextField initializeJTextField(int cols){
		JTextField tf=new JTextField(cols);
		tf.setDisabledTextColor(Color.black);
		tf.setBorder( BorderFactory.createLineBorder(Color.white));
		return tf;
	}	
	
	public JPanel initializeJPanel(String title) {
		JPanel t_panel = new JPanel();
		t_panel.setBorder(BorderFactory.createCompoundBorder(BorderFactory
				.createTitledBorder(title), BorderFactory.createEmptyBorder(0,
				0, 0, 0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}

	public void setReferenceTable(String stack_type) {
		// This method sets up what the reference table will be for this
		// instance of the
		// Settings_Table_Measurement object
		if (stack_type.equals("Fork BCV")) {
			reference_table = "fork_bcv_stack";
			reference_spec = "fork_spec";
			spec_id = current_setting.fork_spec_id;
		}
	}

	public void setUpColHeight() {
		class_c.insets = new Insets(0, 5, 0, 5);
		button_panel.add(new JLabel("Collar Length"), class_c);

		class_c.insets = new Insets(0, 0, 0, 5);
		button_panel.add(col_length_field, class_c);

		class_c.insets = new Insets(0, 0, 0, 0);
	}// end setUp_Col_Height

	public void setUpRebPistonTower() {
		class_c.insets = new Insets(0, 5, 0, 5);
		button_panel.add(new JLabel("Piston Tower"), class_c);

		class_c.insets = new Insets(0, 0, 0, 5);
		class_c.gridwidth=GridBagConstraints.REMAINDER;//to move to the next row
		button_panel.add(piston_tower_field, class_c);
		class_c.gridwidth=1;
		class_c.insets = new Insets(0, 0, 0, 0);
	}// end setUp_Reb_Piston_Tower

	public void setUpSpringCup() {
		class_c.insets = new Insets(0, 5, 0, 5);
		button_panel.add(new JLabel("Spring Cup"), class_c);

		class_c.insets = new Insets(0, 0, 0, 5);
		button_panel.add(spring_cup_field, class_c);

		class_c.insets = new Insets(0, 0, 0, 0);
	}// end setUp_Spring_Cup

	public void setupFloatField() {
		float_calculation_field.setBorder(BorderFactory
				.createLineBorder(Color.white));
		float_calculation_field.setDisabledTextColor(Color.black);
		class_c.insets = new Insets(0, 5, 0, 5);
		button_panel.add(new JLabel("Float"), class_c);

		class_c.gridwidth = GridBagConstraints.REMAINDER;
		class_c.insets = new Insets(0, 0, 0, 5);
		button_panel.add(float_calculation_field, class_c);

		class_c.insets = new Insets(0, 0, 0, 0);
		clearFloatField();
	}

	private void clearFloatField() {
		float_calculation_field.setText("0");
	}

	public void initializeCols(JTable table, DefaultTableModel model) {
		model.addColumn("OD");
		model.addColumn("Thickness");
		model.addColumn("Qty");
		model.addColumn("Width");

		TableColumn col_OD = table.getColumnModel().getColumn(0);
		TableColumn col_Thickness = table.getColumnModel().getColumn(1);
		TableColumn col_Qty = table.getColumnModel().getColumn(2);
		TableColumn col_Width = table.getColumnModel().getColumn(3);
		
		configureColumn(col_OD,"Enter Shim Outer Diameter");
		configureColumn(col_Thickness,"Enter Shim Thickness");
		configureColumn(col_Qty,"Enter Shim Quantity");
		
		//col_OD.sizeWidthToFit();
		//col_Thickness.sizeWidthToFit();
		//col_Qty.sizeWidthToFit();
		//col_Width.sizeWidthToFit();
		col_OD.setPreferredWidth(150);
		col_Thickness.setPreferredWidth(150);
		col_Qty.setPreferredWidth(50);
		col_Width.setPreferredWidth(150);
	}// end methd setUp_PullDown_Cols


	public void configureColumn(TableColumn col, String tip) {
		DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();
		renderer.setToolTipText(tip);
		col.setCellRenderer(renderer);
	}//end method Configure_Column

	private void bringRowsToMinimum(DefaultTableModel model) {
		// This method makes sure there are at least 10 rows in each table
		Vector<String> data;
		int num_blank_rows = 10 - model.getRowCount();
		int num_cols = model.getColumnCount();
		for (int row = 0; row < num_blank_rows; row++) {
			data = new Vector<String>();
			for (int col = 0; col < num_cols; col++) {
				data.add("");
			}
			model.addRow(data);
		}
	}

	private void initializeRows(DefaultTableModel model) {
		Vector<String> data;
		ResultSet rs = null;

		if (stack_type.equals("Fork BCV")) {
			rs = active_db_connection.db_calls.getForkBCVShims(current_setting.fork_spec_id);
		}

		try {
		        //Integer the_collar_pos=null;//for the collar position
			if (rs.first()) {
				Integer incremental_pos = 0;
				Integer pos;
				col_length_field.setText(UnitFormatting.replaceNulls( rs.getString("col_width"),
														UnitFormatting.width_measure,
														UnitFormatting.width_limit,"Double"));
				piston_tower_field.setText(UnitFormatting.replaceNulls( rs.getString("rebound_piston_tower"),
												          UnitFormatting.width_measure,
												          UnitFormatting.width_limit,"Double"));
				spring_cup_field.setText(UnitFormatting.replaceNulls( rs.getString("spring_cup"),
														UnitFormatting.width_measure,
														UnitFormatting.width_limit,"Double"));
				do {
					pos = rs.getInt("pos");// the shim position
					while (incremental_pos < pos) {
						// Add a blank row until we have a row with some
						// information in it
						data = new Vector<String>();
						data.add(""); // the shim outer diameter
						data.add(""); // the shim thickness
						data.add(""); // the shim qty
						data.add(""); // the shim width
						model.addRow(data);
						incremental_pos++;
					}

					// Add a row with some information in it
					data = new Vector<String>();
					String qty_result = UnitFormatting.replaceNulls( rs.getString("qty")); // the shim qty

					if(qty_result.equals("99")){
						data.add("Collar"); // the shim outer diameter
						data.add("Collar"); // the shim thickness
						data.add("Collar"); // the shim qty
						data.add(""); // the shim width
					}else{
						//get the flag to see if this OD is a Delta shim
						//we don't need to support delta shims in the BCV right now
						//but the db will already support and this is to match the other
						//shim specs
						//int OD_is_DELTA=rs.getInt("OD_is_DELTA");
						
						data.add(UnitFormatting.replaceNulls(rs.getString("OD"),
											    UnitFormatting.width_measure,
											    UnitFormatting.width_limit,"Double")); // the shim outer diameter
						data.add(UnitFormatting.replaceNulls(rs.getString("Thickness"),
												UnitFormatting.width_measure,
												UnitFormatting.width_limit,"Double")); // the shim thickness
						data.add(qty_result); // the shim qty
						data.add(""); // the shim width
					}
				        model.addRow(data);
					incremental_pos++;
				} while (rs.next());
			}
			bringRowsToMinimum(model);

		} catch (Exception e) {
			if (e.toString().contains("SQLException"))
			System.err.println("Settings_Table_Measurement 1: Problem retrieving data.");
		}
	}

	public void updateTableCalculations() {
		//if the form is invalid, don't try to update any calculations
		if (!(table_valid)||
			!(outside_table_valid)){
			return;
		}	
		model.removeTableModelListener(this);
		
		int num_rows = table.getRowCount();
		Double working_shim_height = new Double("0");
		Double non_working_shim_height = new Double("0");
		
		
		String location="over_collar";//we start out above the collar
		for (int pos = 0; pos < num_rows; pos++) {
			String thickness_string = UnitFormatting.stripUnitsForCalculation((String) table.getValueAt(pos, 1));
			String qty_string = UnitFormatting.stripUnitsForCalculation((String) table.getValueAt(pos, 2));

			// if the qty is labeled "Collar"
			// flip the switch so we are now under the collar
			if (thickness_string.equals("Collar")||qty_string.equals("Collar")){
				location="under_collar";
				continue;//go to the next row
			}

			if (thickness_string.equals(""))
				thickness_string = "0";
			if (qty_string.equals(""))
				qty_string = "0";
			
			Double thickness_measure = new Double(thickness_string);
			Double qty_measure = new Double(qty_string);
			
			// if the thickness or the qty are non-zero and we are over the collar
			if ((thickness_measure > 0) || (qty_measure > 0)) {
				String row_width = UnitFormatting.formatToThreePlaces(thickness_measure * qty_measure);
				if (location.equals("over_collar")){
				working_shim_height = working_shim_height + (thickness_measure * qty_measure);
				}
				if (location.equals("under_collar")){
					non_working_shim_height = non_working_shim_height + (thickness_measure * qty_measure);					
				}
				table.setValueAt(row_width+UnitFormatting.width_measure, pos, 3);
				}
		}// end for statement
		Double collar_length;
		Double piston_tower_depth;
		Double spring_cup_height;

		String string_col_length_id_selection = UnitFormatting.stripUnitsForCalculation((String)col_length_field.getText());
		String string_piston_tower_id_selection = UnitFormatting.stripUnitsForCalculation((String)piston_tower_field.getText());
		String string_spring_cup_id_selection = UnitFormatting.stripUnitsForCalculation((String)spring_cup_field.getText());

		if (string_col_length_id_selection.equals(""))
			collar_length = new Double("0");
		else
			collar_length = new Double(string_col_length_id_selection);

		if (string_piston_tower_id_selection.equals(""))
			piston_tower_depth= new Double("0");
		else
			piston_tower_depth= new Double(string_piston_tower_id_selection);

		if (string_spring_cup_id_selection.equals(""))
			spring_cup_height= new Double("0");
		else
			spring_cup_height= new Double(string_spring_cup_id_selection);

		//System.out.println("working shim height "+working_shim_height);
		//System.out.println("non working shim height "+non_working_shim_height);
		String overall_height="0";
		if (current_work_order.selected_fork_brand.equals("Showa")){
			overall_height = UnitFormatting.formatToThreePlaces((collar_length) - piston_tower_depth);	
		}else{
			//add the non_working_shim_height to non_Showa BCV calculations
			overall_height = UnitFormatting.formatToThreePlaces((collar_length+non_working_shim_height) - piston_tower_depth - spring_cup_height);
		}
		
		String stack_float=UnitFormatting.formatToThreePlaces(new Double(overall_height)-working_shim_height);
		
		float_calculation_field.setText(stack_float+UnitFormatting.width_measure);

		model.addTableModelListener(this);
	}

	private void setSelectedRowAsCollar(int row_selected) {
		int num_rows = table.getRowCount();
		int num_cols = table.getColumnCount();
		String table_value = null;
		//
		// removing the tableChanged listener while we update the table
		// prevents an endless loop
		model.removeTableModelListener(this);

		// User may have signified another row as the collar earlier
		// if so blank out these old table values
		for (int row = 0; row < num_rows; row++) {
			for (int col = 0; col < num_cols; col++) {
				table_value = (String) table.getValueAt(row, col);
				if (table_value.equals("Collar"))
					table.setValueAt("", row, col);
			}// end for cols
		}// end for rows

		for (int col = 0; col < num_cols; col++) {
			table.setValueAt("Collar", row_selected, col);
		}
		adjustTableColor();
		model.addTableModelListener(this);// table is updated; so add the listener back in
	}

	private void unSetSelectedRowAsCollar() {
		// unsets the collar from the table
		int num_rows = table.getRowCount();
		int num_cols = table.getColumnCount();

		String table_value = null;
		// removing the tableChanged listener while we update the table
		// prevents an endless loop
		model.removeTableModelListener(this);

		// User may have signified another row as the collar earlier
		// if so blank out these old table values
		for (int row = 0; row < num_rows; row++) {
			for (int col = 0; col < num_cols; col++) {
				table_value = (String) table.getValueAt(row, col);
				if (table_value.equals("Collar"))
					table.setValueAt("", row, col);
			}// end for cols
		}// end for rows

		adjustTableColor();
		model.addTableModelListener(this);// table is updated; so add the listener back in
	}
	
	public void adjustTableColor(){
		int num_rows = table.getRowCount();
		int num_cols = table.getColumnCount();
		TableDescriptor table_info=new TableDescriptor(table);
		model.removeTableModelListener(this);

		for (int row=0; row<num_rows; row++){
			for (int col=0; col<num_cols; col++){
				String table_value=((String)table.getValueAt(row,col)).trim();
				if (table_value.equals("Collar")){
					table_info.color_matrix[row][col]=Color.yellow;	
				}else{
					table_info.color_matrix[row][col]=null;
				}
			}//end for col loop
		}//end for row loop
		//Invoke the cell renderer for each column in the table
		TableColumnModel colModel=table.getColumnModel();
		TableColumn t_column=null;
		for (int col=0; col<num_cols; col++){
			t_column = colModel.getColumn(col);
			t_column.setCellRenderer(new MyColor_CellRenderer(table_info));
		}
		table.repaint();
		model.addTableModelListener(this);// table is updated; so add the listener back in
	}	

	public void setUpTablePopup() {
		JMenuItem set_as_collar = new JMenuItem("Set Row as Collar");
		JMenuItem unset_as_collar = new JMenuItem("UnSet Row as Collar");

		JMenuItem add_row = new JMenuItem("Add Row");
		JMenuItem insert_row = new JMenuItem("Insert Row");
		JMenuItem delete_row = new JMenuItem("Delete Row");

		set_as_collar.setActionCommand("set_as_collar");
		unset_as_collar.setActionCommand("unset_as_collar");
		add_row.setActionCommand("add_row");
		insert_row.setActionCommand("insert_row");
		delete_row.setActionCommand("delete_row");

		set_as_collar.addActionListener(this);
		unset_as_collar.addActionListener(this);
		add_row.addActionListener(this);
		insert_row.addActionListener(this);
		delete_row.addActionListener(this);

		popup.add(set_as_collar);
		popup.add(unset_as_collar);
		popup.add(add_row);
		popup.add(insert_row);
		popup.add(delete_row);
	}// end setUp_Table_Popup

	public void actionPerformed(ActionEvent ae) {
		if (ae.getActionCommand().equals("set_as_collar")) {
			setSelectedRowAsCollar(table.getSelectedRow());
			updateTableCalculations();
		}
		if (ae.getActionCommand().equals("unset_as_collar")) {
			unSetSelectedRowAsCollar();
			updateTableCalculations();
		}
		if (ae.getActionCommand().equals("add_row")) {
			// add a blank row into the table
		        Vector<String> data = new Vector<String>();
			for(int count=0;count<table.getColumnCount();count++){
			   data.add("");	
			}
			model.addRow(data);
			adjustTableColor();
		}
		if (ae.getActionCommand().equals("insert_row")) {
			// insert a blank row into the table
		        Vector<String> data = new Vector<String>();
			for(int count=0;count<table.getColumnCount();count++){
			   data.add("");	
			}
			model.insertRow(table.getSelectedRow(), data);
			adjustTableColor();
		}
		if (ae.getActionCommand().equals("delete_row")) {
			// delete the active row from the table
			// be sure to pop up a dialog box for confirmation
			model.removeRow(table.getSelectedRow());
			adjustTableColor();
		}
	}// end method actionPerformed

	public void putBlankFirstPosition(JComboBox c_box,
			Vector<Integer> ref_vec) {
		// Add a blank space at the top of the selections,
		// and add a corresponding zero to the reference vector

		c_box.addItem("");
		ref_vec.insertElementAt(0, 0);
	}

	public void disableComponents() {
		col_length_field.removeKeyListener(this);
		piston_tower_field.removeKeyListener(this); 
		spring_cup_field.removeKeyListener(this);

		col_length_field.removeFocusListener(this);
		piston_tower_field.removeFocusListener(this); 
		spring_cup_field.removeFocusListener(this);

		disableTextField(col_length_field);
		disableTextField(piston_tower_field);
		disableTextField(spring_cup_field);

		table.removeMouseListener(this);
		table.removeFocusListener(this);
		table.setEnabled(false);		
		float_calculation_field.setEnabled(false);
		float_calculation_field.setBackground(Color.lightGray);
	}

	public void enableComponents() {
		col_length_field.addKeyListener(this);
		piston_tower_field.addKeyListener(this); 
		spring_cup_field.addKeyListener(this);

		col_length_field.addFocusListener(this);
		piston_tower_field.addFocusListener(this); 
		spring_cup_field.addFocusListener(this);

		enableTextField(col_length_field);
		enableTextField(piston_tower_field);
		enableTextField(spring_cup_field);

		table.addMouseListener(this);
		table.addFocusListener(this);
		table.setEnabled(true);
	}
    
	public void enableTextField(JTextField tf) {
        tf.setEnabled(true);
        tf.setBackground(Color.white);
    }
    
    public void disableTextField(JTextField tf) {
    	tf.setEnabled(false);
    	tf.setBackground(Color.lightGray);
    }
	private Long prepareSpecs() {
		ResultSet rs = null;
		Long t_spec_id = new Long(0);

		/*
		 * Remove the existing shims from this spec to make room for the new
		 * ones based on the setting
		 */
		rs = active_db_connection.db_calls.removeShimsfromSpec(current_setting.setting_id,
				                     reference_table, reference_spec);

		try {
			if (rs.first()) {
				t_spec_id = rs.getLong("spec_id"); // the new spec_id
			}
		} catch (SQLException e) {
			System.err.println("Settings_Table_Measurement 2: Problem retrieving data.");
			e.printStackTrace();
		}
		return (t_spec_id);
	}
	
	public Boolean checkDoubleValue(JTextField tf){
		//This method checks the value of a given JTextField to see if it is a valid Double
		String strvalue=tf.getText();
		//strip out the units measure if it is present
		if (strvalue.contains(UnitFormatting.width_measure)){
			strvalue=strvalue.substring(0,strvalue.indexOf(UnitFormatting.width_measure));
		}
		
		//Handle the case of blank entries
		if (strvalue.equals("")){
			tf.setBackground(Color.white);
			return true;
		}
		
		try {
			String valid_result=UnitFormatting.genDoubleValue(strvalue,
											   UnitFormatting.width_measure,
											   UnitFormatting.width_limit);
			tf.setText(valid_result+UnitFormatting.width_measure);
			tf.setBackground(Color.white);
		} catch (Exception e) {
			//it was a bad value
			tf.setBackground(Color.red);
			return false;
		}
		return true;
	}
	public Boolean checkTableValues(){
		//This method checks the double values on the jtable
		
		TableDescriptor table_info=new TableDescriptor(table);
		
		model.removeTableModelListener(this);//remove the change listener while we update the model
		Boolean local_table_valid=true;
		for (int row=0; row<table.getRowCount(); row++){
			for (int col=0; col<table.getColumnCount(); col++){
			String strvalue=(String)table.getValueAt(row,col);

			if (strvalue.equals("")){
				table_info.color_matrix[row][col]=null;
				continue;
			}
			if (strvalue.equals("Collar")){
				table_info.color_matrix[row][col]=Color.yellow;
				continue;
			}
			
			try {
				if (col==0 || col==1){
					//double values in the first two table columns
					String valid_result=UnitFormatting.genDoubleValue(strvalue,
													   UnitFormatting.width_measure,
													   UnitFormatting.width_limit);
					model.setValueAt(valid_result+UnitFormatting.width_measure, row, col);	
					//it was a good value
					table_info.color_matrix[row][col]=null;
				}
				if (col==2){
					//integer values in the last table columns
					Integer valid_result=UnitFormatting.genIntegerValue(strvalue,"",
										 UnitFormatting.qty_limit);
					model.setValueAt(valid_result+"", row, col);	
					//it was a good value
					table_info.color_matrix[row][col]=null;
				}
				if (col==3){
					//Product of shim width and the qty
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
	
	public void saveInfo(Active_Work_Order t_work_order) {
		if ((!outside_table_valid)||(!table_valid)){
			JOptionPane.showMessageDialog(null,
					"There is one or more data format errors in\n "+this.stack_type+" table for the data to be saved.",
					"Warning",	JOptionPane.WARNING_MESSAGE,null);
			return;
		}
		
		// This method takes the data out of the table and puts it in the database
		The_Desktop.setCursorWait(true);
		
		// get the spec_id for this particular setting
		spec_id = prepareSpecs();

		int num_rows = table.getRowCount();
		String this_col_length;
		String this_piston_tower;
		String this_spring_cup;
		
		try {
			this_col_length = UnitFormatting.genDoubleValue(col_length_field.getText(),
							                 UnitFormatting.width_measure,
							                 UnitFormatting.width_limit);
			this_piston_tower = UnitFormatting.genDoubleValue(piston_tower_field.getText(),
											   UnitFormatting.width_measure,
											   UnitFormatting.width_limit);
			this_spring_cup = UnitFormatting.genDoubleValue(spring_cup_field.getText(),
							  				 UnitFormatting.width_measure,
							  				 UnitFormatting.width_limit);
		} catch (Exception e) {
			// shouldn't ever get here, settings should already be validated
			//before this
			this_col_length = new Double("0").toString();
			this_piston_tower = new Double("0").toString();
			this_spring_cup = new Double("0").toString();
		}		
		
        int saved_shim_flag=0;//a flag to indicate we made at least one save 
			for (int row = 0; row < num_rows; row++) {
			// if the value at in the first column for this row is "Collar",
			// make a call the the special number of 99 in place of Qty to
			// signify this and continue on the next row
				
			if (((String)table.getValueAt(row, 0)).equals("Collar")) {
				active_db_connection.db_calls.insertShimsIntoSpec(
						t_work_order.this_setting.setting_id, reference_table,
						reference_spec, spec_id, row,Double.valueOf("0"),Double.valueOf(this_col_length),
						Double.valueOf(this_piston_tower),Double.valueOf(this_spring_cup),
						0,Double.valueOf("0"),Double.valueOf("0"), 99);
		        saved_shim_flag=1;//at least one shim save, so set the flag
				continue;
			}

			String this_OD;
			String this_thickness;
			Integer this_qty;
			try {
				this_OD = UnitFormatting.genDoubleValue((String)table.getValueAt(row, 0),
						  				 UnitFormatting.width_measure,
						  				 UnitFormatting.width_limit);
				this_thickness = UnitFormatting.genDoubleValue((String)table.getValueAt(row, 1),
								 				UnitFormatting.width_measure,
								 				UnitFormatting.width_limit);
				this_qty = UnitFormatting.genIntegerValue((String)table.getValueAt(row, 2),"",
						   UnitFormatting.qty_limit);
			} catch (Exception e) {
				// shouldn't ever get here, settings should already be validated
				//before this
				this_OD = new Double("0").toString();
				this_thickness = new Double("0").toString();
				this_qty = new Integer("0");
			}

			// if any of the values are non-zero save the entry
			if ((Double.valueOf(this_OD)>0) || 
				(Double.valueOf(this_thickness)>0) || 
				(this_qty>0)) {
				active_db_connection.db_calls.insertShimsIntoSpec(
						t_work_order.this_setting.setting_id, reference_table,
						reference_spec, spec_id, row, Double.valueOf("0"),Double.valueOf(this_col_length),
						Double.valueOf(this_piston_tower),Double.valueOf(this_spring_cup),
						0,Double.valueOf(this_OD), Double.valueOf(this_thickness), this_qty);
		        saved_shim_flag=1;//at least one shim save, so set the flag
			}
		}
		//if there weren't any shims saved, notify the user these header values cannot 
		//be saved unless at least one shim attribute is specified as well
		if ((saved_shim_flag==0) &&
				((Double.valueOf(this_col_length)>0)||
				 (Double.valueOf(this_piston_tower)>0)||
				 (Double.valueOf(this_spring_cup)>0))) {
		     JOptionPane.showMessageDialog(null,
		     "At least one attribute must be set in the\n "+this.stack_type+" table for the data to be saved.",
		     "Warning",
		    JOptionPane.WARNING_MESSAGE,null);
		}
		The_Desktop.setCursorWait(false);	
	}// end method Save_Info

	public void tableChanged(TableModelEvent e) {
		table_valid=checkTableValues();
		updateTableCalculations();
	}
	
	public void focusGained(FocusEvent fe) {
		if (fe.getComponent().toString().contains("JTable")) Active_Work_GUIs.next_table=(JTable)fe.getComponent();
		//if the user has come from something off the desktopPane, don't do anything, just return
		if (fe.getOppositeComponent()==null)return;

		String old_focused_component = fe.getOppositeComponent().toString();
		if(old_focused_component.contains("RootPane")){
			//if we are coming off of the JPopupMenu and the previous and next tables don't match,
			//remove the previous table's selection
			if ( Active_Work_GUIs.prev_table!=Active_Work_GUIs.next_table){
					if (Active_Work_GUIs.prev_table!=null)Active_Work_GUIs.prev_table.clearSelection();
				}
			return;
		}
	}
	
	public void focusLost(FocusEvent fe) {
		if (fe.getComponent().toString().contains("JTable")) Active_Work_GUIs.prev_table=(JTable)fe.getComponent();
		//if the user has selected something off the desktopPane, don't do anything, just return
		if (fe.getOppositeComponent()==null)return;
		
		String newly_focused_component = fe.getOppositeComponent().toString();
		if(newly_focused_component.contains("RootPane")){
			//if we are just invoking the JPopupMenu on a table, don't do anything
			return;
		}
		table.clearSelection();
		
		Boolean res1=checkDoubleValue(col_length_field);
		Boolean res2=checkDoubleValue(piston_tower_field); 
		Boolean res3=checkDoubleValue(spring_cup_field);
		//if anything is false the whole area is false
		outside_table_valid=res1&&res2&&res3;
		updateTableCalculations();
	}

	public void keyPressed(KeyEvent ke) {
	}

	public void keyReleased(KeyEvent ke) {
		if (ke.getKeyCode()==10){
			//if the user hits the return key so move focus to the table
			table.requestFocus();
			table.changeSelection(0, 0, false, false);
		}
	}

	public void keyTyped(KeyEvent ke) {}

	public void mouseClicked(MouseEvent e) {}

	public void mouseEntered(MouseEvent e){}

	public void mouseExited(MouseEvent e) {}

	public void mousePressed(MouseEvent e) {
		if (e.getButton()>2) {
			JTable source = (JTable)e.getSource();
			int row = source.rowAtPoint(e.getPoint());
			int column = source.columnAtPoint(e.getPoint());
			//make the row where the popup was invoked the active row
			popup.show(e.getComponent(),e.getX(), e.getY());
			source.requestFocus();
			source.changeSelection(row, column, false, false);
		}
	}

	public void mouseReleased(MouseEvent e) {}

}// end class Settings_Table_Measurement

