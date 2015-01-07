import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Scanner;


public class FileInput extends Input
{

  public FileInput(final String fileName)
  {
    try
    {
      scanner = new Scanner(new FileInputStream(fileName));
    }
    catch (FileNotFoundException fnfe)
    {
      System.err.println("File " + fileName + " could not be found.");
      System.err.println("Program will now exit.");
      System.exit(1);
    }
  }

  public FileInput(final FileInputStream fileStream)
  {
    super(fileStream);
  }
}
