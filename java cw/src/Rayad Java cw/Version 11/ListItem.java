public class ListItem
{
  private String name;
  private String creationdate;
  private String completiondate;

  public ListItem(String name, String creationdate, String completiondate)
  {
    this.name = name;
    this.creationdate = creationdate;
    this.completiondate = completiondate;

  }

   public ListItem(String name, String completiondate)
  {
    this.name = name;
    this.completiondate = completiondate;

  }
     public ListItem(String name)
  {
    this.name = name;

  }
  public String getName()
  {
    return name;
  }

  public String getCreationDate()
  {
    return creationdate;
  }
  
  public String getCompletionDate()
  {
    return completiondate;
  }
}

