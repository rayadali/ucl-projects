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
public class HelloGoodbye extends JFrame
{
  //  The two possible strings to display.
  private static final String HELLO = "Hello!";
  private static final String GOODBYE = "Goodbye!";
  /**
   * The current value of string displayed
   */
  private String message = HELLO;
  //  References to components used in interface.
  private final JPanel aPanel;
  private final JButton aButton;
  private final JLabel aLabel;

  public HelloGoodbye()
  {
    super("HelloGoodbye");
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
      public void actionPerformed(final ActionEvent e)
      {
        message = message.equals(HELLO) ? GOODBYE : HELLO;
        aLabel.setText(message);
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

  public static void main(final String[] args)
  {
    SwingUtilities.invokeLater(new Runnable()
    {
      public void run()
      {
        new HelloGoodbye();
      }
    });
  }
}