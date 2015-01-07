package oldcw1;

/**
* The default set factory. The getInstance method will return a new instance of
* the MySet implementation class determined by the class of the parameter.
*/

public class DefaultMySetFactory implements MySetFactory
{
	public MySet getInstance(Class setClass) throws MySetException
	{
		return getInstance(setClass, MySet.MAX_SIZE);
	}
	public MySet getInstance(Class setClass, int size) throws MySetException
	{
		if (setClass.equals(MapMySet.class))
		{
			return new MapMySet(size);
		}
		
		if (setClass.equals(ArrayMySet.class))
		{
			return new ArrayMySet(size);
		}
		
		if (setClass.equals(LinkedListMySet.class))
		{
			return new LinkedListMySet(size);
		}
		
		throw new MySetException
			("Attempting to use DefaultMySetFactory to create something that is not a MySet");
	}
}