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
    private ArrayList <int[]> personlocation = new ArrayList <int[]>();
    private boolean odoors = false;
    /* Interface for People */
    public synchronized void callLift(int floor, Direction direction) throws InterruptedException
    {
        int[] code = code(floor,direction);
        personlocation.add(code);
        //System.out.println(code(floor,direction));
        while(!(currentfloor == floor && currentdirection == direction && odoors))
        {
            wait();
        }
        personlocation.remove(code);
        notifyAll();
       }

    public synchronized void selectFloor(int floor) throws InterruptedException
    {
        int[] code = code(floor,Direction.UNSET);
        personlocation.add(code);
        notifyAll();
         while(!(currentfloor == floor && odoors))
        {
            wait();
        }
        personlocation.remove(code);
        notifyAll();
    }

    
    /* Interface for Lifts */
    public boolean liftAtFloor(int floor, Direction direction) 
    {
        currentfloor = floor;
        currentdirection = direction;
        //iterate through array list
        for(int[] rcode: personlocation)
        {
        if(currentfloor == decodefloor(rcode) && (currentdirection == decodedirection(rcode) || Direction.UNSET == decodedirection(rcode)))
        {
        return true;
        }
        }
        return false;
    }

    public synchronized void doorsOpen(int floor) throws InterruptedException
    {
        odoors = true;
        notifyAll();
        while(transition())
        {
            wait();
        }
    }

    public synchronized void doorsClosed(int floor)
    {
        odoors = false;
    }

    private int[] code(int floor, Direction direction)
    {
        int[] rcode = new int[2];
        rcode [0] = floor;
        if (Direction.UP == direction)
        {
            rcode [1] = 1;
        }
        if (Direction.DOWN == direction)
        {
            rcode [1] = 2;
        }
        if (Direction.UNSET == direction)
        {
            rcode [1] = 3;
        }
        return rcode;
    }
    private int decodefloor(int[]rcode)
    {
        return rcode[0];
    }

    private Direction decodedirection(int[]rcode)
    {
        if(rcode[1] == 1)
        {
            return Direction.UP;
        }
        if(rcode[1] == 2)
        {
            return Direction.DOWN;
        }
            return Direction.UNSET;

    }
    private boolean transition()
    {
        for(int[] rcode: personlocation)
        {
            int a = decodefloor(rcode);
            Direction b = decodedirection(rcode);
            if(currentfloor == decodefloor(rcode) &&
                    (currentdirection == decodedirection(rcode) || Direction.UNSET == decodedirection(rcode)))
            {
                return true;
            }
        }
        return false;
    }
}
