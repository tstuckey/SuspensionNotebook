package utilities;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JDesktopPane;
import javax.swing.JInternalFrame;
import javax.swing.JPanel;
import javax.swing.event.InternalFrameEvent;
import javax.swing.event.InternalFrameListener;
import base.Settings_Frame;


public	class PrintDialogInternalFrame extends JInternalFrame 
                                          implements InternalFrameListener, ActionListener{
	JDesktopPane local_desktop;
	PrintStructure printing_choices;
	Settings_Frame sf;
	JInternalFrame local_frame;
	JPanel main_panel;
    Vector<JCheckBox> displayed_products;

	public PrintDialogInternalFrame(JDesktopPane desktop, Settings_Frame sf, PrintStructure printing_choices) {
		this.local_desktop=desktop;
		this.sf=sf;
		this.printing_choices=printing_choices;
		initializeClassVariables();
	}
	
	private void initializeClassVariables(){
		GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.CENTER;
        c.gridwidth=GridBagConstraints.REMAINDER;
        main_panel= initializeJPanel("Printing Choices");
    	JPanel check_box_panel=createPrintChoicesCheckBoxPanel();
    	JPanel buttons_panel=createButtonsPanel();
    	
    	main_panel.add(check_box_panel,c);
    	main_panel.add(buttons_panel,c);

		local_frame=new JInternalFrame("",true,true,true,true);        
        local_frame.add(main_panel);
		
		local_frame.pack();
		local_frame.setVisible(true);
		local_desktop.add(local_frame);
		local_desktop.getDesktopManager().activateFrame(local_frame);//make this the frame at the front
	}

    public JPanel initializeJPanel(String title) {
        JPanel t_panel=new JPanel();
        t_panel.setBorder( BorderFactory.createCompoundBorder(
                BorderFactory.createTitledBorder(title),
                BorderFactory.createEmptyBorder(0,0,0,0)));
        t_panel.setLayout(new GridBagLayout());
        return t_panel;
    }    

    private JPanel createPrintChoicesCheckBoxPanel() {
        JPanel check_box_panel=initializeJPanel("");
    	
    	GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.CENTER;
        
       
        displayed_products=new Vector<JCheckBox>();
        for (int i=0;i<printing_choices.printing_choices.size();i++) {
            JCheckBox t_checkbox=new JCheckBox(printing_choices.printing_choices.elementAt(i).label);
            displayed_products.add(t_checkbox);
            c.anchor=GridBagConstraints.NORTHWEST; 
            c.gridwidth=GridBagConstraints.REMAINDER;
            check_box_panel.add(t_checkbox,c);
        }//end for loop
        return check_box_panel;
    }

    private JPanel createButtonsPanel(){
        JPanel buttons_panel=initializeJPanel("");
    	
    	GridBagConstraints c = new GridBagConstraints();
        c.anchor=GridBagConstraints.NORTHWEST;
        
        JButton ok_button = new JButton("OK");
        ok_button.setActionCommand("ok_button_pressed");
        ok_button.addActionListener(this);
        c.gridwidth=GridBagConstraints.REMAINDER;
        c.insets=new Insets(0,0,5,0);
        buttons_panel.add(ok_button,c);
        
        JButton cancel_button = new JButton("Cancel");
        cancel_button.setActionCommand("cancel_button_pressed");
        cancel_button.addActionListener(this);
        c.gridwidth=GridBagConstraints.REMAINDER;
        c.insets=new Insets(0,0,5,0);
        buttons_panel.add(cancel_button,c);
       
        return buttons_panel;
    }
	
	private void changeAttributeAndHidePane() {
		local_frame.setVisible(false);
		local_desktop.remove(local_frame);
		local_desktop.repaint();
	}    
	
	@Override
	public void internalFrameActivated(InternalFrameEvent e) {
		// TODO Auto-generated method stub
		
	}

	public void internalFrameClosed(InternalFrameEvent e) {
	}

	@Override
	public void internalFrameClosing(InternalFrameEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void internalFrameDeactivated(InternalFrameEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void internalFrameDeiconified(InternalFrameEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void internalFrameIconified(InternalFrameEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void internalFrameOpened(InternalFrameEvent e) {
		// TODO Auto-generated method stub
		
	}
	
	/**This method receives a vector of the JCheckBoxes. For the JCheckBoxes that are selected,
	 * it pulls off the text and places it in a Vector of valid strings.
	 * 
	 * @param checkBoxValues
	 * @return valid Strings vector
	 */
	private Vector<String> getSelectedChoices(Vector<JCheckBox> checkBoxValues){
		Vector<String> result=new Vector<String>();
		for (int i=0; i<checkBoxValues.size();i++){
			if (checkBoxValues.elementAt(i).isSelected()){
				result.add(checkBoxValues.elementAt(i).getText());
			}
		}
		return result;
	}
	
	public void actionPerformed(ActionEvent e) {
		if ((e.getActionCommand()).equals("ok_button_pressed")) {
			changeAttributeAndHidePane();
			sf.processPrintingDecision(getSelectedChoices(displayed_products));
		}

		if ((e.getActionCommand()).equals("cancel_button_pressed")) {
			changeAttributeAndHidePane();
		}
	}

}

