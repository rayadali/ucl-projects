package akashcw;

/**
* This class implements methods common to all concrete set implementations
* but does not represent a complete set implementation.<br />
*
* New set objects are created using a Factory. By default a DefaultMySetFactory
* instance is used but this can be replaced with any factory implementing the
* MySetFactory interface.
*/

public abstract class AbstractMySet implements MySet
{
	private static MySetFactory factory = new DefaultMySetFactory();
	
	private void addAll(MySet source, MySet destination)
		throws MySetException
	{
		// Note the use of the enhanced for loop to iterate through a set.
		for (Object obj : source)
		{
			destination.add(obj);
		}
	}
	
	public MySet powerSet(MySet mySet) throws MySetException 
	{
		MySet result = getNewSetInstance(this);
		MySet input = this.union(mySet);

		int size = input.size(); // Size of Union

		Object[] newArray = new Object[size];
		
		int counter = 0;
		for (Object obj : input) {
			newArray[counter] = obj;
			counter++;
		}
		
		int newSize = (int)Math.pow(2, size);
		
		for (int a = 0; a < newSize; a++) 
		{
			MySet tmpSet = getNewSetInstance(this);
			
			String value = Integer.toBinaryString(a); // Converts the value into binary
			
	
			int valueSize = value.length(); // length of binary code
			
			
			if(valueSize < size)
			{
				int tmp = size - valueSize;
				switch(tmp){
					case 1: 
						String vb = "0";
						value = vb + value;
						break;
					case 2: 
						String vb1 = "00";
						value = vb1 + value;
						break;
					case 3: 
						String vb2 = "000";
						value = vb2 + value;
						break;
					default: 
				}
					
			}
			valueSize = value.length();
			
			for (int k = 0; k < valueSize; k++) {
				if (value.charAt(k) == '1') {
					tmpSet.add(newArray[k]);
				}
			}
			
			
			result.add(tmpSet);
			
		}
		return result;
	}

	
	public MySet union(MySet mySet) throws MySetException
	{
		MySet result = getNewSetInstance(this);
		addAll(this,result);
		addAll(mySet,result);
		return result;
	}
	
	public MySet intersection(MySet mySet) throws MySetException
	  {
		  MySet result = getNewSetInstance(this);
		  for (Object obj : mySet)
		  {
			if (this.contains(obj))
				result.add(obj);
		  }
		  return result;
	  }
	
	public MySet difference(MySet mySet) throws MySetException
	{
		MySet result = getNewSetInstance(this);
		for (Object obj : this)
		{
			if (!mySet.contains(obj))
				result.add(obj);
		}
		return result;
	}
	
	private MySet getNewSetInstance(MySet kind) throws MySetException
	{
		return factory.getInstance(kind.getClass());
	}
	
	/**
	* Set the factory to be used for set creation. Note this is a static
	* method so <em>all</em> set objects created from now on
	* will be created by the new factory.
	* @param aFactory The factory to use.
	*/
	
	public static void setFactory(MySetFactory aFactory)
	{
		factory = aFactory;
	}
}