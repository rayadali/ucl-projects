package oldcw1;

/**
* This interface defines the public methods that a MySet factory must
* implement.
*/

public interface MySetFactory
{
	/**
	* Create a set that is an instance of the same class as the parameter object.
	* @param setClass A class object used to determine the class of the set
	* to instantiate.
	* @return The new set.
	* @throws MySetException If the class is not recognised as one from
	* which a set object can be created.
	*/
	
	public MySet getInstance(Class setClass) throws MySetException;
	
	/**
	* Create a set that is an instance of the same class as the parameter object,
	* with the given maximum set size.
	* @param setClass A class object used to determine the class of the set
	* to instantiate.
	* @param maxSize The maximum size of the new set.
	* @return The new set.
	* @throws MySetException If the class is not recognised as one from
	* which a set object can be created.
	*/
	
	public MySet getInstance(Class setClass, int maxSize) throws MySetException;
}