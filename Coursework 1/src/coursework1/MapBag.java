/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


package coursework1;

import java.util.Iterator;
import java.util.HashMap;
public class MapBag extends AbstractBag
{
  private int maxSize;
  private HashMap<Object,Integer> contents;

  public MapBag() throws BagException
  {
    this(MAX_SIZE);
  }

  public MapBag(int maxSize) throws BagException
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
    this.contents = new HashMap<Object,Integer>();
  }

  public void add(Object object) throws BagException
  {
    if(contents.containsKey(object))
    {
        contents.put(object, contents.get(object) + 1);
    }
    if (contents.size() < maxSize)
    {
      contents.put(object, new Integer(1));
    }
    else
    {
      throw new BagException("Bag is full");
    }
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
      return contents.containsKey(object);
  }

  public int countOf(Object object)
  {
    if (contents.containsKey(object)) {
        return contents.get(object);
    }
    return 0;
  }

  public void remove(Object object)
  {
  if (contents.containsKey(object))
  {
      if (contents.get(object) > 1)
      {
      int temp = contents.get(object);
      temp--;
      contents.remove(object);
      contents.put(object, temp);
      }
      else {
          contents.remove(object);
      }
  }
  }

  public boolean isEmpty()
  {
    return contents.isEmpty();
  }

  public int size()
  {
    return contents.size();
  }

  private class MapBagIterator implements Iterator
  {
    private int index = 0;
    private int count = 0;


    public boolean hasNext()
    {
      Object[] list = contents.keySet().toArray();
      if (index < contents.size())
      {
        if (count < contents.get(list[index])) return true;
        if ((count == contents.get(list[index])) && ((index + 1) < contents.size())) return true;
      }
      return false;
    }

    public Object next()
    {
      Object[] list = contents.keySet().toArray();
      if (count < contents.get(list[index]))
      {
        Object key = list[index];
        count++;
        return key;
      }
      count = 0;
      index++;
      return list[index];
    }

    public void remove()
    {
    }
  }

  public Iterator iterator()
  {
    return new MapBagIterator();
  }
}
