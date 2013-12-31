package base;
import javax.swing.BorderFactory;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.KeyboardFocusManager;


public class Comments {
    JTextArea textArea;
    JPanel parent_panel;
    JScrollPane areaScrollPane;
    
    public Comments(JPanel t_panel, String title,
            GridBagConstraints parent_c,String comments,String tip,String status, String space_size) {
        parent_panel=t_panel;
        textArea = initializeJTextArea(comments,space_size);
        textArea.setFont(new Font("Serif", Font.ITALIC, 12));
        textArea.setDisabledTextColor(Color.black);
        textArea.setLineWrap(true);
        textArea.setWrapStyleWord(true);
        if (tip != null)textArea.setToolTipText(tip);
        areaScrollPane = new JScrollPane(textArea);
        areaScrollPane.setVerticalScrollBarPolicy(
                JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
        Dimension d_size;
        if (space_size.contains("small")) d_size=new Dimension(350,90);
          else if (space_size.contains("XL")){
        	  d_size=new Dimension(1000,500);
        	  textArea.setFont(new Font("Serif", Font.ROMAN_BASELINE, 12));
          	}
             else d_size=new Dimension(400,200);
        areaScrollPane.setPreferredSize(d_size);
        areaScrollPane.setBorder(
                BorderFactory.createCompoundBorder(
                BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)),
                areaScrollPane.getBorder()));
        
        parent_panel.add(areaScrollPane,parent_c);
        if (status.equals("enabled")) {
            enableComponents();
        } else {
            disableComponents();
        }
    }
    public JTextArea initializeJTextArea(String comments, String space_size) {
        JTextArea ta = new JTextArea(comments);

        //don't change the focus manager for the ta if it is an XL box
        //this lets the users still be able to use the tab key
        if (!space_size.contains("XL")){
                ta.setFocusTraversalKeys(KeyboardFocusManager.FORWARD_TRAVERSAL_KEYS,null );
        		ta.setFocusTraversalKeys(KeyboardFocusManager.BACKWARD_TRAVERSAL_KEYS, null);      
        }
        return ta;
    } 
    
    public void refreshComments(String comments) {
        textArea.setText(comments);
    }
    
    public void disableComponents() {
        disableTextArea(textArea);
    }
    
    public void enableComponents() {
        enableTextArea(textArea);
    }
    
    private void enableTextArea(JTextArea ta) {
        ta.setEnabled(true);
        ta.setBackground(Color.white);
    }
    
    private void disableTextArea(JTextArea ta) {
        ta.setEnabled(false);
        ta.setBackground(Color.lightGray);
    }
    
}//end class Comments
