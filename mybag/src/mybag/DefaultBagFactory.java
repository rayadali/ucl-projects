package mybag;

/**
* The default bag factory. The getInstance method will return a new instance of
* the Bag implementation class determined by the class of the parameter.
*/
public class DefaultBagFactory implements BagFactory
{

  public Bag getInstance(Class bagClass) throws BagException
  {
    return getInstance(bagClass, Bag.MAX_SIZE);
  }

  public Bag getInstance(Class bagClass, int size) throws BagException
  {
   if (bagClass.equals(ArrayBag.class))
   {
   return new ArrayBag(size);
    }
   if (bagClass.equals(MapBag.class))
   {
   return new MapBag(size);
    }
   if (bagClass.equals(LinkedListBag.class))
   {
   return new LinkedListBag(size);
    }
    throw new BagException
      ("Attempting to use DefaultBagFactory to create something that is not a Bag");
  }

}