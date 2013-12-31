package db_info;
import java.sql.*;
import java.util.*;

import base.Suspension_Notebook;

public class DB_Calls {
	Connection conn;
	public DB_Calls(Connection conn){
		this.conn=conn;
	}
	
	private void logPreparedStatement(PreparedStatement p_stmt){
	String whole=p_stmt.toString();
	int class_index=whole.indexOf("call ");
	System.out.println(whole.substring(class_index, whole.length()));
	}
	
	public  Vector<String> getAllValues(String table_name, String field_names,
												String order_by_field,Vector<Integer> ref) {
		//This method receives the table name and field name in the table to be returned and also
		//receives the name of the reference vector to store the unique identifiers for each field.
		//This method directly returns the field_names and indirectly returns the unique identifiers.
		Vector<String> the_results=new Vector<String>();
		PreparedStatement p_stmt;
		ResultSet rs=null;
		ResultSetMetaData rsmd=null;

		ref.removeAllElements();//initialize the reference vector each time
		try {
			p_stmt=conn.prepareStatement("call get_all_values(?,?,?);");
			p_stmt.setString(1,table_name);
			p_stmt.setString(2,field_names);
			p_stmt.setString(3,order_by_field);
			rs=p_stmt.executeQuery();
			rsmd = rs.getMetaData();

			if (rs.first()) {
				do
				{
					ref.add(rs.getInt("row_id"));
					String tmp_to_concatenate_cols="";
					//go from the second column to the end
					for (int col_count=2;col_count<=rsmd.getColumnCount();col_count++) {
						tmp_to_concatenate_cols=tmp_to_concatenate_cols+rs.getString(col_count)+" ";
					}
					//System.out.println("result "+tmp_to_concatenate_cols.trim());
					the_results.add(tmp_to_concatenate_cols.trim());
				}while (rs.next());
			}
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return the_results;
	}

	public  ResultSet clearOpenWorkOrders() {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call clear_open_work_orders();");
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with clear_open_work_orders.");
			exc.printStackTrace();
		}
		return rs;
	}
	
