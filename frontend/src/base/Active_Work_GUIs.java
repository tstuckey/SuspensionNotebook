package base;

import java.awt.Color;
import java.util.Vector;
import javax.swing.JComboBox;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumnModel;
import javax.swing.table.TableColumn;


import utilities.MyColor_CellRenderer;
import utilities.MyWhite_CellRenderer;
import utilities.TableDescriptor;

import db_info.DB_Connection;

public class Active_Work_GUIs{
	public static Vector<Settings_Frame> active_settings_frames;
	public static Settings_Frame FROM_settings_frame;
	public static Settings_Frame TO_settings_frame;
	public static JTable prev_table; //to facilitate toggling of table selections in Settings_Table and Settings_Table_Measurement
	public static JTable next_table; //to facilitate toggling of table selections in Settings_Table and Settings_Table_Measurement
	public static DB_Connection active_db_connection;
	public Active_Work_GUIs(DB_Connection active_db_connection) {
		active_settings_frames=new Vector<Settings_Frame>();
		Active_Work_GUIs.active_db_connection=active_db_connection;

	}//end constructor Active_Work_GUIss

	public static void removeWorkOrder(Active_Work_Order work_order) {
		//System.out.println("Removing "+work_order.work_order_id);
		int i=0;
		while (i<active_settings_frames.size()){
			if (active_settings_frames.elementAt(i).current_work_order.work_order_id==work_order.work_order_id){
				active_settings_frames.removeElementAt(i);//remove the setting whose frame closed
				if (work_order.editable)active_db_connection.db_calls.deleteOpenWorkOrder(work_order.work_order_id);//remove from the open work order table
				Settings_Frame.openFrameCount--;
				break;
			}
			i++;
		}
	}
	public static void removeAllWorkOrders() {
		int i=0;
		while (i<active_settings_frames.size()){
			if (active_settings_frames.elementAt(i).current_work_order.editable){
				active_db_connection.db_calls.deleteOpenWorkOrder(active_settings_frames.elementAt(i).current_work_order.work_order_id);//remove from the open work order table
			}
			i++;
		}
	}

	public static void changeFROMSettingsFrame(Settings_Frame from_info, Color button_color){
		makeComparisionsWhite();
		//if the from button has been set to GREEN, then the user wants this to be
		//the active from setting
		if (button_color==Color.GREEN){
			if (FROM_settings_frame != null)
				FROM_settings_frame.set_from_button.setBackground(Color.WHITE);//unset the previous selection
			FROM_settings_frame=from_info;//set the incoming from_info as the active FROM_settings_frame
			compareSettings();
		}

		//if the from button has been set to WHITE, then the user wants to unset this as
		//the active from setting
		if (button_color==Color.WHITE){
			FROM_settings_frame=null;
		}

	}

	public static void changeTOSettingsFrame(Settings_Frame to_info, Color button_color){
		makeComparisionsWhite();
		//if the from button has been set to RED, then the user wants this to be
		//the active from setting
		if (button_color==Color.RED){
			if (TO_settings_frame != null)
				TO_settings_frame.set_to_button.setBackground(Color.WHITE);//unset the previous selection
			TO_settings_frame=to_info;//set the incoming to_info as the active TO_settings_frame
			compareSettings();
		}

		//if the from button has been set to WHITE, then the user wants to unset this as
		//the active from setting
		if (button_color==Color.WHITE){
			TO_settings_frame=null;
		}

	}

