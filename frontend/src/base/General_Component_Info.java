package base;

import java.awt.GridBagConstraints;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JPanel;

import db_info.DB_Connection;

public class General_Component_Info {
	String product_identifier;
	String the_comments;
	
	Comments general_info;
	Active_Work_Order current_work_order;
	DB_Connection active_db_connection;
	public General_Component_Info(Active_Work_Order work_order, String t_prod_id,
								  JPanel parent_panel, GridBagConstraints c, DB_Connection active_db_connection){
		current_work_order=work_order;
		product_identifier=t_prod_id;
		this.active_db_connection=active_db_connection;
		retrieveComments(current_work_order);
		general_info=new Comments(parent_panel,"",c,the_comments,
				                  "This can only be edited when the rider name is either 'Baseline' or 'Stock'","disabled","XL box");
	}

    public void retrieveComments(Active_Work_Order work_order) {
        //This method retrieves the 
        ResultSet rs=null;
        
        if (product_identifier.contains("Fork")){
           rs=active_db_connection.db_calls.getForkGeneralInfo(work_order.this_setting.fork_spec_id);
        }  else if (product_identifier.contains("Shock")){
        	rs=active_db_connection.db_calls.getShockGeneralInfo(work_order.this_setting.shock_spec_id);
        }
        
        try {
            if (rs.first()) {
            	the_comments=rs.getString("General Info");
            }
        }catch (SQLException e) {
            System.err.println("General_Component_Info:  Problem retrieving data.");
        }
    }
    
	public void enableComponents() {
		//We only want to enable the the general information text areas when there it is either the Baseline or Stock "rider name"
		//and for models: 1. when the existing model was null OR 2. when the existing model and the current model match 
		Settings_Frame current_setting_ref=Active_Work_GUIs.determineCurrentSettingsFrame(current_work_order);
		if (current_setting_ref!=null){
			Object raw_rider_comboBox_selection=current_setting_ref.all_info.work_info.general_info.rider_info.rider_box.getSelectedItem();
			String currently_selected_rider_name=((String)raw_rider_comboBox_selection);
			
			
			if ((currently_selected_rider_name.startsWith("Baseline")) ||
			   ((currently_selected_rider_name.startsWith("Stock")))){

				String existing_model=current_setting_ref.all_info.work_info.general_info.bike_info.existing_model;
				Object raw_model_comboBox_selection=current_setting_ref.all_info.work_info.general_info.bike_info.model_box.getSelectedItem();
				String currently_selected_model=((String)raw_model_comboBox_selection);
				if (existing_model==null){
					general_info.enableComponents();
				}else if (existing_model.equals(currently_selected_model)){
					general_info.enableComponents();
				}
			}
		}
    }
    
    public void disableComponents() {
        general_info.disableComponents();
    }
	
    public void maybeDisableGeneralInformation(){
		//We only want to enable the the general information text areas when there it is either the Baseline or Stock "rider name"
		//and for models: 1. when the existing model was null OR 2. when the existing model and the current model match 
		Settings_Frame current_setting_ref=Active_Work_GUIs.determineCurrentSettingsFrame(current_work_order);
		
		if (current_setting_ref!=null){
			
			Object raw_rider_comboBox_selection=current_setting_ref.all_info.work_info.general_info.rider_info.rider_box.getSelectedItem();
			String currently_selected_rider_name=((String)raw_rider_comboBox_selection);
			
			if ((currently_selected_rider_name.startsWith("Baseline")) ||
			   ((currently_selected_rider_name.startsWith("Stock")))){

				String existing_model=current_setting_ref.all_info.work_info.general_info.bike_info.existing_model;
				Object raw_model_comboBox_selection=current_setting_ref.all_info.work_info.general_info.bike_info.model_box.getSelectedItem();
				String currently_selected_model=((String)raw_model_comboBox_selection);

				if ((existing_model==null)||
					(existing_model.contains("null")) ){
					general_info.enableComponents();
				}else if (existing_model.equals(currently_selected_model)){
					general_info.enableComponents();
				}else if (!existing_model.equals(currently_selected_model)){
					general_info.disableComponents();
				}
			}else{
				//the currently selected rider was neither Baseline and Stock so disable the components
				general_info.disableComponents();
			}
		}
	} 
    public void saveInfo(Active_Work_Order t_work_order) {
    	if (product_identifier.contains("Fork")&&(general_info.textArea.isEnabled())){
    		active_db_connection.db_calls.updateForkGeneralInfo(t_work_order.this_setting.fork_spec_id,general_info.textArea.getText().trim());
         }  else if (product_identifier.contains("Shock")&&(general_info.textArea.isEnabled())){
        	 active_db_connection.db_calls.updateShockGeneralInfo(t_work_order.this_setting.shock_spec_id,general_info.textArea.getText().trim());
         }
    }

}
