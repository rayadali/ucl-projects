package liftsimulator2;

/*
 *  Lift Simulator Individual Coursework 1
 *  Concurrent Programming COMP2007 Part 2.
 */


/**
 * Simulates a person using a lift.
 * @author K. Bryson
 */
public class Person extends Thread {

    private final int person_id;
    private final LiftController controller;

    public Person(int person_id, LiftController controller) {
        this.person_id = person_id;
        this.controller = controller;
    }

    public void run() {

        System.out.println("Started " + this);

        try {
            while (true) {

                // Take 5 seconds to run to random floor!
                sleep(5000);
                int from_floor = (int) (java.lang.Math.random() * Main.NUMBER_FLOORS);

                // Allow person to go to the same floor ...
                // people sometimes mess about ... and good boundary case!
                int to_floor = (int) (java.lang.Math.random() * Main.NUMBER_FLOORS);

                // Define the direction - note that people will select 'DOWN' if
                // they are just messing about (going to the same floor) except
                // if they are actually on floor 0 ... since only 'UP' button then.
                LiftController.Direction direction;
                if (to_floor - from_floor <= 0 && from_floor != 0) {
                    direction = LiftController.Direction.DOWN;
                } else {
                    direction = LiftController.Direction.UP;
                }

                // Ok ... let's do the journey ... and hope the lift doesn't get stuck!

                System.out.println("Person " + person_id + " wants to go from floor " +
                        from_floor + " to floor " + to_floor);

                System.out.println("Person " + person_id + " selecting " + direction);

                controller.callLift(from_floor, direction);

                System.out.println("Person " + person_id + " has entered lift.");
                System.out.println("Person " + person_id + " selecting floor " + to_floor);

                controller.selectFloor(to_floor);

                System.out.println("Person " + person_id + " getting out of lift.");

            }
        } catch (InterruptedException e) {
            System.out.println("Person " + person_id + " was interrupted.");
        }
    }
}
