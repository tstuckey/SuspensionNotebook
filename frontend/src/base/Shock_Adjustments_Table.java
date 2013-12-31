package base;

import javax.swing.JComboBox;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
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

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.Color;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.util.Vector;
import java.util.zip.DataFormatException;
import java.sql.*;

public class Shock_Adjustments_Table extends JPanel implements ActionListener, TableModelListener, KeyListener, FocusListener {
	JPanel child_panel;
	MyJTable table;
	DefaultTableModel model;
	GridBagConstraints class_c;

	String the_comments;

	Active_Setting current_setting;
	Comments shock_comments;
	Boolean table_valid;
	DB_Connection active_db_connection;
	public Shock_Adjustments_Table(Active_Setting this_setting, JPanel parent_panel,
			String title,GridBagConstraints parent_c, DB_Connection active_db_connection) {
		current_setting=this_setting;
		this.active_db_connection=active_db_connection;
		
		initializeClassVariables(title,parent_panel); 
		JScrollPane scrollPane = new JScrollPane(table);
		child_panel.add(scrollPane,class_c);
		
		parent_c.gridwidth=1;
		shock_comments = new Comments(parent_panel,"Shock Comments", parent_c,the_comments,null,"disabled","small box");
		disableComponents();
		checkTableValues();
		
		SetupChangeListeners();
		parent_panel.add(child_panel,parent_c);
		parent_c.gridwidth=GridBagConstraints.REMAINDER;
	}

	public void initializeClassVariables(String title,JPanel parent_panel){
		child_panel=initializeJPanel(title);
		child_panel.setLayout(new GridBagLayout());
		class_c = new GridBagConstraints();
		class_c.anchor=GridBagConstraints.NORTHWEST;

		table = new MyJTable();
		model = (DefaultTableModel)table.getModel();
		table.setAttributes(table);
		table.setPreferredScrollableViewportSize(new Dimension(650, 16));		

		initializeCols(table, model);//initialize the columns
		the_comments=initializeRows(model);

		table_valid=true;
	}

	public JPanel initializeJPanel(String title) {
		JPanel t_panel = new JPanel();
		t_panel.setBorder(BorderFactory.createCompoundBorder(BorderFactory
				.createTitledBorder(title), BorderFactory.createEmptyBorder(0,
						0, 0, 0)));
		t_panel.setLayout(new GridBagLayout());
		return t_panel;
	}  

	public void initializeCols(JTable table, DefaultTableModel model) {
		model.addColumn("Rate");
		model.addColumn("LS Comp");
		model.addColumn("HS Comp");
		model.addColumn("Reb");
		model.addColumn("Oil Type");
		model.addColumn("Nitrogen");
		model.addColumn("Z Cut");
		model.addColumn("Sag");

		TableColumn col_rate=table.getColumnModel().getColumn(0);
		TableColumn col_ls_comp=table.getColumnModel().getColumn(1);
		TableColumn col_hs_comp=table.getColumnModel().getColumn(2);
		TableColumn col_rebound=table.getColumnModel().getColumn(3);
		TableColumn col_oil_type=table.getColumnModel().getColumn(4);
		TableColumn col_nitrogen=table.getColumnModel().getColumn(5);
		TableColumn col_z_cut=table.getColumnModel().getColumn(6);
		TableColumn col_sag=table.getColumnModel().getColumn(7);

		col_rate.setPreferredWidth(100);
		col_ls_comp.sizeWidthToFit();
		col_hs_comp.sizeWidthToFit();
		col_rebound.sizeWidthToFit();
		col_oil_type.sizeWidthToFit();
		col_nitrogen.sizeWidthToFit();
		col_z_cut.sizeWidthToFit();
		col_sag.sizeWidthToFit();

		configureColumn(col_rate,"Enter Spring Rate");
		configureColumn(col_ls_comp,"Enter LS Comp");
		configureColumn(col_hs_comp,"Enter HS Comp");
		configureColumn(col_rebound,"Enter reb");
		configureColumn(col_oil_type,"Enter oil type");
		configureColumn(col_nitrogen,"Enter nitrogen pressure");
		configureColumn(col_z_cut,"Enter yes/no");
		configureColumn(col_sag,"Enter sag");

	}//end method setUp_PullDown_Cols

	public void configureColumn(TableColumn col, String tip) {
		//Set up tool tips
		DefaultTableCellRenderer renderer = new DefaultTableCellRenderer();
		renderer.setToolTipText(tip);
		col.setCellRenderer(renderer);

	}//end method Configure_Rate_Column


