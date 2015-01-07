package akashcw;

import java.util.ArrayList;
import java.util.Iterator;

public class ArrayMySet extends AbstractMySet
{
	private ArrayList contents;
	private final int maxSize;
	
	public ArrayMySet() throws MySetException
	{
		this(MAX_SIZE);
	}
	
	public ArrayMySet(int maxSize) throws MySetException
	{
		if ((maxSize < 1) || (maxSize > MAX_SIZE))
		{
			throw new
			MySetException("Attempting to create MapMySet with size greater than MAX_SIZE");
		}
		contents = new ArrayList();
		this.maxSize = maxSize;
	}
	
	@SuppressWarnings("unchecked")
	public void add(Object obj) throws MySetException
	{
		if (maxSize == contents.size())
		{
			throw new MySetException("Attempting to add to full MySet");
		}
		if (!contents.contains(obj))
		{
			contents.add(obj);	
		}
	}
		
	public boolean contains(Object obj)
	{
			return contents.contains(obj);
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
		return new ArrayMySetIterator();
	}
	
	private class ArrayMySetIterator implements Iterator
	{
		Iterator iter = contents.iterator();
		
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