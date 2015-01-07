package oldcw1;

/**
* This interface defines the public methods that all set classes have.
* The interface extends iterable to allow sets to be iterated using the
* for each loop.
*/

public interface MySet extends Iterable
{
	/**
	* The fixed maximum size of a set.
	*/
	
	static final int MAX_SIZE = 1000;
	
	/**
	* Add a value to a set.
	* @param obj The value to add.
	* @throws MySetException If the set is full.
	*/
	
	void add(Object obj) throws MySetException;
	
	/**
	* Check if the set contains a value.
	* @param obj The value to look for.
	* @return True if the set contains the value, false otherwise.
	*/
	
	boolean contains(Object obj);
	
	/**
	* Check if the set is empty.
	* @return True if the set is empty, false otherwise.
	*/
	
	boolean isEmpty();
	
	/**
	* Remove a value from the set. Do nothing if the value is not in the set.
	* @param obj The value to remove.
	*/
	
	void remove(Object obj);
	
	/**
	* Determine the size of the set (the numbers of values stored).
	* @return The size of the set.
	*/
	
	int size();
	
	/**
	* leaving the source sets unchanged.
	* @param mySet The set to form a union with.
	* @return A new set containing the union.
	* @throws MySetException If the resulting set is too big.
	*/
	
	MySet union(MySet mySet) throws MySetException;
	MySet intersection(MySet mySet) throws MySetException;
	MySet difference (MySet mySet) throws MySetException;
	MySet powerSet(MySet mySet) throws MySetException;
}