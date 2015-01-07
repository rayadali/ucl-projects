public void f()
{
	for (int i = 0; i < 10; i++)
	{
		try
		{
			if (i % 3 == 0)
			{
				throw new Exception("A");
			}
			try
			{
				if% 3 == 1)
			{
				throw new Exception("B");
			}
			System.out.println(i);
		}
		catch (Exception e1)
		{
			i *= 2;
		}
		finally
		{
			i++;
		}
	}
	catch (Exception e2)
	{
		i += 3;
	}
	finally
	{
		i++;
	}
	}
}