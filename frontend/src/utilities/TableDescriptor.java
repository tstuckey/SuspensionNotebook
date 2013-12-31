package utilities;

import java.awt.Color;

import javax.swing.JTable;

public class TableDescriptor {
	public Color[][] color_matrix=null;
	public TableDescriptor(JTable table){
		color_matrix=new Color[table.getRowCount()][table.getColumnCount()];
	}
}
