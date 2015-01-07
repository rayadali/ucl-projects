import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import java.applet.Applet;
import java.awt.geom.*;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class Cubic extends JApplet{

    static protected JLabel label;
    CubicPanel cubicPanel;

    public void init(){
	//Initialize the layout.
        getContentPane().setLayout(new BorderLayout());
        cubicPanel = new CubicPanel();
        cubicPanel.setBackground(Color.white);
	getContentPane().add(cubicPanel);
	label = new JLabel("Drag the points to adjust the curve.");
	getContentPane().add("South", label);
    }

    public static void main(String s[]) {
        JFrame f = new JFrame("Cubic");
        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {System.exit(0);}
        });
        JApplet applet = new Cubic();
        f.getContentPane().add(applet, BorderLayout.CENTER);
        applet.init();
        f.setSize(new Dimension(350,250));
        f.setVisible(true);
    }
}

class CubicPanel extends JPanel implements MouseListener, MouseMotionListener{

	BufferedImage bi;
	Graphics2D big;
	int x, y;
	Rectangle area, startpt, endpt, onept, twopt, rect;	
	CubicCurve2D.Double cubic = new CubicCurve2D.Double();
	Point2D.Double start, end, one, two, point;
	boolean firstTime = true;
	boolean pressOut = false;

	public CubicPanel(){

		setBackground(Color.white);
                addMouseMotionListener(this);
                addMouseListener(this);

		start = new Point2D.Double();
		one = new Point2D.Double();
		two = new Point2D.Double();
		end = new Point2D.Double();

                cubic.setCurve(start, one, two, end);
		startpt = new Rectangle(0, 0, 8, 8);
		endpt = new Rectangle(0, 0, 8, 8);
		onept = new Rectangle(0, 0, 8, 8);
		twopt = new Rectangle(0, 0, 8, 8);
	}

	public void mousePressed(MouseEvent e){

		x = e.getX();
		y = e.getY();

		if(startpt.contains(x, y)){
			rect = startpt;
			point = start;
                        x = startpt.x - e.getX();
                        y = startpt.y - e.getY();
                        updateLocation(e);
		}
 		else if(endpt.contains(x, y)){
			rect = endpt;
			point = end;
                        x = endpt.x - e.getX();
                        y = endpt.y - e.getY();
                        updateLocation(e);
		}
		else if(onept.contains(x, y)){
			rect = onept;
			point = one;
                        x = onept.x - e.getX();
                        y = onept.y - e.getY();
                        updateLocation(e);
		}
		else if(twopt.contains(x, y)){
			rect = twopt;
			point = two;
                        x = twopt.x - e.getX();  
                        y = twopt.y - e.getY();
                        updateLocation(e);
		} else {
			pressOut = true;
                }
	}

	public void mouseDragged(MouseEvent e){
                if(!pressOut) {
                        updateLocation(e);
		}

	}

	public void mouseReleased(MouseEvent e){
                if(startpt.contains(e.getX(), e.getY())){
                        rect = startpt;
                        point = start;
                        updateLocation(e);
                }
                else if(endpt.contains(e.getX(), e.getY())){
                        rect = endpt;
                        point = end;
                        updateLocation(e);
                }
                else if(onept.contains(e.getX(), e.getY())){
                        rect = onept;  
                        point = one;  
                        updateLocation(e);
                }
                else if(twopt.contains(e.getX(), e.getY())){
                        rect = twopt;
                        point = two;
                        updateLocation(e);
                }
                else {
                        pressOut = false;
                }
	}

	public void mouseMoved(MouseEvent e){}

	public void mouseClicked(MouseEvent e){}
	public void mouseExited(MouseEvent e){}
	public void mouseEntered(MouseEvent e){}

	public void updateLocation(MouseEvent e){

		rect.setLocation((x + e.getX())-4, (y + e.getY())-4);
		point.setLocation(x + e.getX(), y + e.getY());

                checkPoint();
                
		cubic.setCurve(start, one, two, end);
		repaint();
	}

