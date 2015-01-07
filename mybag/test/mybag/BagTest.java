package mybag;

import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;
import org.testng.annotations.Factory;
import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertTrue;
import static org.testng.Assert.assertFalse;
import static org.testng.Assert.fail;

import java.util.ArrayList;
import java.util.Iterator;

/**
 *  The test class for Bag objects. All tests are done via the methods declared in 
 *  interface Bag. This class can test any concrete implementation.
 */
public class BagTest implements TestFactoryClient
{
  // The factory object used to create concrete Bag objects.
  private TestFactory testFactory;
  
  // The fixtures.
  private Bag empty;
  private Bag one;
  private Bag other;

  // The TestNGFactory annotation marks this as a method that returns an array of instances
  // of this class. The TestNG framework will then use the instances to run tests with.
  // Each instance will be initialised with a different factory for creating objects of
  // different Bag implementations (the fixtures).
  @Factory
  public Object[] createInstances() throws Exception
  {
    return BagTestFactory.createInstances(this.getClass());
  }

  public BagTest() {}

  // Set the fixture creation factory.
  public void setFactory(TestFactory testFactory)
  {
    this.testFactory = testFactory;
  }

  @BeforeMethod
  public void setUp() throws BagException
  {
    empty = testFactory.getInstance();
    one = testFactory.getInstance();
    one.add(1);
    other = testFactory.getInstance();
    other.add(1);
    other.add(1);
    other.add(2);
  }

  // Below are a number of example test methods to get you started
  @Test
  public void testEmptySize()
  {
    assertEquals(empty.size(), 0);
  }

  @Test
  public void testOneSize()
  {
    assertEquals(one.size(), 1);
  }

  @Test
  public void testOneSizeAddDuplicate() throws BagException
  {
    one.add(1);
    assertEquals(one.size(),1);
  }

  @Test
  public void testSizeDecrease() throws BagException
  {
    one.add(2);
    assertEquals(one.size(), 2);
    one.remove(2);
    assertEquals(one.size(), 1);
  }

  @Test
  public void testContains()
  {
    assertTrue(one.contains(1));
  }

  // The next two methods are private helper methods used to write tests.
  @SuppressWarnings("unchecked")
  private ArrayList createExpected(int... values)
  {
    ArrayList expected = new ArrayList();
    for(int n : values) {expected.add(n);}
    return expected;
  }

  private void testContents(Bag b, ArrayList values) {
    Iterator iter = b.iterator();
    while (iter.hasNext()) {
      Integer value = (Integer)iter.next();
      if (!values.remove(value)) { fail(); }
    }
    if (values.size() != 0) { fail(); }
  }

  @Test
  public void testEmptyIterator()
  {
    testContents(empty,new ArrayList());
  }
  @Test
  public void testOtherIteratorTwoNoDuplicates() throws BagException
  {
    other.add(1);
    other.add(3);
    testContents(other,createExpected(1,1,1,2,3));
  }

  @Test
  public void testOtherIteratorThreeNoDuplicates() throws BagException
  {
    other.add(1);
    other.add(3);
    other.add(5);
    testContents(other,createExpected(1,1,1,2,3,5));
  }

  @Test
  public void testOtherIteratorThreeWithDuplicates() throws BagException
  {
    other.add(1);
    other.add(3);
    other.add(3);
    testContents(other,createExpected(1,1,1,2,3,3));
  }

  @Test
  public void testOtherIteratorTwoWithDuplicates() throws BagException
  {
    other.add(1);
    other.add(1);
    testContents(other,createExpected(1,1,1,1,2));
  }

  @Test
  public void testOtherSize()
  {
    assertEquals(other.size(), 2);
  }

  @Test
  public void testOtherSizeAddDuplicate() throws BagException
  {
    other.add(1);
    assertEquals(other.size(),2);
  }

  @Test
  public void testOtherSizeDecrease() throws BagException
  {
    other.add(3);
    assertEquals(other.size(), 3);
    other.remove(3);
    assertEquals(other.size(), 2);
  }

  @Test
  public void testOneCountOf() throws BagException
  {
      assertEquals(one.countOf(1), 1);
      one.add(1);
      assertEquals(one.countOf(1), 2);
  }

  @Test
  public void testOneOccurencesCountOf() throws BagException
  {
      one.addWithOccurrences(1, 2);
      assertEquals(one.countOf(1), 3);
  }

  @Test
  public void testOtherCountOf() throws BagException
  {
      assertEquals(other.countOf(1), 2);
      other.add(1);
      assertEquals(other.countOf(1), 3);
  }

  @Test
  public void testOtherOccurencesCountOf() throws BagException
  {
      other.addWithOccurrences(1, 2);
      assertEquals(other.countOf(1), 4);
  }

  @Test
  public void testOneEmptyCountOf() throws BagException
  {
      one.remove(1);
      assertEquals(one.countOf(1), 0);
  }

  @Test
  public void testOtherEmptyCountOf() throws BagException
  {
      other.remove(1);
      other.remove(1);
      assertEquals(other.countOf(1), 0);
  }

   @Test
  public void testOneRemoveOccurences() throws BagException
  {
      one.removeAllOccurrences(1);
      assertEquals(one.countOf(1), 0);
      assertEquals(one.size(),0);
  }

  @Test
  public void testOtherRemoveOccurences() throws BagException
  {
      other.removeAllOccurrences(1);
      assertEquals(other.countOf(1), 0);
      assertEquals(other.size(),1);
  }

  @Test
  public void testOtherToString() throws BagException
  {
      assertEquals(other.toString(), "[1:2, 2:1]");
  }

  @Test
  public void testSubtract() throws BagException
  {
      Bag x = other.subtract(one);
      testContents(x, createExpected(1,2));
  }

  @Test
  public void testAddAll() throws BagException
  {
      Bag y = other.addAll(one);
      testContents(y, createExpected(1,1,1,2));
  }



  // Add your test methods here
}
