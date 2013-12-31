package base;
import javax.swing.JInternalFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.BorderFactory;

import db_info.DB_Connection;

import java.awt.*;

/* Used by Setup_Desktop.java. */
public class Add_Element_Frame extends JInternalFrame {
    static int openFrameCount = 0;
    static final int xOffset = 45, yOffset = 45;
    DB_Connection active_db_connection;
    public Add_Element_Frame(String cmd, DB_Connection active_db_connection) {
        super( null,
                true, //resizable
                true, //closable
                true, //maximizable
                true);//iconifiable
        
        this.active_db_connection=active_db_connection;
        JPanel add_panel = new JPanel();
        add_panel.setLayout(new GridBagLayout());
        
        if (cmd.equals("add customer")) {
            add_panel.setBorder( BorderFactory.createCompoundBorder(
                    BorderFactory.createTitledBorder("Add Customer"),
                    BorderFactory.createEmptyBorder(0,0,0,0)));
            
            //put the items on the add_panel
            new Add_Customer(add_panel,active_db_connection);
        }
        
        if (cmd.equals("add bike")) {
            add_panel.setBorder( BorderFactory.createCompoundBorder(
                    BorderFactory.createTitledBorder("Add Customer"),
                    BorderFactory.createEmptyBorder(0,0,0,0)));
            
            //put the items on the add_panel
            new Add_Bike(add_panel,active_db_connection);
            }
        
        JScrollPane areaScrollPane=new JScrollPane(add_panel);
        areaScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
        this.add(areaScrollPane);
        this.pack();
        
        //Set the window's location.
        setLocation(xOffset*openFrameCount, yOffset*openFrameCount);
    }
}
