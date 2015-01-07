package liftsimulator;

/*
 *  Lift Simulator Individual Coursework 1
 *  Concurrent Programming COMP2007 Part 2.
 */



/**
 * Interface that lift controllers need to provide.
 * @author Kevin Bryson
 */
public interface LiftController {

    /********************/
    /* Global constants */
    /********************/
    
    public enum Direction {
        UP,
        DOWN,
        UNSET
    }

    /************************/
    /* Interface for People */
    /************************/

    /*
     * Person presses the 'call lift' button on a given floor and direction.
     *
     * NOTE - THIS METHOD DOES NOT RETURN UNTIL THE LIFT HAS APPEARED,
     * OPENED ITS DOORS, AND THE PERSON HAS 'ENTERED' THE LIFT.
     *
     * @param floor        Floor number that the person is on.
     * @param directoin    Direction they wish to travel.
     */
    void callLift(int floor, Direction direction) throws InterruptedException;

    /*
     * A person is in the lift and selects a particular floor.
     *
     * NOTE - THIS METHOD DOES NOT RETURN UNTIL THE LIFT HAS OPENED
     * IT'S DOOR AT THE SELECTED FLOOR AND THE PERSON HAS 'EXITED'.
     *
     * @param floor Floor number that they have selected.
     */
    void selectFloor(int floor) throws InterruptedException;


    /***********************/
    /* Interface for Lifts */
    /***********************/

    /*
     * Lift informs the lift controller that it is on a
     * specific floor and going in a particular direction.
     * The lift controller tells the lift whether it should open its doors.
     *
     * @param floor Floor number that the lift is at.
     * @param direction Direction lift is going in.
     * @return    True if the lift should open its doors.
     */
    boolean liftAtFloor(int floor, Direction direction);

    /*
     * Lift informs the controller that it has its doors open.
     *
     * NOTE - the controller should allow all people to
     * exit and enter the lift before returning.
     *
     * @param floor  Floor number that the lift is at.
     */
    void doorsOpen(int floor) throws InterruptedException;

    /*
     * Lift informs the controller that it has now closed its doors.
     *
     * @param floor  Floor number that the lift is at.
     */
    void doorsClosed(int floor);

}
