package mybag;

public interface TestFactory
{
  public Bag getInstance() throws BagException;
  public Bag getInstance(int size) throws BagException;
}
