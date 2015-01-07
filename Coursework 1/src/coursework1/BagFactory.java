package coursework1;

/**
* This interface defines the public methods that a Bag factory must
* implement.
* */

public interface BagFactory
{
/**
* Create a bag that is an instance of the same class as the parameter object.
* @param bagClass A class object used to determine the class of the bag to
instantiate.
* @return The new bag.
* @throws BagException If the class is not recognised as one from
* which a bag object can be created.
*/
public Bag getInstance(Class bagClass) throws BagException;
/**
* Create a bag that is an instance of the same class as the parameter object,
with the
* given maximum bag size.
* @param bagClass A class object used to determine the class of the bag
* to instantiate
* @param maxSize The maximum size of the new bag.
* @return The new bag.
* @throws BagException If the class is not recognised as one from
* which a bag object can be created.
*/
public Bag getInstance(Class bagClass, int maxSize) throws BagException;
}