package utilities;

import java.awt.Component;
import java.awt.event.KeyEvent;

import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.KeyStroke;
import javax.swing.table.TableCellEditor;
import javax.swing.text.JTextComponent;

public class MyJTable extends JTable{
	
	public MyJTable(){

	}

	//This class adjusts the cell editor for the JTable
	//  Select the text when the cell starts editing
	//  a) text will be replaced when you start typing in a cell
	//  b) text will be selected when you use F2 to start editing
	//  c) caret is placed at end of text when double clicking to start editing
	
	public Component prepareEditor(	
			TableCellEditor editor, int row, int column){
		Component c = super.prepareEditor(editor, row, column);
		if (c instanceof JTextComponent){
			((JTextField)c).selectAll();
		}
		return c;
	}

	public void setAttributes(MyJTable table){
		//adjust this JTable's action map so it advances to the next column cell vice the
		//next row cell
		table.getInputMap(JTable.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT).
		put(KeyStroke.getKeyStroke(KeyEvent.VK_ENTER,0), "selectNextColumnCell");
		//disable row selection in the JTable so that invalid cell entries are more readily visible
		table.setRowSelectionAllowed(false);

		table.setCellSelectionEnabled(true);
	}
	
}