	public ResultSet createNewWorkOrder() {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call create_new_work_order();");
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
			}catch (Exception exc) {
			System.out.println("Problem with create_new_work_order.");
			exc.printStackTrace();
		}
		return rs;
	}

	public Integer cloneWorkOrder(Integer work_order,String clone_type, String revision_type) {
		PreparedStatement p_stmt;
		ResultSet rs=null;
		Integer new_work_order=0;

		try {
			p_stmt=conn.prepareStatement("call clone_work_order(?,?,?);");
			
			p_stmt.setInt(1,work_order);
			p_stmt.setString(2,clone_type);
			p_stmt.setString(3,revision_type);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			if (rs.first()){
				new_work_order=(rs.getInt("new_work_order"));
			}
		}catch (Exception exc) {
			System.out.println("Problem with clone_work_order.");
			exc.printStackTrace();
		}
		return new_work_order;
	}

	public ResultSet deleteWorkOrder(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call delete_work_order(?);");
			p_stmt.setInt(1,work_order);

			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with delete_work_order.");
			exc.printStackTrace();
		}
		return rs;
	}


	public ResultSet getGeneralInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_general_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with get_general_info.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getSettingFromWorkOrder(Integer work_order_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_setting_from_workorder(?);");
			p_stmt.setInt(1,work_order_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving setting.");
			exc.printStackTrace();
		}
		return rs;
	}



	public ResultSet getChangeDate(Integer in_setting) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_change_date(?);");
			p_stmt.setInt(1,in_setting);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getRevision(Integer in_work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_revision(?);");
			p_stmt.setInt(1,in_work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getPaymentMethod(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_payment_method_from_work_order(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet removePaymentMethodFromWorkOrder(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call remove_payment_method_from_work_order(?);");
			p_stmt.setInt(1,work_order);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem removing values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet savePaymentMethod(Integer work_order, Integer payment_method_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_payment_method("+work_order+","
					+payment_method_id+");");
			p_stmt=conn.prepareStatement("call save_payment_method(?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setInt(2,payment_method_id);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem saving values.");
			exc.printStackTrace();
		}
		return rs;
	}



	public ResultSet removeShimsfromSpec(Integer setting,String ref_table, String ref_spec) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call remove_shims_from_spec("+setting+","+
					ref_table+","+
					ref_spec+");");
			p_stmt=conn.prepareStatement("call remove_shims_from_spec(?,?,?);");
			p_stmt.setInt(1,setting);
			p_stmt.setString(2,ref_table);
			p_stmt.setString(3,ref_spec);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Remove_Shims_from_Spec:Problem removing values.");
			exc.printStackTrace();
		}
		return rs;
	}


	public ResultSet insertShimsIntoSpec(Integer setting_id,String ref_table, String ref_spec, Long spec_id,
			Integer pos, Double ID, Double Col_Width, Double Reb_Piston_Tower, Double Spring_Cup, int OD_is_DELTA,Double OD,
			Double Thickness, Integer Qty) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG2==1) System.out.println("call insert_shims_into_spec("+setting_id+ ","
					+ref_table+","
					+ref_spec+","
					+spec_id+","
					+pos+","
					+ID+","
					+Col_Width+","
					+Reb_Piston_Tower+","
					+Spring_Cup+","
					+OD_is_DELTA+","
					+OD+","
					+Thickness+","
					+Qty+");");
			p_stmt=conn.prepareStatement("call insert_shims_into_spec(?,?,?,?,?,?,?,?,?,?,?,?,?);");
			p_stmt.setInt(1,setting_id);
			p_stmt.setString(2,ref_table);
			p_stmt.setString(3,ref_spec);
			p_stmt.setLong(4,spec_id);
			p_stmt.setInt(5,pos);
			p_stmt.setDouble(6,ID);
			p_stmt.setDouble(7,Col_Width);
			p_stmt.setDouble(8,Reb_Piston_Tower);
			p_stmt.setDouble(9,Spring_Cup);
			p_stmt.setInt(10,OD_is_DELTA);
			p_stmt.setDouble(11,OD);
			p_stmt.setDouble(12,Thickness);
			p_stmt.setInt(13,Qty);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem Inserting Shims.");
			exc.printStackTrace();
		}
		return rs;
	}
	public ResultSet updateForkGeneralInfo(Long fork_spec_id, String the_info) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call update_fork_general_comments("+fork_spec_id+","
					+the_info+");");
			p_stmt=conn.prepareStatement("call update_fork_general_comments(?,?);");
			p_stmt.setLong(1,fork_spec_id);
			p_stmt.setString(2,the_info);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem updating fork general info.");
			exc.printStackTrace();
		}
		return rs;
	}
	public ResultSet updateShockGeneralInfo(Long shock_spec_id, String the_info) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call update_shock_general_comments("+shock_spec_id+","
					+the_info+");");
			p_stmt=conn.prepareStatement("call update_shock_general_comments(?,?);");
			p_stmt.setLong(1,shock_spec_id);
			p_stmt.setString(2,the_info);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem updating shock general info.");
			exc.printStackTrace();
		}
		return rs;
	}
	
	public ResultSet updateSupportComments(Integer work_order_id, String cust_comments,String tech_comments) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call update_support_comments("+work_order_id+","
					+cust_comments+","
					+tech_comments+");");
			p_stmt=conn.prepareStatement("call update_support_comments(?,?,?);");
			p_stmt.setInt(1,work_order_id);
			p_stmt.setString(2,cust_comments);
			p_stmt.setString(3,tech_comments);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem updating support comments.");
			exc.printStackTrace();
		}
		return rs;
	}


	public ResultSet saveForkComments(Integer setting_id,String new_comments) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_fork_comments("+setting_id+","
					+new_comments+");");
			p_stmt=conn.prepareStatement("call save_fork_comments(?,?);");
			p_stmt.setInt(1,setting_id);
			p_stmt.setString(2,new_comments);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem setting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveForkAdjustments(Integer setting_id,Double springs, Integer comp,
			Integer reb,Integer Oil_vol,Integer Oil_height, 
			String Oil_type,Integer spring_length,Integer chamber_length) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_fork_adjustments("
					+setting_id+","
					+springs+","
					+comp+","
					+reb+","
					+Oil_vol+","
					+Oil_height+","
					+Oil_type+","
					+spring_length+","
					+chamber_length+");");


			p_stmt=conn.prepareStatement("call save_fork_adjustments(?,?,?,?,?,?,?,?,?);");
			p_stmt.setInt(1,setting_id);
			p_stmt.setDouble(2,springs);
			p_stmt.setInt(3,comp);
			p_stmt.setInt(4,reb);
			p_stmt.setInt(5,Oil_vol);
			p_stmt.setInt(6,Oil_height);
			p_stmt.setString(7,Oil_type);
			p_stmt.setInt(8,spring_length);
			p_stmt.setInt(9,chamber_length);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem setting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveForkArrivalSettings(Integer setting_id, Integer leaking, Double spring,
			Integer comp,Integer reb,Integer Oil_vol, 
			Integer Oil_height, Integer spring_length,Integer chamber_length) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_fork_arrival_settings("+setting_id+","+
					+leaking+","
					+spring+","
					+comp+","
					+reb+","
					+Oil_vol+","
					+Oil_height+","
					+spring_length+","
					+chamber_length+");");

			p_stmt=conn.prepareStatement("call save_fork_arrival_settings(?,?,?,?,?,?,?,?,?);");
			p_stmt.setInt(1,setting_id);
			p_stmt.setInt(2,leaking);
			p_stmt.setDouble(3,spring);
			p_stmt.setInt(4,comp);
			p_stmt.setInt(5,reb);
			p_stmt.setInt(6,Oil_vol);
			p_stmt.setInt(7,Oil_height);
			p_stmt.setInt(8,spring_length);
			p_stmt.setInt(9,chamber_length);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem setting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveShockComments(Integer setting_id,String new_comments) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_shock_comments("+setting_id+","
					+new_comments+");");
			p_stmt=conn.prepareStatement("call save_shock_comments(?,?);");
			p_stmt.setInt(1,setting_id);
			p_stmt.setString(2,new_comments);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem setting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveShockAdjustments(Integer setting_id,Double springs, Integer LS_comp,
			String HS_comp_turns,Integer reb, String oil_type,
			Integer nitrogen, String z_cut, Integer sag) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_shock_adjustments("
					+setting_id+","
					+springs+","
					+LS_comp+","
					+HS_comp_turns+","
					+reb+","
					+oil_type+","
					+nitrogen+","
					+z_cut+","
					+sag+");");

			p_stmt=conn.prepareStatement("call save_shock_adjustments(?,?,?,?,?,?,?,?,?);");
			p_stmt.setInt(1,setting_id);
			p_stmt.setDouble(2,springs);
			p_stmt.setInt(3,LS_comp);
			p_stmt.setString(4,HS_comp_turns);
			p_stmt.setInt(5,reb);
			p_stmt.setString(6,oil_type);
			p_stmt.setInt(7,nitrogen);
			p_stmt.setString(8,z_cut);
			p_stmt.setInt(9,sag);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem setting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveShockArrivalSettings(Integer setting_id, Integer leaking, Double spring,
			Integer LS_comp, String HS_comp_turns, Integer reb, Integer compressed_length, Integer free_length) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_shock_arrival_settings("+setting_id+","
					+leaking+","
					+spring+","
					+LS_comp+","
					+HS_comp_turns+","
					+reb+","
					+compressed_length+","
					+free_length+");");

			p_stmt=conn.prepareStatement("call save_shock_arrival_settings(?,?,?,?,?,?,?,?);");
			p_stmt.setInt(1,setting_id);
			p_stmt.setInt(2,leaking);
			p_stmt.setDouble(3,spring);
			p_stmt.setInt(4,LS_comp);
			p_stmt.setString(5,HS_comp_turns);
			p_stmt.setInt(6,reb);
			p_stmt.setInt(7,compressed_length);
			p_stmt.setInt(8,free_length);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem setting values.");
			exc.printStackTrace();
		}
		return rs;
	}

