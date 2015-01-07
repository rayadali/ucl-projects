package akashcw;

/**
* The exception class used by the MySet classes.
*/

public class MySetException extends Exception
{
	/**
	* Use the default message.
	*/
	
	public MySetException()
	{
		super("MySet error");
	}
	
	/**
	* Provide a custom message.
	* @param message The message to store in the exception object.
	*/
	
	public MySetException(String message)
	{
		super(message);
	}
}