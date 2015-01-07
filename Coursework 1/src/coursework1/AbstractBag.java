package coursework1;

/**
* This class implements methods common to all concrete bag implementations
* but does not represent a complete bag implementation.<br />
*
* New bag objects are created using a Factory. By default a DefaultBagFactory
* instance is used but this can be replaced with any factory implementing the
* BagFactory interface.
*/
import java.util.HashMap;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
public abstract class AbstractBag implements Bag
	{
	private static BagFactory factory = new DefaultBagFactory();
	private Bag getNewBagInstance(Bag kind) throws BagException
		{
			return factory.getInstance(kind.getClass());
		}
/**
* Set the factory to be used for bag creation. Note this is a static
* method so <em>all</em> bag objects created from now on
* will be created by the new factory.
* @param aFactory The factory to use.
*/
	public static void setFactory(BagFactory aFactory)
	{
		factory = aFactory;
	}
        
        public void removeAllOccurrences(Object object)
        {
            while(this.contains(object))
            {
                this.remove(object);
            }
        }

  public Bag subtract(Bag bag) throws BagException
  {
      Bag endBag = this.getNewBagInstance(this);
        for(Object object : this)
        {
            endBag.add(object);

        }

        for(Object object : bag)
        {
            int a = bag.countOf(object);

            for(int c = 0; c < a; c++)
            {
                endBag.remove(object);
            }
        }
        return endBag;
  }
	public Bag addAll(Bag b) throws BagException {
		Bag result = getNewBagInstance(this);
		for (Object o : this)
		{
			result.add(o);
		}
		for (Object o : b)
		{
			result.add(o);
		}
		return result;
	}
   /*     public String toString(){
        try {
            String s = "";
            Bag bag = getNewBagInstance(this);
            for (Object object : this) {
                s = s + " value " + object.toString() + " : occurences " + this.countOf(object);
            }
            return s;
        } catch (BagException ex) {
            Logger.getLogger(AbstractBag.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "";
        }
    */
        @Override
    public String toString()
    {
        String myString = new String("[");
        HashMap bagToHashMap = new HashMap();

        for(Object myObject : this)
        {
            if (bagToHashMap.containsKey(myObject))
            {
               Integer myInteger = (Integer)bagToHashMap.get(myObject);
               myInteger++;
               bagToHashMap.put(myObject, myInteger);
            }

            else {
                bagToHashMap.put(myObject, 1);
            }
        }

        Iterator iterator = bagToHashMap.keySet().iterator();

        while(iterator.hasNext())
        {
            Object object = iterator.next();
            myString = myString + object.toString()+ ":" + bagToHashMap.get(object);
            if (iterator.hasNext()) {myString = myString + ", ";}

        }

        return (myString + "]");

    }

  
}