	public void paintComponent(Graphics g){
                super.paintComponent(g);
		update(g);
	}

	public void update(Graphics g){

		Graphics2D g2 = (Graphics2D)g;
		Dimension dim = getSize();
		int w = dim.width;
                int h = dim.height; 
                 
          	if(firstTime){

		  // Create the offsecren graphics  to render to
		  bi = (BufferedImage)createImage(w, h);
		  big = bi.createGraphics();

		  // Get some initial positions for the control points

		  start.setLocation(w/2-50, h/2);
		  end.setLocation(w/2+50, h/2);
		  one.setLocation((int)(start.x)+25, (int)(start.y)-25);
		  two.setLocation((int)(end.x)-25, (int)(end.y)+25);

		  // Set the initial positions of the squares that are
		  // drawn at the control points
		  startpt.setLocation((int)((start.x)-4), (int)((start.y)-4));
                  endpt.setLocation((int)((end.x)-4), (int)((end.y)-4));
                  onept.setLocation((int)((one.x)-4), (int)((one.y)-4));
                  twopt.setLocation((int)((two.x)-4), (int)((two.y)-4));

		  // Initialise the CubicCurve2D
		  cubic.setCurve(start, one, two, end);

		  // Set some defaults for Java2D
        	  big.setColor(Color.black);
		  big.setStroke(new BasicStroke(5.0f));
		  big.setRenderingHint(RenderingHints.KEY_ANTIALIASING, 
				       RenderingHints.VALUE_ANTIALIAS_ON);
		  area = new Rectangle(dim);
		  firstTime = false;
		} 

		// Clears the rectangle that was previously drawn.

		big.setColor(Color.white);
		big.clearRect(0, 0, area.width, area.height);

		// Set the colour for the bezier
		big.setPaint(Color.black);

		// Replace the following line by your own function to
		// draw the bezier specified by start, one, two, end

		//big.draw(cubic);
                // ArrayList of points
                ArrayList<Point2D.Double> points = new ArrayList<Point2D.Double>();
                //ArrayList of the 4 control points * Note This Code can only use 4 control points*
		ArrayList<Point2D.Double> controlPoints = points(start.x, start.y,
				one.x, one.y,
				two.x, two.y,
				end.x, end.y,
				3, points);

		controlPoints.add(start);
		controlPoints.add(end);

		Collections.sort(controlPoints, new sortByX());

		for (int i = 0; i + 1 < controlPoints.size(); i++) {
			double xCoOrdinate = controlPoints.get(i).x;
			double yCoOrdinate = controlPoints.get(i).y;
			double xCoOrdinate2 = controlPoints.get(i + 1).x;
			double yCoOrdinate2 = controlPoints.get(i + 1).y;

			big.draw(new Line2D.Double(xCoOrdinate, yCoOrdinate,
					xCoOrdinate2,
					yCoOrdinate2));
		}
                // Drawing the 4 control points

		big.setPaint(Color.red);
		big.fill(startpt);
		big.setPaint(Color.magenta);
		big.fill(endpt);
		big.setPaint(Color.blue);
		big.fill(onept);
		big.setPaint(new Color(0, 200, 0));
		big.fill(twopt);

		// Draws the buffered image to the screen.
		g2.drawImage(bi, 0, 0, this);

	}

