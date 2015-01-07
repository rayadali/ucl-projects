package coursework1;

import java.util.Iterator;
import java.util.ArrayList;
public class ArrayBag extends AbstractBag
{
	private static class Element
	{
		public int count;
		public Object value;
		public Element(int count, Object object)
		{
			this.count = count;
			this.value = object;
		}
	}
	private int maxSize;
	private ArrayList<Element> contents;
	public ArrayBag() throws BagException
	{
		this(MAX_SIZE);
	}
	public ArrayBag(int maxSize) throws BagException
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
		this.contents = new ArrayList<Element>();
	}
	public void add(Object object) throws BagException
	{
		for (Element element : contents)
		{
			if (element.value.equals(object))
			{
				element.count++;
				return;
			}
		}
		if (contents.size() < maxSize)
		{
			contents.add(new Element(1,object));
		}
		else
		{
			throw new BagException("Bag is full");
		}
	}
	public void addWithOccurrences(Object object, int occurrences) throws
	BagException
	{
		for (int i = 0 ; i < occurrences ; i++)
		{
			add(object);
		}
	}
	public boolean contains(Object object)
	{
		for (Element element : contents)
		{
			if (element.value.equals(object))
			{
				return true;
			}
		}
		return false;
	}
	public int countOf(Object object)
	{
		for (Element element : contents)
		{
			if (element.value.equals(object))
			{
				return element.count;
			}
		}
		return 0;
	}
	public void remove(Object object)
	{
		for (int i = 0 ; i < contents.size() ; i++)
		{
			Element element = contents.get(i);
			if (element.value.equals(object))
			{
				element.count--;
				if (element.count == 0)
				{
					contents.remove(element);
					return;
				}
			}
		}
	}
	public boolean isEmpty()
	{
		return contents.size() == 0;
	}
	public int size()
	{
		return contents.size();
	}
	private class ArrayBagIterator implements Iterator
	{
		private int index = 0;
		private int count = 0;
		public boolean hasNext()
		{
			if (index < contents.size()) {
				if (count < contents.get(index).count) return true;
				if ((count == contents.get(index).count) && ((index + 1) < contents.size
						())) return true;
			}
			return false;
		}
		public Object next()
		{
			if (count < contents.get(index).count)
			{
				Object value = contents.get(index).value;
				count++;
				return value;
			}
			count = 1;
			index++;
			return contents.get(index).value;
		}
		public void remove()
		{
		}
	}
	public Iterator iterator()
	{
		return new ArrayBagIterator();
	}
}
