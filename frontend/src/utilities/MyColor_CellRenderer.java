package utilities;

import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.*;


import java.awt.*;

public class MyColor_CellRenderer extends DefaultTableCellRenderer {
    TableDescriptor the_table_info=null;
    
    public MyColor_CellRenderer(TableDescriptor table_info){
        the_table_info=table_info;
    }
    
    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected,
            boolean hasFocus, int row, int col) {
        setText(String.valueOf(value));//repaint the text already in the cell
        setBackground(the_table_info.color_matrix[row][col]);
        super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, col);
        return(this);   //return to calling method
    }
    
}