	public ArrayList<Point2D.Double> midPoint(double px,
			double py,
			double p2x,
			double p2y,
			double p3x,
			double p3y,
			double p4x,
			double p4y,
			String location) {

		ArrayList<Point2D.Double> latestNewCurve = new ArrayList<Point2D.Double>();

		//Using de Casteljau’s Benzier recursive division method

		double ax = ((px + p2x) / 2); 
		double ay = ((py + p2y) / 2);
		double bx = ((p2x + p3x) / 2);
		double by = ((p2y + p3y) / 2);
		double cx = ((p3x + p4x) / 2);
		double cy = ((p3y + p4y) / 2);
		double dx = ((ax + bx) / 2);
		double dy = ((ay + by) / 2);
		double ex = ((bx + cx) / 2);
		double ey = ((by + cy) / 2);
		double fx = ((dx + ex) / 2);
		double fy = ((dy + ey) / 2);

                // plots new points for the modified curve
		Point2D.Double p = new Point2D.Double(px, py); 
		Point2D.Double a = new Point2D.Double(ax, ay); 
		Point2D.Double d = new Point2D.Double(dx, dy);
		Point2D.Double f = new Point2D.Double(fx, fy);
		Point2D.Double e = new Point2D.Double(ex, ey);
		Point2D.Double c = new Point2D.Double(cx, cy);
		Point2D.Double p2 = new Point2D.Double(p4x, p4y);

		if (location.equals("right")) {
			latestNewCurve.add(f);
			latestNewCurve.add(e);
			latestNewCurve.add(c);
			latestNewCurve.add(p2);
		}

		if (location.equals("left")) {
			latestNewCurve.add(p);
			latestNewCurve.add(a);
			latestNewCurve.add(d);
			latestNewCurve.add(f);
		}

		if (location.equals("middle")) {
			latestNewCurve.add(f);
		}

		return latestNewCurve;
	}
        //Gets the list of points
	public ArrayList<Point2D.Double> points(double px,double py,double px2,double py2,double px3,double py3,double px4,double py4,int x,ArrayList<Point2D.Double> list) {

		if (x == 0) {
			return list;
		}

		else {
			ArrayList<Point2D.Double> t = midPoint(px, py, px2, py2, px3, py3, px4, py4, "middle");

			list.add(t.get(0));

			ArrayList<Point2D.Double> left = midPoint(px, py, px2, py2, px3, py3, px4, py4, "left");

			double point1x = left.get(0).x;
			double point1y = left.get(0).y;
			double ax = left.get(1).x;
			double ay = left.get(1).y;
			double dx = left.get(2).x;
			double dy = left.get(2).y;
			double fx = left.get(3).x;
			double fy = left.get(3).y;
			points(point1x, point1y, ax, ay, dx, dy, fx, fy, x - 1, list);

			ArrayList<Point2D.Double> right = midPoint(px, py, px2, py2, px3, py3, px4, py4, "right");
			double fx2 = right.get(0).x;
			double fy2 = right.get(0).y;
			double ex = right.get(1).x;
			double ey = right.get(1).y;
			double cx = right.get(2).x;
			double cy = right.get(2).y;
			double point4x = right.get(3).x;
			double point4y = right.get(3).y;
			points(fx2, fy2, ex, ey, cx, cy, point4x, point4y, x - 1, list);

			return list;
                }
	}

	/* Checks if the rectangle is contained within the applet
         * window.  If the rectangle is not contained withing the
         * applet window, it is redrawn so that it is adjacent to the
         * edge of the window and just inside the window.  */

	void checkPoint(){
		
		if (area == null) {
			return;
		}

		if((area.contains(rect)) && (area.contains(point))){
			return;
		}
		int new_x = rect.x;
		int new_y = rect.y;

		double new_px = point.x;
		double new_py = point.y;

		if((rect.x+rect.width)>area.getWidth()){
			new_x = (int)area.getWidth()-(rect.width-1);
		}
		if(point.x > area.getWidth()){
			new_px = (int)area.getWidth()-1;
		}
		if(rect.x < 0){  
			new_x = -1;
		}
		if(point.x < 0){
			new_px = -1;
		}
		if((rect.y+rect.width)>area.getHeight()){
			new_y = (int)area.getHeight()-(rect.height-1);
		}
		if(point.y > area.getHeight()){
			new_py = (int)area.getHeight()-1;
		}
		if(rect.y < 0){  
			new_y = -1;
		}
		if(point.y < 0){
                        new_py = -1;
                }
		rect.setLocation(new_x, new_y);
		point.setLocation(new_px, new_py);

	}
}
class sortByX implements Comparator<Point2D.Double> {
	public int compare(Point2D.Double one, Point2D.Double two) {
		int x = (int) (((Point2D.Double) one).getX() - ((Point2D.Double) two)
				.getX());
		return x;
	}
}
