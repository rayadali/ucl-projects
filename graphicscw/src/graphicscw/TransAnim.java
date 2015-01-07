import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.awt.geom.*;

public class TransAnim extends JApplet {
    public static void main(String args[]) {
        JFrame f = new JFrame("Mini Solar System");
        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {System.exit(0);}
        });
        JApplet applet = new TransAnim();
        f.getContentPane().add(applet, BorderLayout.CENTER);
        applet.init();
        f.setSize(new Dimension(500,500));
        f.setVisible(true);
    }

    public void init() {
        getContentPane().setLayout(new BorderLayout());
        TransAnimPanel animator = new TransAnimPanel();
        animator.setSize(500, 500);
        getContentPane().add(animator);
        animator.setVisible(true);
        animator.startAnimation();
    }
}

class TransAnimPanel extends JPanel implements Runnable {
    Thread animatorThread;
    int delay;

    AffineTransform newEarth;
    AffineTransform newMoon;
    Shape sun;
    Shape earth;
    Shape moon;
    double sunPosition = 175;
    double sunSize = 50;
    double moonWidth = 7;
    double moonHeight = 10;
    double earthWidth = 15;
    double earthHeight = 25;
    double theta = 0.0;

    public TransAnimPanel() {
	newEarth = new AffineTransform();
	newMoon = new AffineTransform();
	sun = new Ellipse2D.Double(sunPosition, sunPosition, 2*sunSize, 2*sunSize);
	earth = new Ellipse2D.Double(0, 0, 2*earthWidth, 2*earthHeight);
	moon = new Ellipse2D.Double(0, 0, 2*moonWidth, 2*moonHeight);

	delay = 10;
    }

    //Draw the current frame of animation.
    public void paintComponent(Graphics g) {
      super.paintComponent(g);

      Graphics2D g2 = (Graphics2D)g;
      theta +=0.1;

      //Sun
      g2.setColor(Color.orange);
      g2.fill(sun);

      //Earth
      double earthx = sunPosition + (sunSize - earthWidth)  + 175
      * difference(theta, 1000);
      double earthy = sunPosition + (sunSize - earthHeight) + 175 * difference(theta + 200,1000);
      newEarth.setToTranslation(earthx,earthy);
      newEarth.rotate(theta/30, earthWidth,earthHeight);
      Shape newEarthShape = newEarth.createTransformedShape(earth);
      g2.setColor(Color.green);
      g2.fill(newEarthShape);

      //Moon
      double x = earthx + (earthWidth - moonWidth) + 60
      * difference(theta, 100);
      double y = earthy + (earthHeight - moonHeight)
      + 60 * difference(theta + 70.5 ,100);
      newMoon.setToTranslation(x,y);
      newMoon.rotate((-theta/20),moonWidth,moonHeight);
      Shape newMoonShape = newMoon.createTransformedShape(moon);
      g2.setColor(Color.gray);
      g2.fill(newMoonShape);

      //Drawing the sun, earth and moon
      g2.draw(newEarth.createTransformedShape(earth));
      g2.draw(newMoon.createTransformedShape(moon));
      g2.draw(sun);
    }

       public double difference(double theta, int speed) {
        double two2Pi = 2*Math.PI;
    	double fraction = (theta % speed)/speed;
    	double value = Math.sin(two2Pi * fraction);
    	return value;
    }


    public void startAnimation() {
      //Start the animating thread.
      if (animatorThread == null) {
	animatorThread = new Thread(this);
      }
      animatorThread.start();
    }

    public void stopAnimation() {
      //Stop the animating thread.
      animatorThread = null;
    }

    public void run() {
        //Just to be nice, lower this thread's priority
        //so it can't interfere with other processing going on.
        Thread.currentThread().setPriority(Thread.MIN_PRIORITY);

        //Remember the starting time.
        long startTime = System.currentTimeMillis();

        //Remember which thread we are.
        Thread currentThread = Thread.currentThread();

        //This is the animation loop.
        while (currentThread == animatorThread) {
            //Advance the animation frame.
            //Display it.
            repaint();

            //Delay depending on how far we are behind.
            try {
                startTime += delay;
                Thread.sleep(Math.max(0, 
                             startTime-System.currentTimeMillis()));
            } catch (InterruptedException e) {
                break;
            }
        }
    }
}

