package base;

import javax.swing.JComboBox;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import javax.swing.table.TableColumnModel;
import javax.swing.JPopupMenu;
import java.awt.Dimension;
import javax.swing.BorderFactory;
import javax.swing.JLabel;

import utilities.MyColor_CellRenderer;
import utilities.MyJTable;
import utilities.TableDescriptor;
import utilities.UnitFormatting;

import db_info.DB_Connection;

import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Color;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.util.Locale;
import java.util.Vector;
import java.sql.*;

public class Shim_Table implements ActionListener, TableModelListener, FocusListener, KeyListener, MouseListener {
	JPanel child_panel;
	JPanel button_panel;
	GridBagConstraints class_c;

	MyJTable table;
	DefaultTableModel model;

	JTextField id_field;//for the inner diameter of this stack
	JPopupMenu popup;

	String stack_type;
	String reference_table;
	String reference_spec;
	Long spec_id;

	Active_Setting current_setting;

	Boolean outside_table_valid;
	Boolean table_valid;
	DB_Connection active_db_connection;
	public Shim_Table(Active_Work_Order this_work_order,JPanel parent_panel,
			String t_stack_type,GridBagConstraints parent_c, DB_Connection active_db_connection) {
		stack_type=t_stack_type;
		current_setting=this_work_order.this_setting;
		this.active_db_connection=active_db_connection;

		initializeClassVariables();

		JScrollPane scrollPane = new JScrollPane(table);
		class_c.ipadx=180;
		class_c.ipady=320;  //this makes sure there is plenty of space for the table
		child_panel.add(scrollPane,class_c);
		disableComponents();
		checkTableValues();

		parent_panel.add(child_panel,parent_c);
	}