	public static void compareSettings(){
		if ((FROM_settings_frame == null)||(TO_settings_frame==null)){
			return;
		}
		if (FROM_settings_frame == TO_settings_frame){
			return;
		}
		compareComboBox(FROM_settings_frame.all_info.work_info.general_info.rider_info.ability_box,
				TO_settings_frame.all_info.work_info.general_info.rider_info.ability_box);
		compareComboBox(FROM_settings_frame.all_info.work_info.general_info.rider_info.weight_box,
				TO_settings_frame.all_info.work_info.general_info.rider_info.weight_box);
		compareComboBox(FROM_settings_frame.all_info.work_info.general_info.rider_info.height_box,
				TO_settings_frame.all_info.work_info.general_info.rider_info.height_box);


		compareTables(FROM_settings_frame.all_info.shock_info.shock_compression.table,
				TO_settings_frame.all_info.shock_info.shock_compression.table);
		compareTextFields(FROM_settings_frame.all_info.shock_info.shock_compression.id_field,
				TO_settings_frame.all_info.shock_info.shock_compression.id_field);

		compareTables(FROM_settings_frame.all_info.shock_info.shock_compression_adjuster.table,
				TO_settings_frame.all_info.shock_info.shock_compression_adjuster.table);
		compareTextFields(FROM_settings_frame.all_info.shock_info.shock_compression_adjuster.id_field,
				TO_settings_frame.all_info.shock_info.shock_compression_adjuster.id_field);

		compareTables(FROM_settings_frame.all_info.shock_info.shock_rebound.table,
				TO_settings_frame.all_info.shock_info.shock_rebound.table);
		compareTextFields(FROM_settings_frame.all_info.shock_info.shock_rebound.id_field,
				TO_settings_frame.all_info.shock_info.shock_rebound.id_field);

		compareTables(FROM_settings_frame.all_info.shock_info.shock_adjustments.table,
				TO_settings_frame.all_info.shock_info.shock_adjustments.table);


		compareTables(FROM_settings_frame.all_info.fork_info.fork_compression.table,
				TO_settings_frame.all_info.fork_info.fork_compression.table);
		compareTextFields(FROM_settings_frame.all_info.fork_info.fork_compression.id_field,
				TO_settings_frame.all_info.fork_info.fork_compression.id_field);

		compareTables(FROM_settings_frame.all_info.fork_info.fork_lsv.table,
				TO_settings_frame.all_info.fork_info.fork_lsv.table);
		compareTextFields(FROM_settings_frame.all_info.fork_info.fork_lsv.id_field,
				TO_settings_frame.all_info.fork_info.fork_lsv.id_field);

		compareTables(FROM_settings_frame.all_info.fork_info.fork_rebound.table,
				TO_settings_frame.all_info.fork_info.fork_rebound.table);
		compareTextFields(FROM_settings_frame.all_info.fork_info.fork_rebound.id_field,
				TO_settings_frame.all_info.fork_info.fork_rebound.id_field);

		compareTables(FROM_settings_frame.all_info.fork_info.fork_bcv.table,
				TO_settings_frame.all_info.fork_info.fork_bcv.table);
		compareTextFields(FROM_settings_frame.all_info.fork_info.fork_bcv.col_length_field,
				TO_settings_frame.all_info.fork_info.fork_bcv.col_length_field);
		compareTextFields(FROM_settings_frame.all_info.fork_info.fork_bcv.piston_tower_field,
				TO_settings_frame.all_info.fork_info.fork_bcv.piston_tower_field);
		compareTextFields(FROM_settings_frame.all_info.fork_info.fork_bcv.spring_cup_field,
				TO_settings_frame.all_info.fork_info.fork_bcv.spring_cup_field);
		compareTextFields(FROM_settings_frame.all_info.fork_info.fork_bcv.float_calculation_field,
				TO_settings_frame.all_info.fork_info.fork_bcv.float_calculation_field);

		compareTables(FROM_settings_frame.all_info.fork_info.fork_adjustments.table,
				TO_settings_frame.all_info.fork_info.fork_adjustments.table);

	}

	private static void compareTables(JTable FROM_settings_table, JTable TO_settings_table){
		int FROM_settings_table_num_rows=FROM_settings_table.getRowCount();
		int TO_settings_table_num_rows=TO_settings_table.getRowCount();
		int num_cols=TO_settings_table.getColumnCount();
		TableDescriptor table_info=null;
		int max_size=0;
		if (FROM_settings_table_num_rows >= TO_settings_table_num_rows){
			max_size=FROM_settings_table_num_rows;
			table_info=new TableDescriptor(FROM_settings_table);
		}
		else{
			max_size=TO_settings_table_num_rows;
			table_info=new TableDescriptor(TO_settings_table);
		}

		int FROM_settings_table_flag=0;//set to 1 if the row is not available for this table
		int TO_settings_table_flag=0;//set to 1 if the row is not available for this table

		for (int row=0; row<max_size; row++){
			if (row > (FROM_settings_table_num_rows-1)){
				FROM_settings_table_flag=1;
			}
			if (row > (TO_settings_table_num_rows-1)){
				TO_settings_table_flag=1;
			}

			//if both the tables are in a valid area do the comparison
			if((FROM_settings_table_flag==0)&&(TO_settings_table_flag==0)){
				for (int col=0; col<num_cols; col++){
					String FROM_value=((String)FROM_settings_table.getValueAt(row,col)).trim();
					String TO_value=((String)TO_settings_table.getValueAt(row,col)).trim();

					if (!FROM_value.equals(TO_value)){
						table_info.color_matrix[row][col]=Color.orange;
					}
					else{
						table_info.color_matrix[row][col]=null;
					}
				}//end for col loop
			}

			//if the FROM_settings_table is out of rows, color this TO_settings_table row red
			if((FROM_settings_table_flag==1)&&(TO_settings_table_flag==0)){
				for (int col=0; col<num_cols; col++){
					table_info.color_matrix[row][col]=Color.orange;
				}
			}

			//if the TO_settings_table is out of rows, add a row to the TO_settings_table
			if((FROM_settings_table_flag==0)&&(TO_settings_table_flag==1)){
				addRow(TO_settings_table);
				for (int col=0; col<num_cols; col++){
					table_info.color_matrix[row][col]=Color.orange;
				}
			}
		}//end for row loop
		//Invoke the cell renderer for each column in the table
		TableColumnModel colModel=TO_settings_table.getColumnModel();
		TableColumn t_column=null;
		for (int col=0; col<num_cols; col++){
			t_column = colModel.getColumn(col);
			t_column.setCellRenderer(new MyColor_CellRenderer(table_info));
		}

		FROM_settings_table_flag=0;//reset the row availability flag
		TO_settings_table_flag=0;//reset the row availability flag

		TO_settings_table.repaint();
	}//end Compare_Tables

