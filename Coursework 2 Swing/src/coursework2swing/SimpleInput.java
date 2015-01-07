/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package coursework2swing;

/**
 *
 * @author Rayad
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.BorderFactory;
import javax.swing.GroupLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;
import javax.swing.SwingUtilities;

/**
 * Swing based application to show buttons and actions.  The application displays a string and a
 * button and when the button is pressed the string changes.
 *
 * @author Graham Roberts
 * @author Russel Winder
 * @version 2005-06-28
 */
public class SimpleInput extends JFrame
{
  /**
   * The current value of string displayed
   */
  private String message = "";
  private int count = 1;
  //  References to components used in interface.
  private JPanel backPanel;
  private JPanel topPanel;
  private JPanel bottomPanel;
  private JButton copyButton;
  private JLabel aLabel;
  private JTextField text;


  public SimpleInput()
  {
    super("SimpleInput");
    //  Create the main components first and then configure them.
    backPanel = new JPanel();
    topPanel = new JPanel();
    bottomPanel = new JPanel();
    copyButton = new JButton("Copy Text");
    aLabel = new JLabel("You Typed : ", SwingConstants.CENTER);
    text = new JTextField();
    text.setText(message);
    text.setColumns(20);
    //  Set the border around the widgets and
    //  set the layout manager -- the default is FlowLayout but we want to use
    //  BorderLayout. Then add the components in at the right section of the
    //  BorderLayout.
    backPanel.setBorder(BorderFactory.createEmptyBorder(20, 60, 20, 60));
    backPanel.setLayout(new BorderLayout());
    //  Use an anonymous inner class to create an action listener for the
    //  button.  Because the anonymous inner class has a connection to the
    //  HelloGoodbye object it can use references and methods in this
    //  method / object, i.e. it has access to the message and aLabel
    //  instance variables.


    copyButton.addActionListener(new ActionListener()
    {
      public void actionPerformed(ActionEvent e)
      {
          copy(e);
      }
    });



    //  Add the panel to the frame (window).
    add(backPanel);
    backPanel.add(topPanel, BorderLayout.NORTH);
    backPanel.add(bottomPanel, BorderLayout.SOUTH);
    topPanel.add(text,BorderLayout.WEST);
    topPanel.add(copyButton, BorderLayout.EAST);
    backPanel.add(aLabel, BorderLayout.CENTER);

    //  Set the ability to close the window and hence the
    //  application using the window managers close button, pack the components
    //  in the frame and finally display the frame.
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    pack();
    setVisible(true);
  }

  private void setLabelText()
  {
    aLabel.setText("You Typed : " + message);
  }


  void copy(ActionEvent e){
message = text.getText();
setLabelText();
  }

  public static void main(final String[] args)
  {
    SwingUtilities.invokeLater(new Runnable()
    {
      public void run()
      {
        new SimpleInput();
      }
    });
  }
}