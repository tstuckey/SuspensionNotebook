package base;

import java.sql.*;

import db_info.DB_Connection;

public class Active_Setting {
    public Integer setting_id;
    public Long shock_spec_id;
    public Long fork_spec_id;

    DB_Connection active_db_connection;

    public Active_Setting(Integer in_setting_id, DB_Connection active_db_connection) {
        setting_id = in_setting_id;
        this.active_db_connection = active_db_connection;
        getSpecs();

    }//end class Active_Settings

    public void getSpecs() {
        //This method finds the shock and rebound specs for a given setting
        ResultSet rs = null;

        rs = active_db_connection.db_calls.getShockForkSpecsForSetting(setting_id);

        try {
            if (rs.first()) {
                shock_spec_id = rs.getLong("shock_spec");//the shock spec
                fork_spec_id = rs.getLong("fork_spec"); //the fork spec
            }
        } catch (SQLException e) {
            System.err.println("Active_Setting:  Problem retrieving data.");
            e.printStackTrace();
        }
    }
}