//	---------------------------------------For Standard Work------------------------------------------
	public ResultSet removeStandardWorkFromWorkOrder(Integer work_order, String type) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call remove_standard_work_from_work_order("+work_order+","
					+type+");");
			p_stmt=conn.prepareStatement("call remove_standard_work_from_work_order(?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setString(2,type);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem removing values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveStandardWork(Integer work_order, String type,
			Integer product_id, String comments) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_standard_work("+work_order+","
					+type+","
					+product_id+","
					+comments+");");
			p_stmt=conn.prepareStatement("call save_standard_work(?,?,?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setString(2,type);
			p_stmt.setInt(3,product_id);
			p_stmt.setString(4,comments);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem saving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getForkStandardWork(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_fork_standard_work_from_work_order(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getShockStandardWorkFromWorkOrder(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shock_standard_work_from_work_order(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet addForkStandardWork(String new_service_desc) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call add_fork_standard_work("+new_service_desc+");");
			p_stmt=conn.prepareStatement("call add_fork_standard_work(?);");
			p_stmt.setString(1,new_service_desc);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet addShockStandardWork(String new_service_desc) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call add_shock_additional_service("+new_service_desc+");");
			p_stmt=conn.prepareStatement("call add_shock_standard_work(?);");
			p_stmt.setString(1,new_service_desc);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}
//	--------------------------------------------------------------------------------------------------



//	---------------------------------For Additional Services------------------------------------------
	public ResultSet removeAdditionalServicesFromWorkOrder(Integer work_order, String type) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call remove_additional_services_from_work_order("+work_order+","
					+type+");");
			p_stmt=conn.prepareStatement("call remove_additional_services_from_work_order(?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setString(2,type);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem removing values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveAdditionalServices(Integer work_order, String type,
			Integer product_id, String comments) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_additional_services("+work_order+","
					+type+","
					+product_id+","
					+comments+");");
			p_stmt=conn.prepareStatement("call save_additional_services(?,?,?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setString(2,type);
			p_stmt.setInt(3,product_id);
			p_stmt.setString(4,comments);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getForkAdditionalServices(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_fork_additional_services_from_work_order(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getShockAdditionalServices(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shock_additional_services_from_work_order(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}
//	--------------------------------------------------------------------------------------------------


//	---------------------------------For Additional Products------------------------------------------
	public ResultSet removeAdditionalProductsFromWorkOrder(Integer work_order_id, String type) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call remove_additional_products_from_work_order("+work_order_id+","
					+type+");");

			p_stmt=conn.prepareStatement("call remove_additional_products_from_work_order(?,?);");
			p_stmt.setInt(1,work_order_id);
			p_stmt.setString(2,type);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem removing values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveAdditionalProducts(Integer work_order_id, String type,
			Integer product_id, String comments) {
		PreparedStatement p_stmt;
		ResultSet rs=null;
		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_additional_products("+work_order_id+","
					+type+","
					+product_id+","
					+comments+");");
			p_stmt=conn.prepareStatement("call save_additional_products(?,?,?,?);");
			p_stmt.setInt(1,work_order_id);
			p_stmt.setString(2,type);
			p_stmt.setInt(3,product_id);
			p_stmt.setString(4,comments);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet addForkAdditionalProduct(String new_prod_desc) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call add_fork_additional_product("+new_prod_desc+");");
			p_stmt=conn.prepareStatement("call add_fork_additional_product(?);");
			p_stmt.setString(1,new_prod_desc);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet addShockAdditionalProduct(String new_prod_desc) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call add_shock_additional_product("+new_prod_desc+");");
			p_stmt=conn.prepareStatement("call add_shock_additional_product(?);");
			p_stmt.setString(1,new_prod_desc);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}


	public ResultSet getSettingsForkAdditionalProducts(Integer in_work_order_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_settings_fork_additional_products(?);");
			p_stmt.setInt(1,in_work_order_id);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getSettingsShockAdditionalProducts(Integer in_work_order_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_settings_shock_additional_products(?);");
			p_stmt.setInt(1,in_work_order_id);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet addForkAdditionalService(String new_service_desc) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call add_fork_additional_service("+new_service_desc+");");
			p_stmt=conn.prepareStatement("call add_fork_additional_service(?);");
			p_stmt.setString(1,new_service_desc);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet addShockAdditionalService(String new_service_desc) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call add_shock_additional_service("+new_service_desc+");");
			p_stmt=conn.prepareStatement("call add_shock_additional_service(?);");
			p_stmt.setString(1,new_service_desc);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}
//	-------------------------------------------------------------------------------------

	public ResultSet getOverallInfo(Integer work_order_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_overall_info(?);");
			p_stmt.setInt(1,work_order_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem getting overall info.");
			System.out.println(exc.toString());
		}
		return rs;
	}

	public ResultSet saveOverallInfo(Integer work_order_id,Integer OK_to_Replace,
			Integer OK_to_Replace_Bearing ,Integer Call_Prior_to_Work,
			Integer turn_around) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_overall_info("+work_order_id+","+OK_to_Replace+","+OK_to_Replace_Bearing+","+Call_Prior_to_Work+","+turn_around+");");
			p_stmt=conn.prepareStatement("call save_overall_info(?,?,?,?,?);");
			p_stmt.setInt(1,work_order_id);
			p_stmt.setInt(2,OK_to_Replace);
			p_stmt.setInt(3,OK_to_Replace_Bearing);
			p_stmt.setInt(4,Call_Prior_to_Work);
			p_stmt.setInt(5,turn_around);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem saving overall info.");
			System.out.println(exc.toString());
		}
		return rs;
	}



	public ResultSet findWorkOrders(Integer page,Integer rider_id, Integer year_id,
			Integer model_id, Integer ability_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call find_work_orders(?,?,?,?,?);");
			p_stmt.setInt(1,page);
			p_stmt.setInt(2,rider_id);
			p_stmt.setInt(3,year_id);
			p_stmt.setInt(4,model_id);
			p_stmt.setInt(5,ability_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem in Find_Work_Orders.");
			System.out.println(exc.toString());
		}
		return rs;
	}

	public ResultSet getNumberOfWorkOrders(Integer rider_id, Integer year_id,
			Integer model_id, Integer ability_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_number_of_work_orders(?,?,?,?);");
			p_stmt.setInt(1,rider_id);
			p_stmt.setInt(2,year_id);
			p_stmt.setInt(3,model_id);
			p_stmt.setInt(4,ability_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem in Find_Work_Orders_Count.");
			System.out.println(exc.toString());
		}
		return rs;
	}	
	
	public ResultSet getFinanceHeaderInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_finance_header_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveFinanceHeaderInfo(Integer work_order,
			String quote_num, String sales_num,
			String invoice_num) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1)
				System.out.println("call save_finance_header_info("+work_order+","+
						quote_num+","+
						sales_num+","+
						invoice_num+");");
			p_stmt=conn.prepareStatement("call save_finance_header_info(?,?,?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setString(2,quote_num);
			p_stmt.setString(3,sales_num);
			p_stmt.setString(4,invoice_num);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem with save_finance_header_info.");
			exc.printStackTrace();
		}
		return rs;
	}
	public ResultSet getShippingInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shipping_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveShippingInfo(Integer work_order,
			Integer ship_method){
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1)
				System.out.println("call save_shipping_info("+work_order+","+
						ship_method+");");
			p_stmt=conn.prepareStatement("call save_shipping_info(?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setInt(2,ship_method);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem with save_shipping_info.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getForkEstimateInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_fork_estimate_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getForkNeedSpringsInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_fork_need_springs_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveForkEstimate(Integer work_order,
			Double labor,
			String labor_discount,
			Double fluid,
			String fluid_discount,
			Double springs,
			String springs_discount,
			Double parts,
			String parts_discount,
			Double coatings,
			String coatings_discount,
			Double other,
			String other_discount,
			Integer Need_Springs,
			Double rate) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1)
				System.out.println("call save_fork_estimate("+work_order+","+
						labor+","+labor_discount+","+
						fluid+","+fluid_discount+","+
						springs+","+springs_discount+","+
						parts+","+parts_discount+","+
						coatings+","+coatings_discount+","+
						other+","+other_discount+","+
						Need_Springs+","+
						rate+");");
			p_stmt=conn.prepareStatement("call save_fork_estimate(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setDouble(2,labor);
			p_stmt.setString(3,labor_discount);
			p_stmt.setDouble(4,fluid);
			p_stmt.setString(5,fluid_discount);
			p_stmt.setDouble(6,springs);
			p_stmt.setString(7,springs_discount);
			p_stmt.setDouble(8,parts);
			p_stmt.setString(9,parts_discount);
			p_stmt.setDouble(10,coatings);
			p_stmt.setString(11,coatings_discount);
			p_stmt.setDouble(12,other);
			p_stmt.setString(13,other_discount);
			p_stmt.setInt(14,Need_Springs);
			p_stmt.setDouble(15,rate);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem with save_fork_estimate.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getShockEstimateInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shock_estimate_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getShockNeedSpringsInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shock_need_springs_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveShockEstimate(Integer work_order,
			Double labor,
			String labor_discount,
			Double fluid,
			String fluid_discount,
			Double springs,
			String springs_discount,
			Double parts,
			String parts_discount,
			Double coatings,
			String coatings_discount,
			Double other,
			String other_discount,
			Integer Need_Springs,
			Double rate) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1)
				System.out.println("call save_shock_estimate("+work_order+","+
						labor+","+labor_discount+","+
						fluid+","+fluid_discount+","+
						springs+","+springs_discount+","+
						parts+","+parts_discount+","+
						coatings+","+coatings_discount+","+
						other+","+other_discount+","+
						Need_Springs+","+
						rate+");");
			p_stmt=conn.prepareStatement("call save_shock_estimate(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setDouble(2,labor);
			p_stmt.setString(3,labor_discount);
			p_stmt.setDouble(4,fluid);
			p_stmt.setString(5,fluid_discount);
			p_stmt.setDouble(6,springs);
			p_stmt.setString(7,springs_discount);
			p_stmt.setDouble(8,parts);
			p_stmt.setString(9,parts_discount);
			p_stmt.setDouble(10,coatings);
			p_stmt.setString(11,coatings_discount);
			p_stmt.setDouble(12,other);
			p_stmt.setString(13,other_discount);
			p_stmt.setInt(14,Need_Springs);
			p_stmt.setDouble(15,rate);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem with save_shock_estimate.");
			exc.printStackTrace();
		}
		return rs;
	}


	public ResultSet getRidingType(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_riding_type(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet removeRidingTypesFromWorkOrder(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call remove_riding_types_from_work_order("+work_order+");");
			p_stmt=conn.prepareStatement("call remove_riding_types_from_work_order(?);");
			p_stmt.setInt(1,work_order);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem removing riding types.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveRidingTypes(Integer work_order, Integer riding_type_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_riding_types("+work_order+","+
					riding_type_id+");");
			p_stmt=conn.prepareStatement("call save_riding_types(?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setInt(2,riding_type_id);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem saving riding type.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getTerrain(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_terrain(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet removeTerrainFromWorkOrder(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call remove_terrain_from_work_order("+work_order+");");
			p_stmt=conn.prepareStatement("call remove_terrain_from_work_order(?);");
			p_stmt.setInt(1,work_order);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem removing terrain.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveTerrain(Integer work_order, Integer terrain_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_terrain("+work_order+","+
					terrain_id+");");
			p_stmt=conn.prepareStatement("call save_terrain(?,?);");
			p_stmt.setInt(1,work_order);
			p_stmt.setInt(2,terrain_id);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem saving terrain.");
			exc.printStackTrace();
		}
		return rs;
	}

/*	public Vector<String> getValidDates() {
		Vector<String> result=new Vector<String>();
		return result;
	}*/

	public ResultSet updateAddress(Integer rider, String phone1, String phone2,
										   String address1,String address2,String address3,
										   String city, String state, String country, String zip) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) 
				System.out.println("call update_address("+rider+","
														 +phone1+","
														 +phone2+","
														 +address1+","
														 +address2+","
														 +address3+","
														 +city+","
														 +state+","
														 +country
														 +");");
			p_stmt=conn.prepareStatement("call update_address(?,?,?,?,?,?,?,?,?,?);");
			p_stmt.setInt(1,rider);
			p_stmt.setString(2,phone1);
			p_stmt.setString(3,phone2);
			p_stmt.setString(4,address1);
			p_stmt.setString(5,address2);
			p_stmt.setString(6,address3);
			p_stmt.setString(7,city);
			p_stmt.setString(8,state);
			p_stmt.setString(9,country);
			p_stmt.setString(10,zip);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem updating address.");
			exc.printStackTrace();
		}
		return rs;

	}
	
	public ResultSet getWorkOrderInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_work_order_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with get_work_order_info.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getRiderAddressInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_rider_address_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with get_rider_address_info.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getShippingAddressInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shipping_address_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with get_shipping_address_info.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveShippingAddressInfo(Integer work_order_id, Integer use_rider_address, String phone1,
			String phone2, String address1, String address2,
			String address3, String city, String state,
			String country, String zip) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_shipping_address_info("+work_order_id+ ","+use_rider_address+ ","+phone1+
					","+phone2+ ","+address1+ ","+address2+
					","+address3+ ","+city+ ","+state+
					","+country+","+zip+");");
			p_stmt=conn.prepareStatement("call save_shipping_address_info(?,?,?,?,?,?,?,?,?,?,?);");
			p_stmt.setInt(1,work_order_id);
			p_stmt.setInt(2,use_rider_address);
			p_stmt.setString(3,phone1);
			p_stmt.setString(4,phone2);
			p_stmt.setString(5,address1);
			p_stmt.setString(6,address2);
			p_stmt.setString(7,address3);
			p_stmt.setString(8,city);
			p_stmt.setString(9,state);
			p_stmt.setString(10,country);
			p_stmt.setString(11,zip);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem saving shipping_acct_info.");
			System.out.println(exc.toString());
		}
		return rs;
	}

	public ResultSet getShippingAcctInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shipping_acct_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with get_shipping_acct_info.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveShippingAcctInfo(Integer work_order_id,Integer use_shipping_account,
			String shipping_vendor,String shipping_method_account) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_shipping_acct_info("+work_order_id+
					","+use_shipping_account+
					","+shipping_vendor+
					","+shipping_method_account+");");
			p_stmt=conn.prepareStatement("call save_shipping_acct_info(?,?,?,?);");
			p_stmt.setInt(1,work_order_id);
			p_stmt.setInt(2,use_shipping_account);
			p_stmt.setString(3,shipping_vendor);
			p_stmt.setString(4,shipping_method_account);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem saving shipping_acct_info.");
			System.out.println(exc.toString());
		}
		return rs;
	}

	public ResultSet getCreditCardInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_credit_card_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with get_credit_card_info.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveCreditCardInfo(Integer work_order_id, String name_on_card, String number_on_card,
			String security_code, String expiration) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_credit_card_info("+work_order_id+","+name_on_card+","+
					number_on_card+","+security_code+","+
					expiration+");");
			p_stmt=conn.prepareStatement("call save_credit_card_info(?,?,?,?,?);");
			p_stmt.setInt(1,work_order_id);
			p_stmt.setString(2,name_on_card);
			p_stmt.setString(3,number_on_card);
			p_stmt.setString(4,security_code);
			p_stmt.setString(5,expiration);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem saving credit_card_info.");
			System.out.println(exc.toString());
		}
		return rs;
	}

	public ResultSet getRiderSettingsInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_rider_settings_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with get_rider_settings_info.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveRiderSettingsInfo(Integer work_order_id,Integer rider_id, Integer ability_id,
			Integer weight_id, Integer height_id, Integer shop_id, Integer service_location_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_rider_settings_info("+work_order_id+","+rider_id+","+ability_id+
					","+weight_id+","+height_id+","+shop_id+","+service_location_id+");");
			p_stmt=conn.prepareStatement("call save_rider_settings_info(?,?,?,?,?,?,?);");
			p_stmt.setInt(1,work_order_id);
			p_stmt.setInt(2,rider_id);
			p_stmt.setInt(3,ability_id);
			p_stmt.setInt(4,weight_id);
			p_stmt.setInt(5,height_id);
			p_stmt.setInt(6,shop_id);
			p_stmt.setInt(7,service_location_id);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem saving rider settings info.");
			System.out.println(exc.toString());
		}
		return rs;
	}

	public ResultSet getBikeInfo(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_bike_info(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with get_rider_settings_info.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet saveBikeInfo(Integer work_order_id,Integer year_id, Integer model_id,
			Integer shock_brand_id, Integer fork_brand_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call save_bike_info("+work_order_id+","+year_id+
					","+model_id+","+shock_brand_id+
					","+fork_brand_id+");");
			p_stmt=conn.prepareStatement("call save_bike_info(?,?,?,?,?);");
			p_stmt.setInt(1,work_order_id);
			p_stmt.setInt(2,year_id);
			p_stmt.setInt(3,model_id);
			p_stmt.setInt(4,shock_brand_id);
			p_stmt.setInt(5,fork_brand_id);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem saving bike info.");
			System.out.println(exc.toString());
		}
		return rs;
	}

	public ResultSet getRiderInfo(Integer rider_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;
		try {
			p_stmt=conn.prepareStatement("call get_rider_info(?);");
			p_stmt.setInt(1,rider_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem getting values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public Vector<String> getForkSprings(Vector<Integer> ref) {
		PreparedStatement p_stmt;
		ResultSet rs=null;
		Vector<String> the_results=new Vector<String>();;

		try {
			p_stmt=conn.prepareStatement("call get_fork_springs();");
			rs=p_stmt.executeQuery();				

			if (rs.first()) {
				do
				{
					ref.add(rs.getInt("row_id")); //add the ids to the reference vector
					the_results.add(rs.getString("rate"));//add the values to the results vector
				}while (rs.next());
			}
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return the_results;
	}

	public Vector<String> getShockSprings(Vector<Integer> ref) {
		PreparedStatement p_stmt;
		ResultSet rs=null;
		Vector<String> the_results=new Vector<String>();;

		try {
			p_stmt=conn.prepareStatement("call get_shock_springs();");
			rs=p_stmt.executeQuery();				

			if (rs.first()) {
				do
				{
					ref.add(rs.getInt("row_id")); //add the ids to the reference vector
					the_results.add(rs.getString("rate"));//add the values to the results vector
				}while (rs.next());
			}
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return the_results;
	}


	public ResultSet  getArrivalSpecs(int setting_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_arrival_specs_for_setting(?);");
			p_stmt.setInt(1,setting_id);
			rs=p_stmt.executeQuery();	
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet  getShockForkSpecsForSetting(int setting_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;
		try {
			p_stmt=conn.prepareStatement("call get_shock_fork_specs_for_setting(?);");
			p_stmt.setInt(1,setting_id);
			
			rs=p_stmt.executeQuery();		
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getSupportComments(int work_order_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_support_comments(?);");
			p_stmt.setInt(1,work_order_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getForkGeneralInfo(Long fork_spec_id){
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_fork_general_info(?);");
			p_stmt.setLong(1,fork_spec_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
		
	}
	public ResultSet getShockGeneralInfo(Long shock_spec_id){
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shock_general_info(?);");
			p_stmt.setLong(1,shock_spec_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
		
	}
	
	public ResultSet getComments(int spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_comments(?);");
			p_stmt.setInt(1,spec_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getArrivalForkSpec(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_arrival_fork_spec(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getForkSpec(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_fork_spec(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getArrivalShockSpec(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_arrival_shock_spec(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getShockSpec(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shock_spec(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getShockCompShims(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shock_comp_shims(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getShockCompAdjShims(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shock_comp_adj_shims(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getShockRebShims(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_shock_reb_shims(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getForkCompShims(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_fork_comp_shims(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();					
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getForkLSVShims(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_fork_lsv_shims(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();					
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getForkRebShims(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_fork_reb_shims(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();			
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getForkBCVShims(Long spec_id) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_fork_bcv_shims(?);");
			p_stmt.setLong(1,spec_id);
			rs=p_stmt.executeQuery();			
		}catch (Exception exc) {
			System.out.println("Problem retrieving values.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet getRiderNames(){
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call get_rider_names();");
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem getting rider names.");
			exc.printStackTrace();
		}
		return rs;
	}

	
	public ResultSet addAddress(String address1, String address2, String address3, String city,
			String state_province, String country, String zip, String phone1, String phone2) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call add_address("+address1
					+","+address2
					+","+address3
					+","+city
					+","+state_province
					+","+country
					+","+zip
					+","+phone1
					+","+phone2
					+");");
			p_stmt=conn.prepareStatement("call add_address(?,?,?,?,?,?,?,?,?);");
			p_stmt.setString(1,address1);
			p_stmt.setString(2,address2);
			p_stmt.setString(3,address3);
			p_stmt.setString(4,city);
			p_stmt.setString(5,state_province);
			p_stmt.setString(6,country);
			p_stmt.setString(7,zip);
			p_stmt.setString(8,phone1);
			p_stmt.setString(9,phone2);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem adding address.");
			exc.printStackTrace();
		}
		return rs;
	}
	public ResultSet addRider(String first_name, String last_name, Integer address_ref){
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			if (Suspension_Notebook.DEBUG==1) System.out.println("call add_rider("+first_name
																			  +","+last_name
																			  +","+address_ref
																			  +");");
			p_stmt=conn.prepareStatement("call add_rider(?,?,?);");
			p_stmt.setString(1,first_name);
			p_stmt.setString(2,last_name);
			p_stmt.setInt(3,address_ref);
			
			if (Suspension_Notebook.DB_LOG==1)logPreparedStatement(p_stmt);
			rs=p_stmt.executeQuery();
			
		}catch (Exception exc) {
			System.out.println("Problem adding rider.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet insertOpenWorkOrder(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call insert_open_work_order(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with insert_open_work_order.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet deleteOpenWorkOrder(Integer work_order) {
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call delete_open_work_order(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with delete_open_work_order.");
			exc.printStackTrace();
		}
		return rs;
	}

	public ResultSet workOrderIsEditable(Integer work_order) {
		//resultset returns 1 if the work_order is already open
		//resultset returns 0 if the work_order is not already open
		PreparedStatement p_stmt;
		ResultSet rs=null;

		try {
			p_stmt=conn.prepareStatement("call work_order_is_editable(?);");
			p_stmt.setInt(1,work_order);
			rs=p_stmt.executeQuery();
		}catch (Exception exc) {
			System.out.println("Problem with work_order_is_open.");
			exc.printStackTrace();
		}
		return rs;
	}

}//end class DB_Calls
