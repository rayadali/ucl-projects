package liftsimulator;

/*
 *  Lift Simulator Individual Coursework 1
 *  Concurrent Programming COMP2007 Part 2.
 */


/**
 * Simulates a lift that cycles between the floors.
 * @author K. Bryson
 */
public class Lift extends Thread {

    private final LiftController controller;

    public Lift(LiftController controller) {
        this.controller = controller;
    }

    public void run() {

        System.out.println("Started Lift");

        int floor = 0;
        LiftController.Direction direction = LiftController.Direction.UP;

        try {

            while (true) {

                System.out.println("Lift on floor " + floor + ", going " + direction);

                // Tell controller floor position of lift and direction,
                // request whether doors should open.
                if (controller.liftAtFloor(floor, direction)) {
                    openDoors(floor);
                }

                sleep(5000); // Move between floors - takes 5 seconds.
                floor += (direction == LiftController.Direction.UP) ? +1 : -1;

                // Change direction if required.
                if (floor == Main.NUMBER_FLOORS - 1) {
                    direction = LiftController.Direction.DOWN;
                } else if (floor == 0) {
                    direction = LiftController.Direction.UP;
                }
            }
        } catch (InterruptedException e) {
            System.out.println("Lift was interrupted - terminating.");
        }
    }
    
    private void openDoors(int floor) throws InterruptedException {
        
        // Opening lift doors - takes 3 seconds.
        sleep(3000);
        System.out.println("Lift has opened doors at floor " + floor);

        // Controller will only return once people
        // have left the lift (and others have entered).
        controller.doorsOpen(floor);

        System.out.println("Lift closing doors at floor " + floor);
        sleep(3000); // Simulate 3 seconds for doors to close.
        controller.doorsClosed(floor);

    }

}
