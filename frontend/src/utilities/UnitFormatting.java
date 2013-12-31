package utilities;

import java.text.DecimalFormat;
import java.util.zip.DataFormatException;

public class UnitFormatting {
	public static String delta_annotation=" Delta";
	
	public static String width_measure=" mm";
	public static String length_measure=" mm";
	public static String rate_measure=" kg/mm";
	public static String vol_measure=" cc";
	public static String pressure_measure=" psi";
	
	public static Integer width_limit=100;
	public static Integer length_limit=1000;
	public static Integer rate_limit=10;
	public static Integer vol_limit=1000;
	public static Integer pressure_limit=1000;

	public static Integer estimate_limit=100000;
	public static Integer click_limit=50;
	public static Integer qty_limit=100;
	public static Integer str_length=5;
	public static Integer zcut_lenth=3;
	
	public static String replaceNulls(String input, String units, 
			                          Integer max_value, String type)throws DataFormatException {
		//handle both nulls and zero amounts as returns from the db
		if (input==null)return "";
		
		if (type.equals("Integer")){
			String str_int_val=genIntegerValue(input, units, max_value).toString();
			return str_int_val;
		}
		if (type.equals("Double")){
			String str_double_val=genDoubleValue(input,units,max_value);
			if (Math.abs(Double.valueOf(str_double_val))<=.0001 ) return "";
			else return (str_double_val+units);
		}
		return "";
	}  
	public static String replaceNulls(String input){
		//handle both nulls and zero amounts as returns from the db
		if (input==null)return "";
		else return input;
	}  
	
	public static String stripUnitsForCalculation(String whole_thing){
		if (whole_thing.contains(UnitFormatting.length_measure)){
		String numbers_only=null;
		//get the substring from the first position to the end minus the 3 characters for UnitFormatting.unit_measure
		numbers_only=whole_thing.substring(0, whole_thing.indexOf(UnitFormatting.length_measure));
		return numbers_only;
		}else return whole_thing;
	}

	public static String formatToThreePlaces(Double total) {
		DecimalFormat df = new DecimalFormat("###0.000");
		String result = df.format(total);
		return result;
	}
			
	public static String formatAsDouble(Double in_double,Integer max_value)throws DataFormatException{
		DecimalFormat df = new DecimalFormat("##0.000");
		String out_string=df.format(in_double);	
		
		//if the figure is in the double digits it is too long
		if (new Double(out_string)>=max_value){
			throw new DataFormatException("Too Long");
		}
		return out_string;
	}
	public static String formatAsDoubleMoney(Double in_double,Integer max_value)throws DataFormatException{
		DecimalFormat df = new DecimalFormat("##0.00");
		String out_string=df.format(in_double);	
		//if the figure is in the double digits it is too long
		if (new Double(out_string)>=max_value){
			throw new DataFormatException("Too Long");
		}
		return out_string;
	}
	public static Integer formatAsInteger(Integer in_integer, Integer max_value)throws DataFormatException{
		DecimalFormat df = new DecimalFormat("###");
		Integer out_integer=new Integer(df.format(in_integer));	
		//if the figure is in the triple digits it is too long
		if (out_integer>=max_value){
			throw new NumberFormatException("Too Large");
		}	
		return out_integer;	
	}
	
	public static String genDoubleValue(String strvalue, String unit, Integer max_value)throws DataFormatException{
		if ((strvalue==null)||(strvalue.equals(""))){
			return (new Double(0).toString());
		}
		//strip out the unit_measure if it is present
		if ((!unit.equals(""))&&strvalue.contains(unit)){
			strvalue=strvalue.substring(0,strvalue.indexOf(unit));
		}
		
		return (formatAsDouble(new Double(strvalue),max_value));
	}	

	public static String genDoubleValue_DELTA(String strvalue, String unit, Integer max_value)throws DataFormatException{
		//strip out everything after the delta
		String numeric_part=strvalue.substring(0,strvalue.indexOf(delta_annotation.trim().
																	toLowerCase()));
	
		//return a double of zero the numeric part is empty
		if ((numeric_part==null)||(numeric_part.equals(""))){
			return (new Double(0).toString());
		}
		return (formatAsDouble(new Double(numeric_part),max_value));
	}	
	
	
	
	public static String genDoubleValueMoney(String strvalue, String unit, Integer max_value)throws DataFormatException{
		if ((strvalue==null)||(strvalue.equals(""))){
			return (new Double(0).toString());
		}
		//strip out the unit_measure if it is present
		if ((!unit.equals(""))&&strvalue.contains(unit)){
			strvalue=strvalue.substring(0,strvalue.indexOf(unit));
		}
		return (formatAsDoubleMoney(new Double(strvalue),max_value));
	}	
	
	public static Integer genIntegerValue(String strvalue, String unit, Integer max_value)throws DataFormatException{
		if ((strvalue==null)||(strvalue.equals(""))){
			return (new Integer(0));
		}
		//strip out the unit_measure if it is present
		if ((!unit.equals(""))&&strvalue.contains(unit)){
			strvalue=strvalue.substring(0,strvalue.indexOf(unit));
		}
		return (formatAsInteger(new Integer(strvalue), max_value));
	}	

	public static String genStringValue(String strvalue, Integer max_length)throws DataFormatException{
		if ((strvalue==null)||(strvalue.equals(""))){
			return (new String(""));
		}
		
		if(strvalue.length()>=max_length){
			throw new DataFormatException("Too Long");
		}
		return strvalue;
	}
}
