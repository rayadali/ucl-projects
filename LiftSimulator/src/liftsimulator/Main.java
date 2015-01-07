package liftsimulator;

/*
 *  Lift Simulator Individual Coursework 1
 *  Concurrent Programming COMP2007 Part 2.
 */


/**
 * Simulates a lift system.
 * @author K. Bryson
 */
public class Main {

    /*
     * Floors are numbered from floor 0 (ground floor) to MAX_FLOOR_NUMBER.
     */
    public static final int NUMBER_FLOORS = 9; // Floor 0 to Floor 8.
    public static final int NUMBER_PEOPLE = 2;

    /**
     * Main program for the lift simulator.
     * @param args Command line arguments.
     */
    public static void main(String[] args) {

        // Generate shared LiftController.
        LiftController controller = new MyLiftController();

        System.out.println("Main thread creating Lift and " +
                NUMBER_PEOPLE + " people.");

        Lift lift = new Lift(controller);
        Person[] person = new Person[NUMBER_PEOPLE];

        for (int id = 0; id < NUMBER_PEOPLE; id++) {
            person[id] = new Person(id, controller);
        }

        System.out.println("Main thread starting " +
                NUMBER_PEOPLE + " people and Lift.");

        lift.start();

        for (int id = 0; id < NUMBER_PEOPLE; id++) {
            person[id].start();
        }

        System.out.println("Application threads have all been started.");
        System.out.println("Main thread done it's work - terminating.");
    }
}
