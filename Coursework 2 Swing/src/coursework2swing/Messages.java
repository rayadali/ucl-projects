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
import java.awt.FlowLayout;
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
public class Messages extends JFrame
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
  private JPanel labelPanel;
  private JPanel buttonPanel;
  private JButton prevButton;
  private JButton nextButton;
  private JLabel aLabel;


  public Messages()
  {
    super("Messages");
    //  Create the main components first and then configure them.
    labelPanel = new JPanel();
    buttonPanel = new JPanel();
    prevButton = new JButton("Previous Message");
    nextButton = new JButton("Next Message");
    aLabel = new JLabel(message, SwingConstants.CENTER);
    FlowLayout flow = new FlowLayout();
    buttonPanel.setLayout(flow);
    flow.setAlignment(FlowLayout.CENTER);
    nextButton.addActionListener(new ActionListener()
    {
      public void actionPerformed(ActionEvent e)
      {
          countup(e);
      }
    });
    prevButton.addActionListener(new ActionListener()
    {
      public void actionPerformed(ActionEvent e)
      {
          countdown(e);
      }
    });


    //  Add the panel to the frame (window).
    add(labelPanel, BorderLayout.CENTER);
    add(buttonPanel, BorderLayout.SOUTH);
    labelPanel.add(aLabel);
    buttonPanel.add(prevButton);
    buttonPanel.add(nextButton);

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


  void countup(ActionEvent e){
           switch(count){
         case 1 : message = HELLO2; count = 2; setLabelText(); break;
         case 2 : message = HELLO3; count = 3; setLabelText(); break;
         case 3 : message = HELLO4; count = 4; setLabelText(); break;
         case 4 : message = HELLO5; count = 5; setLabelText(); break;
         case 5 : message = HELLO1; count = 1; setLabelText(); break;
         default : System.out.print(""); break;
     }

  }

    void countdown(ActionEvent e){
           switch(count){
         case 1 : message = HELLO5; count = 5; setLabelText(); break;
         case 2 : message = HELLO1; count = 1; setLabelText(); break;
         case 3 : message = HELLO2; count = 2; setLabelText(); break;
         case 4 : message = HELLO3; count = 3; setLabelText(); break;
         case 5 : message = HELLO4; count = 4; setLabelText(); break;
         default : System.out.print(""); break;
     }

  }

  public static void main(final String[] args)
  {
    SwingUtilities.invokeLater(new Runnable()
    {
      public void run()
      {
        new Messages();
      }
    });
  }
}