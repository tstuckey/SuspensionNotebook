package utilities;

import java.util.Vector;

/**This class defines the PrintStructure to facilitate user selection during printing.
 * Its constructor establishes the basic structure with the page titles and the corresponding
 * tab number; as the UI evolves, this class will need to be updated accordingly.
 * 
  */
public class PrintStructure {
	public Vector<printMap> printing_choices=new Vector<printMap>();
	
	public PrintStructure(){
		printing_choices.add(new printMap("General Info",0));
	    printing_choices.add(new printMap("Shock Info",1));
	    printing_choices.add(new printMap("Fork Info",2));
	    printing_choices.add(new printMap("Additional Products Info",3));	
	}
	
	class printMap{
		String label;
		int index;
		
		printMap(String t_label, int t_index){
			this.label=t_label;
			this.index=t_index;
		}	
	}

	/**This method receives a string value and evaluates it against the string values
	 * in the printing_choices.  If a match is found, it returns the tab index of that
	 * value in the printing_choices structure.
	 * 
	 * @param valueToCheck
	 * @return tab index of the valueToCheck
	 */
	public int getprintIndex(String valueToCheck){
		int result=-1;
		
		for (int i=0; i<printing_choices.size(); i++){
			if (printing_choices.elementAt(i).label.equals(valueToCheck)){
				return printing_choices.elementAt(i).index;
			}
		}
		
		return result;
	}
}
