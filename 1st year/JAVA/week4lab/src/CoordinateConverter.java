
public class CoordinateConverter {

    public static double convertXYtoR(double x, double y) {
    	double i = Math.sqrt(x*x+y*y);
    	return i;
    }

    public static double convertXYtoT(double x, double y) {
    	double theta = Math.atan2(y,x);
        return theta;
    }

    public static double convertRTtoX(double r, double theta) {
        double x = Math.cos(theta) * r;
        return x;
    }

    public static double convertRTtoY(double r, double theta) {
    	double x = Math.sin(theta) * r;
        return x;
    }

    public static double convertDegToRad(double deg) {
    	double radians = Math.toRadians(deg);
    	return radians;
    }

    public static double convertRadToDeg(double rad) {
    	double deg = Math.toDegrees(rad);
    	return deg;
    }
    
}
