package mybag;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.Test;
import org.testng.annotations.Factory;
import static org.testng.Assert.fail;

/**
 *  This class deals with test cases where exceptions should be thrown if the code
 *  is working properly.
 */
public class ExceptionThrowingTest implements TestFactoryClient
{
  private TestFactory testFactory;

  @Factory
  public Object[] createInstances() throws Exception
  {
    return BagTestFactory.createInstances(this.getClass());
  }

  public ExceptionThrowingTest() {}

  public void setFactory(TestFactory testFactory)
  {
    this.testFactory = testFactory;
  }

  @AfterMethod
  public void tearDown()
  {
    AbstractBag.setFactory(new DefaultBagFactory());
  }

  @Test(expectedExceptions = {BagException.class})
  public void testSizeTooLarge() throws BagException
  {
    testFactory.getInstance(Bag.MAX_SIZE+1);
  }

  @Test(expectedExceptions = {BagException.class})
  public void testNegativeSize() throws BagException
  {
    testFactory.getInstance(-1);
  }

  @Test(expectedExceptions = {BagException.class})
  public void testSizeTooSmall() throws BagException
  {
    testFactory.getInstance(0);
  }

  // Add your test methods here

}