	private static void addRow(JTable table){
		DefaultTableModel model = (DefaultTableModel)table.getModel();
		int num_cols=table.getColumnCount();

		Vector<String> data=new Vector<String>();
		for (int col=0; col<num_cols; col++){
			data.add("");
		}
		model.addRow(data);
	}

	private static void compareComboBox(JComboBox FROM_cbox, JComboBox TO_cbox){
		String FROM_value=((String)FROM_cbox.getSelectedItem()).trim();
		String TO_value=((String)TO_cbox.getSelectedItem()).trim();

		if (!FROM_value.equals(TO_value)){
			TO_cbox.setForeground(Color.BLACK);
			TO_cbox.setBackground(Color.ORANGE);
		}
	}

	private static void compareTextFields(JTextField FROM_textfield, JTextField TO_textfield){
		String FROM_value=FROM_textfield.getText().trim();
		String TO_value=TO_textfield.getText().trim();

		if (!FROM_value.equals(TO_value)){
			TO_textfield.setForeground(Color.BLACK);
			TO_textfield.setBackground(Color.ORANGE);
		}
	}

	private static void makeComparisionsWhite(){
		if (TO_settings_frame==null){
			return;
		}
		if (FROM_settings_frame == TO_settings_frame){
			return;
		}
		whitenComboBox(TO_settings_frame.all_info.work_info.general_info.rider_info.ability_box);
		whitenComboBox(TO_settings_frame.all_info.work_info.general_info.rider_info.weight_box);
		whitenComboBox(TO_settings_frame.all_info.work_info.general_info.rider_info.height_box);
		TO_settings_frame.all_info.shock_info.shock_compression.checkTableValues();
		TO_settings_frame.all_info.shock_info.shock_compression.checkDoubleValue(
				TO_settings_frame.all_info.shock_info.shock_compression.id_field);
		TO_settings_frame.all_info.shock_info.shock_compression_adjuster.checkTableValues();
		TO_settings_frame.all_info.shock_info.shock_compression_adjuster.checkDoubleValue(
				TO_settings_frame.all_info.shock_info.shock_compression_adjuster.id_field);
		TO_settings_frame.all_info.shock_info.shock_rebound.checkTableValues();
		TO_settings_frame.all_info.shock_info.shock_rebound.checkDoubleValue(
				TO_settings_frame.all_info.shock_info.shock_rebound.id_field);
		whitenTable(TO_settings_frame.all_info.shock_info.shock_adjustments.table);

		TO_settings_frame.all_info.fork_info.fork_compression.checkTableValues();
		TO_settings_frame.all_info.fork_info.fork_compression.checkDoubleValue(
				TO_settings_frame.all_info.fork_info.fork_compression.id_field);
		TO_settings_frame.all_info.fork_info.fork_lsv.checkTableValues();
		TO_settings_frame.all_info.fork_info.fork_lsv.checkDoubleValue(
				TO_settings_frame.all_info.fork_info.fork_lsv.id_field);
		TO_settings_frame.all_info.fork_info.fork_rebound.checkTableValues();
		TO_settings_frame.all_info.fork_info.fork_rebound.checkDoubleValue(
				TO_settings_frame.all_info.fork_info.fork_rebound.id_field);
		TO_settings_frame.all_info.fork_info.fork_bcv.checkTableValues();
		TO_settings_frame.all_info.fork_info.fork_bcv.checkDoubleValue(
				TO_settings_frame.all_info.fork_info.fork_bcv.col_length_field);
		TO_settings_frame.all_info.fork_info.fork_bcv.checkDoubleValue(
				TO_settings_frame.all_info.fork_info.fork_bcv.piston_tower_field);
		TO_settings_frame.all_info.fork_info.fork_bcv.checkDoubleValue(
				TO_settings_frame.all_info.fork_info.fork_bcv.spring_cup_field);

		grayTextField(TO_settings_frame.all_info.fork_info.fork_bcv.float_calculation_field);
		whitenTable(TO_settings_frame.all_info.fork_info.fork_adjustments.table);
}

private static void whitenTable(JTable table){
	TableColumnModel colModel=table.getColumnModel();
	TableColumn column=null;

	int num_cols=table.getColumnCount();
	for (int col=0; col<num_cols; col++){
		column=colModel.getColumn(col);
		column.setCellRenderer(new MyWhite_CellRenderer());
	}
	table.repaint();
}

private static void whitenComboBox(JComboBox cbox){
	cbox.setForeground(Color.BLACK);
	cbox.setBackground(Color.WHITE);
}

private static void grayTextField(JTextField textfield){
	textfield.setForeground(Color.BLACK);
	textfield.setBackground(Color.LIGHT_GRAY);
}

public static Settings_Frame determineCurrentSettingsFrame(Active_Work_Order work_order){
Settings_Frame result=null;

int i=0;
while (i<active_settings_frames.size()){
	if (active_settings_frames.elementAt(i).current_work_order.work_order_id==work_order.work_order_id){
		return (active_settings_frames.elementAt(i));
	}
	i++;
}
return result;
}

}