	private void bringRowsToMinimum(DefaultTableModel model) {
		//This method makes sure there are at least 1 row in this table
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

	private String initializeRows(DefaultTableModel model) {
		String the_comments=null;

		Vector<String> data;
		ResultSet rs=null;

		rs=active_db_connection.db_calls.getShockSpec(current_setting.shock_spec_id);

		try {
			if (rs.first()) {
				data=new Vector<String>();
				data.add(UnitFormatting.replaceNulls(rs.getString("Rate"),
										UnitFormatting.rate_measure,
										UnitFormatting.rate_limit,"Double"));
				data.add(UnitFormatting.replaceNulls(rs.getString("LS_Comp"),
						 							"",
						 							UnitFormatting.click_limit,"Integer"));
				data.add(UnitFormatting.replaceNulls(rs.getString("HS_Comp")));
				data.add(UnitFormatting.replaceNulls(rs.getString("Rebound"),
						 							"",
						 							UnitFormatting.click_limit,"Integer"));
				data.add(UnitFormatting.replaceNulls(rs.getString("Oil_Type")));
				data.add(UnitFormatting.replaceNulls(rs.getString("Nitrogen"),
										UnitFormatting.pressure_measure,
										UnitFormatting.pressure_limit, "Integer"));
				data.add(UnitFormatting.replaceNulls(rs.getString("Z_Cut")));
				data.add(UnitFormatting.replaceNulls(rs.getString("Sag"),
										UnitFormatting.length_measure,
										UnitFormatting.length_limit, "Integer"));
				the_comments=rs.getString("Comments");
				model.addRow(data);
			}
			bringRowsToMinimum(model);
		}
		catch (SQLException sql){
			System.err.println("Shock_Adjustments_Table: Problem retrieving data.");
		}
		catch (DataFormatException e) {
			System.err.println("Shock_Adjustments_Table:  Problem with format of initial data");
			e.printStackTrace();
		}		
		return the_comments;
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
	public void disableComponents() {
		table.setEnabled(false);
		shock_comments.disableComponents();
	}

	public void enableComponents() {
		table.setEnabled(true);
		shock_comments.enableComponents();
	}

	public void actionPerformed(ActionEvent ae) {
		//empty stub unless events need to be handled
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
					}
					if (col==1){
						//LS comp
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue,"",
											 UnitFormatting.click_limit);
						model.setValueAt(valid_result+"", row, col);	
					}				
					if (col==2){
						//HS comp
						String valid_result=UnitFormatting.genStringValue(strvalue,
								            UnitFormatting.str_length);
						model.setValueAt(valid_result+"", row, col);	
					}					
					if (col==3){
						//Rebound value
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue,"",
											 UnitFormatting.click_limit);
						model.setValueAt(valid_result+"", row, col);	
					}					
					if (col==4){
						//Oil Type value
						String valid_result=UnitFormatting.genStringValue(strvalue,
								            UnitFormatting.str_length);
						model.setValueAt(valid_result+"", row, col);	
					}					
					if (col==5){
						//Nitrogen value
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue,UnitFormatting.pressure_measure,
											 UnitFormatting.pressure_limit);
						model.setValueAt(valid_result+UnitFormatting.pressure_measure, row, col);	
					}					
					if (col==6){
						//Z cut value
						String valid_result=UnitFormatting.genStringValue(strvalue,
											UnitFormatting.zcut_lenth);
						model.setValueAt(valid_result+"", row, col);	
					}					
					if (col==7){
						//Sag value
						Integer valid_result=UnitFormatting.genIntegerValue(strvalue,UnitFormatting.length_measure,
											 UnitFormatting.length_limit);
						model.setValueAt(valid_result+UnitFormatting.length_measure, row, col);
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
		//This method takes the data out of the table and puts it in the database
		active_db_connection.db_calls.saveShockComments(t_work_order.this_setting.setting_id,shock_comments.textArea.getText().trim());

		if ((!table_valid)){
			JOptionPane.showMessageDialog(null,
					"There is one or more data format errors in\n the Shock Adjustments table for the data to be saved.",
					"Warning",JOptionPane.WARNING_MESSAGE,null);
			return;
		}
		
		int num_rows=table.getRowCount();//there should only be one row
		for (int pos=0; pos<num_rows; pos++) {
			String springs;
			Integer LS_comp;
			String HS_comp_turns;
			Integer reb;
			String oil_type;
			Integer nitrogen;
			String z_cut;
			Integer sag;

			try {
				springs = UnitFormatting.genDoubleValue((String)table.getValueAt(pos, 0),
						  				 UnitFormatting.rate_measure,
						  				 UnitFormatting.rate_limit);
				LS_comp = UnitFormatting.genIntegerValue((String)table.getValueAt(pos, 1),"",
						  UnitFormatting.click_limit);
				HS_comp_turns = UnitFormatting.genStringValue((String)table.getValueAt(pos, 2),5);
				reb = UnitFormatting.genIntegerValue((String)table.getValueAt(pos, 3),"",
					  UnitFormatting.click_limit);
				oil_type = ((String)table.getValueAt(pos, 4));
				nitrogen = UnitFormatting.genIntegerValue((String)table.getValueAt(pos, 5),
						   UnitFormatting.pressure_measure,UnitFormatting.pressure_limit);
				z_cut = UnitFormatting.genStringValue((String)table.getValueAt(pos, 6),3);
				sag = UnitFormatting.genIntegerValue((String)table.getValueAt(pos, 7),
					  UnitFormatting.length_measure,UnitFormatting.length_limit);
			} catch (Exception e) {
				//shouldn't ever get here, settings should already be validated
				//before this
				springs = new Double("0").toString();
				LS_comp = new Integer("0");
				HS_comp_turns = new String("");
				reb = new Integer("0");
				oil_type = new String("");
				nitrogen = new Integer("0");
				z_cut = new String("");
				sag = new Integer("0");			
			}
			active_db_connection.db_calls.saveShockAdjustments(t_work_order.this_setting.setting_id,Double.valueOf(springs),
					LS_comp,HS_comp_turns,reb,oil_type,nitrogen,z_cut,sag);
		}
	}//end method Save_Info

	public void tableChanged(TableModelEvent arg0) {
		table_valid=checkTableValues();
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


}//end class Shock_Adjustments_Table

