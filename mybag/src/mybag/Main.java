package mybag;

/**
 * Example code illustrating the use of Bag objects.
 */
public class Main
{
  private BagFactory factory = new DefaultBagFactory();

  public void print(Bag bag)
  {
    boolean first = true;
    System.out.print("{");
    for (Object obj : bag)
    {
      if (!first) { System.out.print(" , "); }
      first = false;
      System.out.print(obj);
    }
    System.out.println("}");
  }

  public void go()
  {
    Bag bag1;
    Bag bag2;
    Bag bag3;
    try
    {
      bag1 = factory.getInstance(ArrayBag.class);
      bag1.add(1);
      bag1.add(2);
      bag1.add(1);
      print(bag1);
      int a = bag1.countOf(1);
      System.out.println(a);
      bag2 = factory.getInstance(MapBag.class);
      bag2.add(1);
      bag2.add(1);
     // bag2.add(2);
      print(bag2);
      bag3 = factory.getInstance(LinkedListBag.class);
      bag3.add(1);
      bag3.add(2);
      bag3.add(3);
      print(bag3);
      int i = bag3.countOf(3);
      System.out.println(i);
      int b = bag3.countOf(1);
      System.out.println(b);
      int c = bag3.size();
      System.out.println(c);
      String bool = "no";
      if(bag3.contains(4)){bool = "yes";}
      System.out.println(bool);
      System.out.print("AddAll: ");
      print(bag1.addAll(bag3));
    //  System.out.print("Occurences of 3 in bag 1 is " + i);
      String bagstring = bag1.toString();
      System.out.println("bag1 to string:" + bagstring);
      Bag x = bag1.subtract(bag2);
      print(x);
    }
    catch (BagException e)
    {
      System.out.println("====> Bag Exception thrown...");
    }
  }

  public static void main(String[] args)
  {
    new Main().go();
  }
}