	public void initializeClassVariables() {
		child_panel=initializeJPanel(stack_type);
		button_panel=initializeJPanel("");

		class_c = new GridBagConstraints();
		class_c.anchor=GridBagConstraints.NORTHWEST;

		popup=new JPopupMenu();

		table = new MyJTable();
		model = (DefaultTableModel)table.getModel();
		table.setAttributes(table);
		table.setPreferredScrollableViewportSize(new Dimension(0,0));
				
		id_field=initializeJTextField(7);//for the inner diameter of this stack

		outside_table_valid=true;
		table_valid=true;

		setReferenceTable(stack_type);

		setUpID();
		child_panel.add(button_panel,class_c);

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
		JPanel t_panel=new JPanel();
		t_panel.setBorder( BorderFactory.createCompoundBorder(
				BorderFactory.createTitledBorder(title),
				BorderFactory.createEmptyBorder(0,0,0,0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}

	public void setReferenceTable(String stack_type) {
		//This method sets up what the reference table will be for this instance of the
		//Settings_Table object
		if (stack_type.equals("Shock Compression")) {
			reference_table="shock_compression_stack";
			reference_spec="shock_spec";
			spec_id=current_setting.shock_spec_id;
		}
		if (stack_type.equals("Shock Comp Adj")) {
			reference_table="shock_compression_adjuster_stack";
			reference_spec="shock_spec";
			spec_id=current_setting.shock_spec_id;
		}
		if (stack_type.equals("Shock Tension")) {
			reference_table="shock_rebound_stack";
			reference_spec="shock_spec";
			spec_id=current_setting.shock_spec_id;
		}
		if (stack_type.equals("Fork Compression")) {
			reference_table="fork_compression_stack";
			reference_spec="fork_spec";
			spec_id=current_setting.fork_spec_id;
		}
		if (stack_type.equals("Fork LSV")) {
			reference_table="fork_lsv_stack";
			reference_spec="fork_spec";
			spec_id=current_setting.fork_spec_id;
		}
		if (stack_type.equals("Fork Rebound")) {
			reference_table="fork_rebound_stack";
			reference_spec="fork_spec";
			spec_id=current_setting.fork_spec_id;
		}
	}

	public void setUpID() {
		class_c.insets=new Insets(0,5,0,5);
		button_panel.add(new JLabel("Inner Diameter"),class_c);

		class_c.insets=new Insets(0,0,0,5);
		class_c.gridwidth=GridBagConstraints.REMAINDER;
		button_panel.add(id_field,class_c);

		class_c.insets=new Insets(0,0,0,0);
	}//end setUp_ID


	public void initializeCols(JTable table, DefaultTableModel model) {
		model.addColumn("OD");
		model.addColumn("Thickness");
		model.addColumn("Qty");

		TableColumn col_OD=table.getColumnModel().getColumn(0);
		TableColumn col_Thickness=table.getColumnModel().getColumn(1);
		TableColumn col_Qty=table.getColumnModel().getColumn(2);

		configureColumn(col_OD,"Enter Shim Outer Diameter");
		configureColumn(col_Thickness,"Enter Shim Thickness");
		configureColumn(col_Qty,"Enter Shim Quantity");

		col_OD.setPreferredWidth(150);
		col_Thickness.setPreferredWidth(150);
		col_Qty.setPreferredWidth(50);
	}

	public void configureColumn(TableColumn col, String tip) {
		DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();
		renderer.setToolTipText(tip);
		col.setCellRenderer(renderer);
	}//end method Configure_Column

	private void bringRowsToMinimum(DefaultTableModel model) {
		//This method makes sure there are at least 20 rows in each table
		Vector<String> data;
		int num_blank_rows=20 - table.getRowCount();
		int num_cols=table.getColumnCount(); 
		for (int row=0;row<num_blank_rows;row++) {
			data=new Vector<String>();
			for(int col=0;col<num_cols;col++) {
				data.add("");
			}
			model.addRow(data);
		}
	}

	private void initializeRows(DefaultTableModel model) {
		Vector<String> data;
		ResultSet rs=null;

		if (stack_type.equals("Shock Compression")) {
			rs=active_db_connection.db_calls.getShockCompShims(current_setting.shock_spec_id);
		}
		if (stack_type.equals("Shock Comp Adj")) {
			rs=active_db_connection.db_calls.getShockCompAdjShims(current_setting.shock_spec_id);
		}
		if (stack_type.equals("Shock Tension")) {
			rs=active_db_connection.db_calls.getShockRebShims(current_setting.shock_spec_id);
		}
		if (stack_type.equals("Fork Compression")) {
			rs=active_db_connection.db_calls.getForkCompShims(current_setting.fork_spec_id);
		}
		if (stack_type.equals("Fork LSV")) {
			rs=active_db_connection.db_calls.getForkLSVShims(current_setting.fork_spec_id);
		}
		if (stack_type.equals("Fork Rebound")) {
			rs=active_db_connection.db_calls.getForkRebShims(current_setting.fork_spec_id);
		}

		try {
			if (rs.first()) {
				Integer incremental_pos=0;
				Integer pos;
				id_field.setText(UnitFormatting.replaceNulls(rs.getString("ID"),
						UnitFormatting.width_measure,
						UnitFormatting.width_limit,"Double"));
				do
				{
					pos=rs.getInt("pos");//the shim position
					while (incremental_pos<pos) {
						//Add a blank row until we have a row with some information in it
						data=new Vector<String>();
						data.add(""); //the shim outer diameter
						data.add(""); //the shim thickness
						data.add(""); //the shim qty
						model.addRow(data);
						incremental_pos++;
					}

					//Add a row with some information in it
					data=new Vector<String>();
					String qty_result = UnitFormatting.replaceNulls( rs.getString("qty")); // the shim qty					

					if(qty_result.equals("98")){
						data.add("Stop Plate"); // the shim outer diameter
						data.add("Stop Plate"); // the shim thickness
						data.add("Stop Plate"); // the shim qty
						data.add(""); // the shim width

					}else if (qty_result.equals("99")){
						data.add("Next Piston"); // the shim outer diameter
						data.add("Next Piston"); // the shim thickness
						data.add("Next Piston"); // the shim qty
						data.add(""); // the shim width
					}else {
						//This shim is not a plate or an annotation; so let's check the shim itself
						//get the flag to see if this OD is a Delta shim
						int OD_is_DELTA=rs.getInt("OD_is_DELTA");

						if (OD_is_DELTA==1){
							data.add(UnitFormatting.replaceNulls(rs.getString("OD"),
									UnitFormatting.delta_annotation,
									UnitFormatting.width_limit, "Double")); // the shim outer diameter
						}else{
							data.add(UnitFormatting.replaceNulls(rs.getString("OD"),
									UnitFormatting.width_measure,
									UnitFormatting.width_limit,"Double")); // the shim outer diameter
						}
						data.add(UnitFormatting.replaceNulls(rs.getString("Thickness"),
								UnitFormatting.width_measure,
								UnitFormatting.width_limit,"Double")); // the shim thickness
						data.add(qty_result); // the shim qty
						data.add(""); // the shim width
					}
					model.addRow(data);
					incremental_pos++;
				}while (rs.next());
			}
			bringRowsToMinimum(model);
		}catch (Exception e) {
			if (e.toString().contains("SQLException"))
				System.err.println("Settings_Table 1: Problem retrieving data.");
		}
	}

	private void setSelectedRowAsStopPlate(int row_selected) {
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
				if (table_value.equals("Stop Plate"))
					table.setValueAt("", row, col);
			}// end for cols
		}// end for rows

		for (int col = 0; col < num_cols; col++) {
			//System.out.println("Settings_Table: setSelectedRowAsStopPlate row="+row_selected+" col="+col);
			table.setValueAt("Stop Plate", row_selected, col);
		}

		adjustTableColor();
		model.addTableModelListener(this);// table is updated; so add the listener back in

	}

	private void unSetSelectedRowAsStopPlate() {
		// unsets the stop plate from the table
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
				if (table_value.equals("Stop Plate"))
					table.setValueAt("", row, col);
			}// end for cols
		}// end for rows

