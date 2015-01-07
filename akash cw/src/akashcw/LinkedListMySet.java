package akashcw;

import java.util.ArrayList;
import java.util.Iterator;

public class LinkedListMySet extends AbstractMySet
{
	private Node head;
	private Node node;
	private final int maxSize;
	
	private static class Node
	{
		public Object value;
		public Node next;
		
		public Node(Object value, Node next)
		{
			this.value = value;
			this.next = next;
		}
	}
	
	public void add(Object value)
	{
		if (!contains(value))
		{
			head = new Node(value,head);
		}
	}
	
	public int size()
	{
		int count = 0;
		Node position = head;
		while (position != null)
		{
			count++;
			position = position.next;
		}
		return count;
	}

	public boolean contains(Object obj)
	{
		return (find(obj) != null);
	}
	
	private Node find(Object obj)
	{
		Node position = head;
		Object itemAtPosition;
		while (position != null)
		{
			itemAtPosition = position.value;
			if (itemAtPosition.equals(obj))
			{
				return position;
			}
			position = position.next;
		}
		return null; //not found
	}
	
	/*--------------- to correct -------------*/
	public LinkedListMySet(int maxSize) throws MySetException
	{
		if ((maxSize < 1) || (maxSize > MAX_SIZE))
		{
			throw new
			MySetException("Attempting to create LinkedListMySet with size greater than MAX_SIZE");
		}
		//head = new Node;
		this.maxSize = maxSize;
	}
	
	public LinkedListMySet () throws  MySetException
	{
		this(MAX_SIZE);
	}
	/*--------------------------------------*/
	

	public void remove(Object obj)
	{
		node = head;
		Node temp;
		while (true)
		{
			temp = node;
			node = node.next;
			if (temp.equals(null))
			{ return; }

			if (temp.value.equals(obj))
			{ temp.next = node.next; }
		}
	}
	
	public boolean isEmpty()
	{ return head == null; }
		
	private class LinkListMySetIterator implements Iterator
	{
		private Node current = head;
		
		public boolean hasNext()
		{
			return current != null;
		}
		
		public Object next()
		{
			Object temp = null;
			if (current != null)
			{
				temp = current.value;
				current = current.next;
			}
			return temp;
		}
	
		public void remove()
		{ // do nothing
		}
	}
	
	public Iterator iterator()
	{ return new LinkListMySetIterator(); }
}