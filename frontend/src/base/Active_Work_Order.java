package base;
import java.sql.*;

import db_info.DB_Connection;

public class Active_Work_Order {
    public Integer work_order_id=0;
    public Active_Setting this_setting;
    
    public String selected_shock_brand="";
    public String selected_fork_brand="";

    public Boolean editable=false;
    DB_Connection active_db_connection;
    public Active_Work_Order(Integer in_work_order_id,Boolean editable, DB_Connection active_db_connection) {
        work_order_id=in_work_order_id;
        this.active_db_connection=active_db_connection;
        getSettingID();
        this.editable=editable;
    }//end class Active_Work_Orders
    
    public void getSettingID() {
        //This method finds the shock and rebound specs for a given setting
        ResultSet rs=null;
        
        rs=active_db_connection.db_calls.getSettingFromWorkOrder(work_order_id);
        
        try {
            if (rs.first()) {
            	this_setting=new Active_Setting(rs.getInt("setting"),active_db_connection);//the setting for this work_order
            }
        }catch (SQLException e) {
            System.err.println("Active_Work_Order:  Problem retrieving data.");
            e.printStackTrace();
        }
    }
}
