package akashcw;

/**
* Example code illustrating the use of MySet objects.
*/

public class Main_1
{
	private MySetFactory factory = new DefaultMySetFactory();
	
	public void print(MySet set)
	{
		boolean first = true;
		System.out.print("{");
		for (Object obj : set)
		{
			if (!first) { System.out.print(" , "); }
			first = false;
			System.out.print(obj);
		}
		System.out.println("}");
	}
	
	public void powerPrint(MySet set)
	  {
		System.out.print ("{");
		for (Object obj : set)
		{
		MySet myset = ((MySet) obj);
	    boolean first = true;
	    System.out.print("{");
	    for (Object obj1 : myset)
	    {
	      if (!first) { System.out.print(" , "); }
	      first = false;
	      System.out.print(obj1);
	    }
	    System.out.print("} ");
	  }
		System.out.print("} ");
	  }

	public void go()
	{
		MySet set1;
		MySet set2;
			
		try
		{
			System.out.println("Sets In Use: ");
			set1 = factory.getInstance(MapMySet.class);
			set1.add(1);
			set1.add(2);
			set1.add(3);
			print(set1);
			set2 = factory.getInstance(MapMySet.class);
			set2.add(2);
			set2.add(3);
			set2.add(4);
			print(set2);
			
			System.out.println("MapMySet: ");
			System.out.print("  Union: ");
			print(set1.union(set2));
			System.out.print("  Intersection: ");
			print(set1.intersection(set2));
			System.out.print("  Difference: ");
			print(set1.difference(set2));
			
			
			set1 = factory.getInstance(ArrayMySet.class);
			set1.add(1);
			set1.add(2);
			set1.add(3);
			//print(set1);
			set2 = factory.getInstance(ArrayMySet.class);
			set2.add(2);
			set2.add(3);
			set2.add(4);
			//print(set2);
			
			System.out.println("ArrayMySet: ");
			System.out.print("  Union: ");
			print(set1.union(set2));
			System.out.print("  Intersection: ");
			print(set1.intersection(set2));
			System.out.print("  Difference: ");
			print(set1.difference(set2));
			
			set1 = factory.getInstance(LinkedListMySet.class);
			set1.add(1);
			set1.add(2);
			set1.add(3);
			//print(set1);
			set2 = factory.getInstance(LinkedListMySet.class);
			set2.add(2);
			set2.add(3);
			set2.add(4);
			//print(set2);
			
			System.out.println("LinkedListMySet: ");
			System.out.print("  Union: ");
			print(set1.union(set2));
			System.out.print("  Intersection: ");
			print(set1.intersection(set2));
			System.out.print("  Difference: ");
			print(set1.difference(set2));
			
			System.out.print("Powerset: "); //Powerset of the union of set1&set2 
		    powerPrint(set1.powerSet(set2));

		}
		catch (MySetException e)
		{
			System.out.println("====> MySet Exception thrown...");
		}
	}
	
	public static void main(String[] args)
	{
		new Main_1().go();
	}
}
