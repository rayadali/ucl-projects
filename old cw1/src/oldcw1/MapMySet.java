package oldcw1;

import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

/**
* A set implementation using a HashMap to store the set contents.
* <br />
* Objects representing values stored in a set are compared using the equals
* method, so the object classes must correctly implement equals.
*/

public class MapMySet extends AbstractMySet
{
	private Map contents;
	private final int maxSize;
	
	public MapMySet() throws MySetException
	{
		this(MAX_SIZE);
	}
	
	public MapMySet(int maxSize) throws MySetException
	{
		if ((maxSize < 1) || (maxSize > MAX_SIZE))
		{
			throw new
			MySetException("Attempting to create MapMySet with size greater than MAX_SIZE");
		}
		contents = new HashMap();
		this.maxSize = maxSize;
	}
	
	@SuppressWarnings("unchecked")
	public void add(Object obj) throws MySetException
	{
		if (maxSize == contents.size())
		{
			throw new MySetException("Attempting to add to full MySet");
		}
		contents.put(obj,null);
	}
		
	public boolean contains(Object obj)
	{
			return contents.containsKey(obj);
	}
	
	public boolean isEmpty()
	{
		return contents.isEmpty();
	}
	
	public void remove(Object obj)
	{
		contents.remove(obj);
	}
	
	public int size()
	{
		return contents.size();
	}
	
	public Iterator iterator()
	{
		return new MapMySetIterator();
	}
	
	private class MapMySetIterator implements Iterator
	{
		Set keys = contents.keySet();
		Iterator iter = keys.iterator();
		
		public boolean hasNext()
		{
			return iter.hasNext();
		}
		
		public Object next()
		{
			return iter.next();
		}
		
		public void remove()
		{
			// Do nothing
		}
	}
}
