/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package coursework1;

import java.util.Iterator;

public class LinkedListBag extends AbstractBag
{
    private static class Node
{
    public Object value;
    public int occurrences;
    public Node next;
    public Node(Object value, int occurrences, Node next)
    {
    this.value = value;
    this.occurrences = occurrences;
    this.next = next;
    }
    }
  private int maxSize;
  private Node startnode;

  public LinkedListBag() throws BagException
  {
    this(MAX_SIZE);
  }

  public LinkedListBag(int maxSize) throws BagException
  {
    if (maxSize > MAX_SIZE)
    {
      throw new BagException("Attempting to create a Bag with size greater than maximum");
    }
    if (maxSize < 1)
    {
      throw new BagException("Attempting to create a Bag with size less than 1");
    }
    this.maxSize = maxSize;
    startnode = new Node("start", 0, null);
  }

  public void add(Object object) throws BagException
  {
    Node nextnode = startnode.next;
    Node currentnode = startnode;
    while(!(nextnode == null))
    {
      if(nextnode.value.equals(object))
      {
          int nodeplus =nextnode.occurrences;
          nodeplus++;
          nextnode.occurrences = nodeplus;
          return;
      }
      currentnode = nextnode;
      nextnode = nextnode.next;
    }
      nextnode = new Node(object, 1, null);
      currentnode.next = nextnode;
   
  }

  public void addWithOccurrences(Object object, int occurrences) throws BagException
  {
    for (int i = 0 ; i < occurrences ; i++)
    {
      add(object);
    }
  }

  public boolean contains(Object object)
  {
      Node nextnode = startnode.next;
   while(!nextnode.equals(null))
    {
      if(nextnode.equals(object)) return true;
      nextnode = nextnode.next;
    }
      return false;
  }

  public int countOf(Object object)
  {
    Node currentnode = startnode;
   while(!(currentnode == null))
   {
       if (currentnode.value.equals(object))
       {
           return currentnode.occurrences;
       }
      currentnode = currentnode.next;
  }
    return 0;
  }

  public void remove(Object object)
  {
    Node nextnode = startnode.next;
    Node currentnode = startnode;
    if (this.countOf(object) == 0)return;

    while(!(nextnode == null))
    {
        if(nextnode.value.equals(object))
        {
            if (nextnode.occurrences > 1)
            {
                nextnode.occurrences--;
                return;

            }
            else currentnode.next = nextnode.next;
        }
        currentnode = nextnode;
        nextnode = nextnode.next;


    }
  }

  public boolean isEmpty()
  {
    return startnode.equals(null);
  }

  public int size()
  {
    Node nextnode = startnode.next;
    int count = 0;
    while(!nextnode.equals(null))
    {
        count++;
    }
    return count;
  }

private class LinkedListBagIterator implements Iterator
  {
    private Node nextnode = startnode;
    private int occurrences = 1;


    public boolean hasNext()
    {

        if(nextnode.next != null)
        {
            return true;
        }

        if(occurrences < nextnode.occurrences)
        {
            return true;
        }
        return false;

    }

    public Object next()
    {

        if(occurrences < nextnode.occurrences)
        {
            occurrences++;

            return nextnode.value;
        }

        occurrences = 1;
        nextnode = nextnode.next;
        return nextnode.value;
    }

    public void remove()
    {
    }
  }

  public Iterator iterator()
  {
    return new LinkedListBagIterator();
  }
}
