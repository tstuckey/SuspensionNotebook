package base;

import java.util.*;
import javax.swing.*;

import db_info.DB_Connection;



import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;

public class All_Info implements Printable {
//    JComboBox date_box=new JComboBox();
    Vector<Integer> date_type_reference = new Vector<Integer>();
    public JPanel main_all_info_panel;
    JTabbedPane tabbedPane;
    Work_Order_Info work_info;
    Date_Panel date_panel;
    Shock_Info_Panel shock_info;
    Fork_Info_Panel  fork_info;
    Additional_Products_Info add_info;
    
    DB_Connection active_db_connection;
    public All_Info(Active_Work_Order work_order, JPanel parent_panel, 
    		        GridBagConstraints parent_c, DB_Connection active_db_connection) {
        main_all_info_panel=new JPanel();
        main_all_info_panel.setLayout(new GridBagLayout());
                       
        GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.CENTER;
        c.gridwidth=GridBagConstraints.REMAINDER;
        date_panel=new Date_Panel(main_all_info_panel,work_order,c,active_db_connection);
        c.anchor=GridBagConstraints.NORTHWEST;
        c.gridwidth=1;//reset the gridwidth
        
        tabbedPane = new JTabbedPane(JTabbedPane.TOP);
        work_info = new Work_Order_Info(work_order,tabbedPane,active_db_connection);
        shock_info = new Shock_Info_Panel(work_order,tabbedPane,active_db_connection);
        fork_info = new Fork_Info_Panel(work_order,tabbedPane,active_db_connection);
        add_info = new Additional_Products_Info(work_order, tabbedPane,active_db_connection);
        main_all_info_panel.add(tabbedPane, c);
        parent_panel.add(main_all_info_panel, parent_c);
    }
    
    public void resetOverallTitle(String title){
        main_all_info_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
    }
    
    public void enableSubComponents() {
        work_info.enableSubComponents();
        shock_info.enableSubComponents();
        fork_info.enableSubComponents();
        add_info.enableSubComponents();
    }
    
    public void disableSubComponents() {
        work_info.disableSubComponents();
        shock_info.disableSubComponents();
        fork_info.disableSubComponents();
        add_info.disableSubComponents();
    }
    
    public void saveInfo(Active_Work_Order t_work_order) {
        work_info.saveInfo(t_work_order);
        date_panel.saveInfo(t_work_order);
        shock_info.saveInfo(t_work_order);
        fork_info.saveInfo(t_work_order);
        add_info.saveInfo(t_work_order);
    }

    public int print(Graphics g_param, PageFormat pf_param, int page)
	throws PrinterException {
		if (page > 0) { /* We have only one page, and 'page' is zero-based */
			return NO_SUCH_PAGE;
		}


		Graphics2D graphics2D = (Graphics2D)g_param;

		// Scale the printout to fit the pages.

		double scalex = pf_param.getWidth() / (main_all_info_panel.getWidth()+80);//pad this by 80 to get the whole JInternalFrame to print
		double scaley = pf_param.getHeight() / main_all_info_panel.getHeight();
		double scale = Math.min(scalex, scaley);  //scale the most amount we need to
		// translate to the printable (0,0) location on the paper.
		graphics2D.translate((int) pf_param.getImageableX(),
				(int) pf_param.getImageableY());
		graphics2D.scale(scale, scale);

		/* Now print the window and its visible contents */
		main_all_info_panel.printAll(graphics2D);

		/* tell the caller that this page is part of the printed document */
		return PAGE_EXISTS;
	}
    
}//end class All_Info
