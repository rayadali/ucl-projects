package emmaswing;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import javax.swing.BorderFactory;
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
public class TextCopy extends JFrame
{


  private String message = "You Inputted : ";
  //  References to components used in interface.
  private final JPanel backgroundPanel;
  private final JPanel topPanel;
  private final JPanel bottomPanel;
  private final JButton aButton;
  private final JLabel aLabel;
  private final JTextField aTextField;

  public TextCopy()
  {
    super("TextCopy");
    //  Create the main components first and then configure them.
    backgroundPanel = new JPanel();
    topPanel = new JPanel();
    bottomPanel = new JPanel();
    aButton = new JButton("Click Me");
    aLabel = new JLabel(message, SwingConstants.CENTER);
    aTextField = new JTextField();
    aTextField.setColumns(10);
    //  Set the border around the widgets and
    //  set the layout manager -- the default is FlowLayout but we want to use
    //  BorderLayout. Then add the components in at the right section of the
    //  BorderLayout.
    backgroundPanel.setBorder(BorderFactory.createEmptyBorder(20, 60, 20, 60));
    backgroundPanel.setLayout(new BorderLayout());
    backgroundPanel.add(topPanel, BorderLayout.NORTH);
    backgroundPanel.add(bottomPanel, BorderLayout.SOUTH);
    topPanel.add(aTextField, BorderLayout.WEST);
    topPanel.add(aButton, BorderLayout.EAST);
    bottomPanel.add(aLabel, BorderLayout.CENTER);
    //  Use an anonymous inner class to create an action listener for the
    //  button.  Because the anonymous inner class has a connection to the
    //  HelloGoodbye object it can use references and methods in this
    //  method / object, i.e. it has access to the message and aLabel
    //  instance variables.

    
    aButton.addActionListener(new ActionListener()
    {
      public void actionPerformed(final ActionEvent e)
      {
          message = aTextField.getText();
          aLabel.setText("You Input : " + message);
        }
      });
     
    //  Add the panel to the frame (window).
    add(backgroundPanel);
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
        new TextCopy();
      }
    });
  }
}
