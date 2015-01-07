import java.util.ArrayList;

public class List
{
  private ArrayList<ListItem> list;

  public List()
  {
   list = new ArrayList<ListItem>();
  }

  public ArrayList<ListItem> getListItems()
  {
    return list;
  }

  public void addItem(String name, String creationdate, String completiondate)
  {
    list.add(new ListItem(name, creationdate, completiondate));
  }

  public void removeItem(int n)
  {
    list.remove(n);
  }

  public void editItem(int n, String name, String completiondate)
  {
    ListItem newItem = new ListItem(name, completiondate);
    list.set(n, newItem);
  }

  public void save(FileOutput out)
  {
    for (int i = 0; i < list.size(); i++)
    {
      ListItem item = list.get(i);
      out.writeString(item.getName());
      out.writeEndOfLine();
      out.writeString(item.getCreationDate());
      out.writeEndOfLine();
      out.writeString(item.getCompletionDate());
      out.writeEndOfLine();
    }
  }

  public void load(FileInput in)
  {
    list = new ArrayList<ListItem>();
    while (in.hasNextLine())
    {
      String name = in.nextLine();
      String creationdate = in.nextLine();
      String completiondate = in.nextLine();
      list.add(new ListItem(name, creationdate, completiondate));
    }
  }
}