		adjustTableColor();
		model.addTableModelListener(this);// table is updated; so add the listener back in
	}
	private void setSelectedRowAsNextPiston(int row_selected) {
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
				if (table_value.equals("Next Piston"))
					table.setValueAt("", row, col);
			}// end for cols
		}// end for rows

		for (int col = 0; col < num_cols; col++) {
			//System.out.println("Settings_Table: setSelectedRowAsNextPiston row="+row_selected+" col="+col);
			table.setValueAt("Next Piston", row_selected, col);
		}

		adjustTableColor();
		model.addTableModelListener(this);// table is updated; so add the listener back in
	}

	private void unSetSelectedRowAsNextPiston() {
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
				if (table_value.equals("Next Piston"))
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
				if (table_value.equals("Next Piston")){
					table_info.color_matrix[row][col]=Color.yellow;	
				}else if (table_value.equals("Stop Plate")){
					table_info.color_matrix[row][col]=Color.cyan;
				} else{
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
		if ( stack_type.equals("Shock Compression")||
				stack_type.equals("Shock Tension") 
		){
			//For the Next Piston
			JMenuItem set_next_piston = new JMenuItem("Set Row as Next Piston");
			JMenuItem unset_next_piston = new JMenuItem("UnSet Row as Next Piston");		
			set_next_piston.setActionCommand("set_as_next_piston");
			unset_next_piston.setActionCommand("unset_as_next_piston");
			set_next_piston.addActionListener(this);
			unset_next_piston.addActionListener(this);

			popup.add(set_next_piston);
			popup.add(unset_next_piston);
		}

		//For the Stop Plate
		JMenuItem set_stop_plate = new JMenuItem("Set Row as Stop Plate");
		JMenuItem unset_stop_plate = new JMenuItem("UnSet Row as Stop Plate");		
		set_stop_plate.setActionCommand("set_as_stop_plate");
		unset_stop_plate.setActionCommand("unset_as_stop_plate");
		set_stop_plate.addActionListener(this);
		unset_stop_plate.addActionListener(this);

		popup.add(set_stop_plate);
		popup.add(unset_stop_plate);		


		JMenuItem add_row= new JMenuItem("Add Row");
		JMenuItem insert_row= new JMenuItem("Insert Row");
		JMenuItem delete_row= new JMenuItem("Delete Row");

		add_row.setActionCommand("add_row");
		insert_row.setActionCommand("insert_row");
		delete_row.setActionCommand("delete_row");

		add_row.addActionListener(this);
		insert_row.addActionListener(this);
		delete_row.addActionListener(this);

		popup.add(add_row);
		popup.add(insert_row);
		popup.add(delete_row);
	}//end setUp_Table_Popup

	public void actionPerformed(ActionEvent ae) {
		if (ae.getActionCommand().equals("set_as_stop_plate")) {
			setSelectedRowAsStopPlate(table.getSelectedRow());
		}
		if (ae.getActionCommand().equals("unset_as_stop_plate")) {
			unSetSelectedRowAsStopPlate();
		}

		if (ae.getActionCommand().equals("set_as_next_piston")) {
			setSelectedRowAsNextPiston(table.getSelectedRow());
		}
		if (ae.getActionCommand().equals("unset_as_next_piston")) {
			unSetSelectedRowAsNextPiston();
		}
		if (ae.getActionCommand().equals("add_row")) {
			//add a blank row into the table
			Vector<String> data = new Vector<String>();
			for(int count=0;count<table.getColumnCount();count++){
				data.add("");	
			}
			model.addRow(data);
			adjustTableColor();
		}
		if (ae.getActionCommand().equals("insert_row")) {
			//insert a blank row into the table
			Vector<String> data = new Vector<String>();
			for(int count=0;count<table.getColumnCount();count++){
				data.add("");	
			}
			model.insertRow(table.getSelectedRow(),data);
			adjustTableColor();
		}
		if (ae.getActionCommand().equals("delete_row")) {
			//delete the active row from the table
			model.removeRow(table.getSelectedRow());
			adjustTableColor();
		}
	}//end method actionPerformed

	public void putBlankInFirstPosition(JComboBox c_box, Vector <Integer> ref_vec) {
		//Add a blank space at the top of the selections,
		//and add a corresponding zero to the reference vector

		c_box.addItem("");
		ref_vec.insertElementAt(0,0);
	}

	public void disableComponents() {
		id_field.removeKeyListener(this);
		id_field.removeFocusListener(this);
		id_field.setEnabled(false);
		disableTextField(id_field);

		table.removeMouseListener(this);
		table.removeFocusListener(this);
		table.setEnabled(false);
	}

	public void enableComponents() {
		id_field.addKeyListener(this);
		id_field.addFocusListener(this);
		enableTextField(id_field);

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

	private Long prepareSpecs(Active_Work_Order t_work_order) {
		ResultSet rs=null;
		Long t_spec_id=new Long(0);

		/*Remove the existing shims from this spec to make room for the new ones based on the setting*/
		rs=active_db_connection.db_calls.removeShimsfromSpec(t_work_order.this_setting.setting_id,reference_table, reference_spec);

		try {
			if (rs.first()) {
				t_spec_id=rs.getLong("spec_id"); //the new spec_id
			}
		}catch (SQLException e) {
			System.err.println("Settings_Table 2: Problem retrieving data.");
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
		//TableAttributes ta=new TableAttributes(table.getSelectedRow(),table.getSelectedColumn(),
		//									   table.getRowCount(),table.getColumnCount());
		
		TableDescriptor table_info= new TableDescriptor(table);

		model.removeTableModelListener(this);//remove the change listener while we update the model
		Boolean local_table_valid=true;
		for (int row=0; row<table.getRowCount(); row++){
			for (int col=0; col<table.getColumnCount(); col++){
				String strvalue=(String)model.getValueAt(row,col);
				strvalue=strvalue.toLowerCase(Locale.ENGLISH);//since we have to look for "delta" permutations

				if (strvalue.equals("")){
					table_info.color_matrix[row][col]=null;
					continue;
				}
				if (strvalue.equals("next piston")){
					table_info.color_matrix[row][col]=Color.yellow;
					continue;
				}
				if (strvalue.equals("stop plate")){
					table_info.color_matrix[row][col]=Color.cyan;
					continue;
				}

				try {

					if ((col==0)&&
						(strvalue.contains(UnitFormatting.delta_annotation.trim().toLowerCase(Locale.ENGLISH)))  ){
						//For Ohlins and WP suspension, they might have
						//a Delta shim in the OD position
						//if there is a delta shim, we have to parse it differently
						String valid_result=UnitFormatting.genDoubleValue_DELTA(strvalue,
								UnitFormatting.width_measure,
								UnitFormatting.width_limit);
						model.setValueAt(valid_result+UnitFormatting.delta_annotation, row, col);							
					}

					if ((col==0)&&(!strvalue.contains(UnitFormatting.delta_annotation.trim().toLowerCase(Locale.ENGLISH))) 
							|| (col==1)){
						//double values in the first two table columns
						String valid_result=UnitFormatting.genDoubleValue(strvalue,
								UnitFormatting.width_measure,
								UnitFormatting.width_limit);
						model.setValueAt(valid_result+UnitFormatting.length_measure, row, col);	
					}
					if (col==2){
						//integer values in the last table columns
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue,"",
								UnitFormatting.qty_limit);
						model.setValueAt(valid_result+"", row, col);	
					}
					//it was a good value
					table_info.color_matrix[row][col]=null;
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
					"Warning",JOptionPane.WARNING_MESSAGE,null);
			return;
		}

		//This method takes the data out of the table and puts it in the database
		The_Desktop.setCursorWait(true);

		//get the spec_id for this particular setting
		spec_id=prepareSpecs(t_work_order);

		int num_rows=table.getRowCount();

		String this_id;

		try {
			this_id = UnitFormatting.genDoubleValue(id_field.getText(),
					UnitFormatting.width_measure,
					UnitFormatting.width_limit);
		} catch (Exception e) {
			//shouldn't ever get here, settings should already be validated
			//before this
			this_id = new Double("0").toString();
		}
		int saved_shim_flag=0;//a flag to indicate we made at least one save
		for (int row=0; row<num_rows; row++) {
			if (((String) table.getValueAt(row, 0)).equals("Next Piston")) {
				active_db_connection.db_calls.insertShimsIntoSpec(
						t_work_order.this_setting.setting_id, reference_table,
						reference_spec, spec_id, row,Double.valueOf("0"), Double.valueOf("0"),
						Double.valueOf("0"),Double.valueOf("0"),
						0, Double.valueOf("0"),Double.valueOf("0"), 99);
				saved_shim_flag=1;//at least one shim save, so set the flag
				continue;
			}			
			if (((String) table.getValueAt(row, 0)).equals("Stop Plate")) {
				active_db_connection.db_calls.insertShimsIntoSpec(
						t_work_order.this_setting.setting_id, reference_table,
						reference_spec, spec_id, row,Double.valueOf("0"), Double.valueOf("0"),
						Double.valueOf("0"),Double.valueOf("0"),
						0, Double.valueOf("0"),Double.valueOf("0"), 98);
				saved_shim_flag=1;//at least one shim save, so set the flag
				continue;
			}			


			String this_OD;
			int this_OD_is_DELTA=0;
			String this_thickness;
			Integer this_qty;

			try {
				//get the lowercase string value at the row, 0 col of the table; this is the Outter Diameter col
				String OD_strvalue=((String)model.getValueAt(row,0)).toLowerCase(Locale.ENGLISH);
				if (OD_strvalue.contains(UnitFormatting.delta_annotation.trim().toLowerCase(Locale.ENGLISH))){
					//For Ohlins and WP suspension, they might have
					//a Delta shim in the OD position
					//if there is a delta shim, we have to set the DELTA flag to 1
					this_OD=UnitFormatting.genDoubleValue_DELTA(OD_strvalue,
							UnitFormatting.width_measure,
							UnitFormatting.width_limit);
					this_OD_is_DELTA=1;

				}else{
					//the OD string value didn't contain "delta" so we go ahead like normal and set the
					//DELTA flag to 0 
					this_OD = UnitFormatting.genDoubleValue((String)table.getValueAt(row, 0),
							UnitFormatting.width_measure,
							UnitFormatting.width_limit);
					this_OD_is_DELTA=0;
				}

				this_thickness = UnitFormatting.genDoubleValue((String)table.getValueAt(row, 1),
						UnitFormatting.width_measure,
						UnitFormatting.width_limit);
				this_qty = UnitFormatting.genIntegerValue((String)table.getValueAt(row, 2),"",UnitFormatting.qty_limit);
			} catch (Exception e) {
				//shouldn't ever get here, settings should already be validated
				//before this
				this_OD = new Double("0").toString();
				this_thickness = new Double("0").toString();
				this_qty = new Integer("0");
			}
			//if any of the values are non-zero save the entry
			if ((Double.valueOf(this_OD)>0) || 
					(Double.valueOf(this_thickness)>0) || 
					(this_qty>0) ) {
				active_db_connection.db_calls.insertShimsIntoSpec(t_work_order.this_setting.setting_id,reference_table, 
						reference_spec,spec_id,	row, Double.valueOf(this_id),Double.valueOf("0"),Double.valueOf("0"),Double.valueOf("0"),
						this_OD_is_DELTA,Double.valueOf(this_OD),Double.valueOf(this_thickness), this_qty);
				saved_shim_flag=1;//at least one shim save, so set the flag
			}
		}
		//if there weren't any shims saved, notify the user these header values cannot 
		//be saved unless at least one shim attribute is specified as well
		if ((saved_shim_flag==0)&&(new Double(this_id)>0)) {
			JOptionPane.showMessageDialog(null,
					"At least one attribute must be set in the\n "+this.stack_type+" table for the data to be saved.",
					"Warning",
					JOptionPane.WARNING_MESSAGE,null);
		}
		The_Desktop.setCursorWait(false);
	}//end method Save_Info

	public void tableChanged(TableModelEvent evt) {
		table_valid=checkTableValues();
	}

	public void focusGained(FocusEvent fe) {
		if (fe.getComponent().toString().contains("JTable")){
			Active_Work_GUIs.next_table=(JTable)fe.getComponent();
		}

		
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
		Boolean res1=checkDoubleValue(id_field);
		outside_table_valid=res1;
	}

	public void keyPressed(KeyEvent ke) {}

	public void keyReleased(KeyEvent ke) {
		if (ke.getKeyCode()==10){
			//if the user hits the return key move focus to the table
			table.requestFocus();
			table.changeSelection(0, 0, false, false);
		}
	}

	public void keyTyped(KeyEvent ke) {}

	public void mouseClicked(MouseEvent arg0) {}

	public void mouseEntered(MouseEvent arg0) {}

	public void mouseExited(MouseEvent arg0) {}

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

	public void mouseReleased(MouseEvent arg0) {}

}//end class Settings_Table

