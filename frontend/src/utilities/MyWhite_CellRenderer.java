package utilities;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.*;
import java.awt.*;

public class MyWhite_CellRenderer extends DefaultTableCellRenderer {
	
    public MyWhite_CellRenderer(){
    }
    
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected,
            boolean hasFocus, int row, int col) {
        setText(String.valueOf(value));//repaint the text already in the cell
        setBackground(null);  //for other cells set them to null
        super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, col);
        return this;
    }
    
}

