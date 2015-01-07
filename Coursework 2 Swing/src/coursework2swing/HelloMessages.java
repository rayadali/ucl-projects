/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package coursework2swing;

/**
 *
 * @author Rayad
 */
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
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
public class HelloMessages extends JFrame
{
  private String HELLO1 = "Hello!";
  private String HELLO2 = "Salut!";
  private String HELLO3 = "Hallo!";
  private String HELLO4 = "Buon giorno!";
  private String HELLO5 = "Konnichi wa!";
  /**
   * The current value of string displayed
   */
  private String message = HELLO1;
  private int count = 1;
  //  References to components used in interface.
  private JPanel aPanel;
  private JButton aButton;
  private JLabel aLabel;

  public HelloMessages()
  {
    super("HelloMessages");
    //  Create the main components first and then configure them.
    aPanel = new JPanel();
    aButton = new JButton("Click Me");
    aLabel = new JLabel(message, SwingConstants.CENTER);
    //  Set the border around the widgets and
    //  set the layout manager -- the default is FlowLayout but we want to use
    //  BorderLayout. Then add the components in at the right section of the
    //  BorderLayout.
    aPanel.setBorder(BorderFactory.createEmptyBorder(20, 60, 20, 60));
    aPanel.setLayout(new BorderLayout());
    aPanel.add(aLabel, BorderLayout.CENTER);
    aPanel.add(aButton, BorderLayout.SOUTH);
    //  Use an anonymous inner class to create an action listener for the
    //  button.  Because the anonymous inner class has a connection to the
    //  HelloGoodbye object it can use references and methods in this
    //  method / object, i.e. it has access to the message and aLabel
    //  instance variables.


    aButton.addActionListener(new ActionListener()
    {
      public void actionPerformed(ActionEvent e)
      {
          count(e);
      }
    });


    //  Add the panel to the frame (window).
    add(aPanel);
    //  Set the ability to close the window and hence the
    //  application using the window managers close button, pack the components
    //  in the frame and finally display the frame.
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    pack();
    setVisible(true);
  }

  private void setLabelText()
  {
    aLabel.setText(message);
  }


  void count(ActionEvent e){
           switch(count){
         case 1 : message = HELLO2; count = 2; setLabelText(); break;
         case 2 : message = HELLO3; count = 3; setLabelText(); break;
         case 3 : message = HELLO4; count = 4; setLabelText(); break;
         case 4 : message = HELLO5; count = 5; setLabelText(); break;
         case 5 : message = HELLO1; count = 1; setLabelText(); break;
         default : System.out.print(""); break;
     }

  }

  public static void main(final String[] args)
  {
    SwingUtilities.invokeLater(new Runnable()
    {
      public void run()
      {
        new HelloMessages();
      }
    });
  }
}