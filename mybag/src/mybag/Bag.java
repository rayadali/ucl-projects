package mybag;


public interface Bag extends Iterable {
	/**
	* The fixed maximum size of a bag.
	* This determines the maximum number of distinct values that can
	* be stored in a bag, not the number of occurrences of each value.
	*/
	static final int MAX_SIZE = 1000;
	/**
	* Add a value to a bag.
	* @param object The value to add.
	* @throws BagException If the bag is full.
	*/
	void add(Object object) throws BagException;
	/**
	* Add the given number of occurrences of value to a bag.
	* @param object The value to add.
	* @param occurrences The number of occurrences of the value.
	* @throws BagException If the bag is full.
	* Note that the bag holds a single copy of a given value, along with
	* the number of occurrences of that value. It does not store multiple
	* copies of the same value.
	*/
	void addWithOccurrences(Object object, int occurrences) throws BagException;
	/**
	* Check if the bag contains a value.
	* @param object The value to look for.
	* @return True if the bag contains the value, false otherwise.
	*/
	boolean contains(Object object);
	/**
	* Return the number of occurrences (count) of a value in the bag.
	* @param object The value to look for.
	* @return The number of occurrences.
	*/
	int countOf(Object object);
	/**
	* Remove an occurrence of value from the bag. If the last occurrence is
	removed,
	* remove the value as well. Do nothing if the value is not in the bag.
	* @param object The value to remove.
	*/
	void remove(Object object);
	/**
	 * Determine the number of distinct values stored in the bag. The number of
	 * occurrences of each value is not taken into account.
	 * @return The number of distinct values in the bag.
	 */
	int size();
	/**
	 * Check if the set is empty.
	 * @return True if the set is empty, false otherwise.
	 */
	boolean isEmpty();
	/**
	 * Create a new Bag containing the contents of this and the argument Bag.
	 * @param b The bag to add.
	 * @return The new Bag.
	 * @throws BagException If the bag becomes full while adding.
	 */
	Bag addAll(Bag b) throws BagException;
        void removeAllOccurrences(Object object);
        Bag subtract(Bag bag) throws BagException;
        @Override String toString();
	}
