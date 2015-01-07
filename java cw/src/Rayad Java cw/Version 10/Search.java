import java.io.PrintStream;
import java.util.ArrayList;


public class Search 
{
	private List list;
	private Input in;
	private PrintStream out;
	private Search search;
	
	 public Search ()
	  {
	   //search = new Search();
	  }


	public void date(String date )
	{
		  
		  ArrayList<ListItem> items = list.getListItems();
		  int index = 1;
		  boolean found = false;
		  while(index < items.size() && !found) 
		  {
			  ListItem item = items.get(index);
			  if (item.getCreationDate().contains(date)) 
			  {
				  found = true;
				  System.out.println("found: " + date +" at " + index);
			  }
			  else 
			  {
				  index = index + 3;
				  System.out.println("Search term not found");
			  }
		  }	
	  }
	public void word(String word)
	{
		  
		  ArrayList<ListItem> items = list.getListItems();
		  int index = 0;
		  boolean found = false;
		  while(index < items.size() && !found) 
		  {
			  ListItem item = items.get(index);
			  if (item.getCreationDate().contains(word)) 
			  {
				  found = true;
				  System.out.println("found: " + word +" at " + index);
			  }
			  else 
			  {
				  index = index + 3;
				  System.out.println("Search term not found");
			  }
		  }	
	  }
}