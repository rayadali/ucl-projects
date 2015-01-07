package mybag;

/** 
 * This is a factory class that creates factory objects to initialise test class objects.
 * It is a factory that creates factories.
 */
public class BagTestFactory
{
  // Return an array of test class objects that the TestNG framework will use to run
  // tests. Note, the array does not contain the test fixture objects (i.e., Bag objects),
  // but objects of the test class (BagTest in this coursework).
  public static Object[] createInstances(Class testClass)
    throws Exception
  {
    // Increase the size of this array when additional Bag implementations
    // are added for testing.
    TestFactoryClient[] testInstances = new TestFactoryClient[3];
   // Create a test class instance object (a BagTest object for this coursework).
    testInstances[0] = (TestFactoryClient)testClass.newInstance();
   // Set the factory object on the test class instance to a factory object that delivers
   // ArrayBag objects that will be the fixtures when tests are actually run.
    testInstances[0].setFactory(createArrayBagTestFactory());
 
   //  Uncomment the lines below to test MapBag and LinkedListBag implementations.
    testInstances[1] = (TestFactoryClient)testClass.newInstance();
    testInstances[1].setFactory(createMapBagTestFactory());
    testInstances[2] = (TestFactoryClient)testClass.newInstance();
    testInstances[2].setFactory(createLinkedListBagTestFactory());
    return testInstances;
  }

  // Return a factory object that can create ArrayBag objects.  
  private static TestFactory createArrayBagTestFactory()
  {
    return new TestFactory()
    {
      public Bag getInstance() throws BagException
      { return new ArrayBag();}
      public Bag getInstance(int size) throws BagException
      { return new ArrayBag(size);}
    };
  }

// Uncomment these methods to when testing MapBags and LinkedListBags.

  private static TestFactory createMapBagTestFactory()
  {
    return new TestFactory()
    {
      public Bag getInstance() throws BagException
      { return new MapBag();}
      public Bag getInstance(int size) throws BagException
      { return new MapBag(size);}
    };
  }

  private static TestFactory createLinkedListBagTestFactory()
  {
    return new TestFactory()
    {
      public Bag getInstance() throws BagException
      { return new LinkedListBag();}
      public Bag getInstance(int size) throws BagException
      { return new LinkedListBag(size);}
    };
  }

}
