/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package coursework2swing;

/**
 *
 * @author Rayad
 */

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JTextArea;

public class ContactForm extends JFrame
{
  private JPanel backPanel = new JPanel();
  private JPanel namePanel = new JPanel();
  private JPanel phonePanel = new JPanel();
  private JPanel mobilePanel = new JPanel();
  private JPanel emailPanel = new JPanel();
  private JPanel buttonPanel = new JPanel();
  private JTextField nameTF = new JTextField();
  private JTextField phoneTF = new JTextField();
  private JTextField mobileTF = new JTextField();
  private JTextField emailTF = new JTextField();
  private JLabel nameLabel = new JLabel();
  private JLabel phoneLabel = new JLabel();
  private JLabel mobileLabel = new JLabel();
  private JLabel emailLabel = new JLabel();
  private JButton clearButton = new JButton();
  private JButton acceptButton = new JButton();
  private JFrame newFrame = new JFrame("Contact");
  private JTextArea newTextArea = new JTextArea();
  private final static String newline = "\n";

  public ContactForm()
  {
    super("Contact Form");
    createForm();
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    pack();
    setVisible(true);
  }

  private void createForm()
  {
    GridLayout grid = new GridLayout();
    backPanel.setLayout(grid);
    backPanel.setBorder(BorderFactory.createEmptyBorder(30, 80, 30, 80));
    grid.setRows(5);
    grid.setColumns(1);
    FlowLayout flow = new FlowLayout();
    namePanel.setLayout(flow);
    flow.setAlignment(FlowLayout.LEFT);
    phonePanel.setLayout(flow);
    flow.setAlignment(FlowLayout.LEFT);
    mobilePanel.setLayout(flow);
    flow.setAlignment(FlowLayout.LEFT);
    emailPanel.setLayout(flow);
    flow.setAlignment(FlowLayout.LEFT);
    nameLabel.setText("  Name:");
    phoneLabel.setText(" Phone:");
    mobileLabel.setText(" Mobile:");
    emailLabel.setText("   Email:");
    acceptButton.setText("Accept");
    nameTF.setColumns(30);
    phoneTF.setColumns(30);
    mobileTF.setColumns(30);
    emailTF.setColumns(30);
    acceptButton.addActionListener(new ActionListener()
    {
      public void actionPerformed(ActionEvent e)
      {
        addButtonClicked();
      }
    });
    clearButton.setText("Clear");
    clearButton.addActionListener(new ActionListener()
    {
      public void actionPerformed(ActionEvent e)
      {
        clearButtonClicked();
      }
    });
    add(backPanel, BorderLayout.CENTER);
    backPanel.add(namePanel);
    namePanel.add(nameLabel);
    namePanel.add(nameTF);
    backPanel.add(phonePanel);
    phonePanel.add(phoneLabel);
    phonePanel.add(phoneTF);
    backPanel.add(mobilePanel);
    mobilePanel.add(mobileLabel);
    mobilePanel.add(mobileTF);
    backPanel.add(emailPanel);
    emailPanel.add(emailLabel);
    emailPanel.add(emailTF);
    backPanel.add(buttonPanel, BorderLayout.SOUTH);
    buttonPanel.add(clearButton);
    buttonPanel.add(acceptButton);
  }

  private void addButtonClicked()
  {
      createNewWindow();
  }

  private void clearButtonClicked()
  {
    nameTF.setText("");
    phoneTF.setText("");
    mobileTF.setText("");
    emailTF.setText("");
  }

  private void createNewWindow(){
      newTextArea.setText(nameTF.getText() + newline + phoneTF.getText() + newline + mobileTF.getText() + newline + emailTF.getText());
      newFrame.add(newTextArea);
      newTextArea.setColumns(50);
      newTextArea.setRows(10);
      newTextArea.setEditable(false);
      newFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      newFrame.pack();
      newFrame.setVisible(true);
  }

  public static void main(String[] args)
  {
    SwingUtilities.invokeLater(new Runnable()
    {
      public void run()
      {
        new ContactForm();
      }
    });
  }
}