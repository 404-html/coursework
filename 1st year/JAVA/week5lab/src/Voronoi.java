import java.awt.Color;

public class Voronoi {

    public static double pointDist(Point2D point1, Point2D point2) {
        double num1 = point1.getX() - point2.getX();
        double num2 = point1.getY() - point2.getY();
    	double dist = Math.sqrt(num1*num1+num2*num2);
    	return dist;
    }

    public static int findClosestPoint(Point2D point, Point2D[] sites) {
        double[] dist = new double[sites.length];
        for (int c=0;c<sites.length;c++){
        	dist[c] = pointDist(point,sites[c]);}
        int d = 0;
        double e = Double.MAX_VALUE;
        for (int c=0;c<sites.length;c++){
        	if (e >= dist[c]) {
        		d = c;
        		e = dist[c];}}
        return d;
    }

    public static int[][] buildVoronoiMap(Point2D[] sites, int width, int height) {
    	int[][] matrix = new int[width][height];
    	//Point2D p;
		for (int i=0;i<height;i++) {
			for (int a=0;a<width;a++) {
				Point2D p = new Point2D(a,i);
				matrix[a][i] = findClosestPoint(p,sites);			
			}
		} 
		return matrix;
    }

    public static void plotVoronoiMap(Point2D[] sites, Color[] colors, int[][] indexMap) {
    	int width = indexMap.length;
    	int height = indexMap[0].length;

    	StdDraw.setCanvasSize(width, height);
    	StdDraw.setXscale(0, width);
    	StdDraw.setYscale(0, height);
    	
    	for (int y=0;y<height;y++) {
			for (int x=0;x<width;x++) {
				StdDraw.setPenColor(colors[indexMap[x][y]]);
				StdDraw.point(x, y);}}
    	
    	for (int i = 0;i < sites.length; i++){
    		StdDraw.setPenColor(Color.BLACK);
        	StdDraw.filledCircle(sites[i].getX(),sites[i].getY(),3);
    	}
    }

    public static void main(String[] args) {
        int width = 200;
        int height = 200;

        int nSites = 5;
        Point2D[] sites = new Point2D[nSites];
        sites[0] = new Point2D(50, 50);
        sites[1] = new Point2D(100, 50);
        sites[2] = new Point2D(50, 100);
        sites[3] = new Point2D(125, 50);
        sites[4] = new Point2D(100, 175);

        Color[] colors = new Color[nSites];
        colors[0] = Color.BLUE;
        colors[1] = Color.GREEN;
        colors[2] = Color.YELLOW;
        colors[3] = Color.ORANGE;
        colors[4] = Color.MAGENTA;

        int[][] indexmap = buildVoronoiMap(sites, width, height);
        plotVoronoiMap(sites, colors, indexmap);

    }

}