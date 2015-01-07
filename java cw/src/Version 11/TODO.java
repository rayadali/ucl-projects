import java.util.*;
import java.io.PrintStream;


public class TODO
{
  private static final int DISPLAY_TODO_LIST = 1;
  private static final int ADD_LIST_ITEM = 2;
  private static final int REMOVE_LIST_ITEM = 3;
  private static final int EDIT_ITEM = 4;
  private static final int SAVE_LIST = 5;
  private static final int LOAD_LIST = 6;
  private static final int SEARCH_BY_KEYWORD = 7;
  private static final int SEARCH_BY_DATE = 8;
  private static final int QUIT = 9;

  // These two instance variables determine where input is read from
  // and where output is sent to.
  private Input in;
  private PrintStream out;

  // The menu used by an instance of this class.
  private List list;
  private Search search;

  public TODO(Input in, PrintStream out)
  {
    this.in = in;
    this.out = out;
    list = new List();
    search = new Search();
  }

  /**
   * The main loop of the program. Keep asking the user to enter
   * a command number until the user quits.
   */
  public void go()
  {
    while (true)
    {
      displayTODOMenu();
      int command = getCommand();
      if (quitSelected(command))
      {
        out.print("Goodbye!");
        break;
      }
      runCommand(command);
    }
  }

  private void displayTODOMenu()
  {
    out.println("\nTo Do List");
    out.println(DISPLAY_TODO_LIST + ". Display ToDo List");
 	out.println(ADD_LIST_ITEM + ". Add item to list");
 	out.println(REMOVE_LIST_ITEM + ". Remove item from list");
 	out.println(EDIT_ITEM + ". Edit item in list");
 	out.println(SAVE_LIST + ". Save ToDo List");
 	out.println(LOAD_LIST + ". Load ToDo List");
 	out.println(SEARCH_BY_KEYWORD + ". Search List by Keyword");
 	out.println(SEARCH_BY_DATE + ". Search List by Date");
 	out.println(QUIT + ". Quit");

    
  }

  private int getCommand()
  {
    return getInteger("\nEnter command: ");
  }

  private int getInteger(String message)
  {
    while (true)
    {
      out.println(message);
      if (in.hasNextInt())
      {
        int n = in.nextInt();
        in.nextLine();
        return n;
      }
      else
      {
        in.nextLine();
        out.println("Your input was not understood. Please try again.");
      }
    }
  }

  private boolean quitSelected(int n)
  {
    return (n == QUIT)? true : false;
  }

  private void runCommand(int item)
  {
    switch (item)
    {
      case DISPLAY_TODO_LIST:
        displayToDoList();
        break;
      case ADD_LIST_ITEM:
        addListItem();
        break;
      case REMOVE_LIST_ITEM:
        removeListItem();
        break;
      case EDIT_ITEM:
        editItem();
        break;
      case SAVE_LIST:
        saveList();
        break;
      case LOAD_LIST:
        loadList();
        break;
      case SEARCH_BY_KEYWORD:
        searchByKeyword();
        break;
      case SEARCH_BY_DATE:
        searchByDate();
        break;
      default:
        out.println("Not a valid command. Try again.");
    }
  }

  /**
   * Display the ToDo List.
   */
  private void displayToDoList()
  {
    out.println("To-Do List");
    out.println("--------------");
    ArrayList<ListItem> items = list.getListItems();
    for (int i = 0; i < items.size(); i++)
    {
      ListItem item = items.get(i);
      out.println((i + 1) + ". " + item.getName() + "\t\t"
                         + item.getCreationDate() + "\t\t"
                         + item.getCompletionDate());
    }
  }

  private void addListItem()
  {
    out.println("\nAdd List Item");
    out.print("Name Of What to do: ");
    String name = in.nextLine();
    out.print("Today's Date (DD-MM-YYYY): ");
    String creationdate = in.nextLine();
    out.print("Date to complete by (DD-MM-YYYY): ");
    String completiondate = in.nextLine();
    list.addItem(name, creationdate, completiondate);
  }

  private void removeListItem()
  {
    displayToDoList();
    ArrayList<ListItem> items = list.getListItems();
    int toRemove = getInteger("Enter number of list item to remove: ");
    if ((toRemove > 0) && (toRemove <= items.size()))
    {
      list.removeItem(toRemove - 1);
    }
    else
    {
      out.println("Invalid item number, nothing done");
    }
  }

  private void editItem()
  {
    displayToDoList();
    ArrayList<ListItem> items = list.getListItems();
    int edit = getInteger("Enter number of list item to edit: ");
    if ((edit > 0) && (edit <= items.size()))
    {
      out.print("Enter new name: ");
      String newName = in.nextLine();
      out.print("Enter new completion date (DD-MM-YYYY): ");
      String newCompletionDate = in.nextLine();
      list.editItem(edit - 1, newName, newCompletionDate);
    }
    else
    {
      out.println("Invalid item number, nothing done");
    }
  }

  private void saveList()
  {
    out.print("Enter file name: ");
    String fileName = in.nextLine();
    FileOutput output = new FileOutput(fileName);
    list.save(output);
    output.close();
  }

  private void loadList()
  {
    out.print("Enter file name: ");
    String fileName = in.nextLine();
    FileInput input = new FileInput(fileName);
    list.load(input);
    input.close();
  }
  private void searchByKeyword(){
  
	  out.print("Enter keyword/name of task to search for: ");
	  String word = in.nextLine();
	  search.word(word);
  }
  
  private void searchByDate()
  {
	  out.print("Enter keyword/name of task to search for: ");
	  String date = in.nextLine();
	  search.date(date);
}
}