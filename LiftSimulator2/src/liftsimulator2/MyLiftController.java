package liftsimulator;

import java.util.ArrayList;

/*
 *  Lift Simulator Individual Coursework 1
 *  Concurrent Programming COMP2007 Part 2.
 */


/**
 * This default lift controller doesn't work very well!
 * You need to implement this lift controller as specified.
 * @author K. Bryson
 */
public class MyLiftController implements LiftController {

    private int currentfloor = 0;
    private Direction currentdirection = Direction.UNSET;
    private static class Element
	{
		public int floor;
		public Direction direction;
		public Element(int floor, Direction direction)
		{
			this.floor = floor;
			this.direction = direction;
		}
	}
    private static class Destination
	{
		public int dfloor;
		public Destination(int dfloor)
		{
			this.dfloor = dfloor;
		}
	}

    private ArrayList<Element> personlocation = new ArrayList <Element>();
    private ArrayList<Destination> persondestination = new ArrayList <Destination>();
    private boolean doors = false;
    /* Interface for People */
    public synchronized void callLift(int floor, Direction direction) throws InterruptedException
    {
        Element e = new Element(floor, direction);
        personlocation.add(e);
        //System.out.println(floor,direction);
        while(currentfloor != floor || currentdirection!= direction)
        {
            wait();
        }
        personlocation.remove(e);
    }

    public synchronized void selectFloor(int floor) throws InterruptedException
    {
        Destination d = new Destination(floor);
        persondestination.add(d);
        notifyAll();
        while(currentfloor != floor){
            wait();
        }
        persondestination.remove(d);
        notifyAll();
    }

    
    /* Interface for Lifts */
    public boolean liftAtFloor(int floor, Direction direction) 
    {
        currentfloor = floor;
        currentdirection = direction;
        //iterate through array list
        for (Element element : personlocation)
	{
	if ((element.floor == currentfloor) && element.direction.equals(currentdirection))
	{
	return true;
        }
        }
        for(Destination person : persondestination)
        {
            if(person.dfloor == floor)
            {
                return true;
            }
        }
        return false;
    }

    public synchronized void doorsOpen(int floor) throws InterruptedException
    {
        doors = true;
        notifyAll();
        while(checkdoors()){
            wait();
        }
        
    }

    public synchronized void doorsClosed(int floor) {
        doors = false;
    }
    public boolean checkdoors(){
        for(Element element : personlocation){
            if(element.floor == currentfloor && (element.direction == currentdirection || element.direction == Direction.UNSET)){
                return true;
            }
            }
        return false;
        }

    
  
}
