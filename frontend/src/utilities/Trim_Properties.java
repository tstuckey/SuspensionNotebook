package utilities;
import java.io.*;
import java.util.*;

import base.Suspension_Notebook;

public class Trim_Properties {
    public Trim_Properties(){
        Vector<String> the_content=new Vector<String>();
        try {
        	String file_name="DB_Props.properties";
        	BufferedReader input_file=new BufferedReader(new InputStreamReader(Suspension_Notebook.class.getResourceAsStream(file_name)));
      	
        	String entry=input_file.readLine();
            while (entry !=null) {
                the_content.add(entry.trim());
                entry=input_file.readLine();
            }
            input_file.close();
            BufferedWriter output_file=new BufferedWriter(new FileWriter(file_name));
            int count=0;
            while (count<the_content.size()) {
                output_file.write(the_content.elementAt(count));
                output_file.newLine();
                output_file.flush();
                count++;
            }
            output_file.close();
        }catch (Exception e) {
            System.out.println("Problem with file.");
            e.printStackTrace();
        }
        
    }
}//end class Trim_Properties
