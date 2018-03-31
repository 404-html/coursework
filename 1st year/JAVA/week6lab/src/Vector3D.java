public class Vector3D {

	private double x;
	private double y;
	private double z;
	
	public Vector3D(double x, double y, double z){
		this.x=x;
		this.y=y;
		this.z=z;
	}
	
	public double getR(){
		double r = Math.sqrt(x*x+y*y+z*z);
		return r;
	}
	
	public double getTheta(){
		double t = Math.acos(z/getR());
		return t;
	}
	
	public double getPhi(){
		double p = Math.atan2(y,x);
		return p;
	}
	
	public static Vector3D add(Vector3D lhs, Vector3D rhs){
		double x = lhs.x + rhs.x;
		double y = lhs.y + rhs.y;
		double z = lhs.z + rhs.z;
		Vector3D n = new Vector3D(x,y,z);
		return n;
	}
	
	public static Vector3D subtract(Vector3D lhs, Vector3D rhs){
		double x = lhs.x - rhs.x;
		double y = lhs.y - rhs.y;
		double z = lhs.z - rhs.z;
		Vector3D n = new Vector3D(x,y,z);
		return n;
	}
	
	public static Vector3D scale( Vector3D v, double scaleFactor){
		double x = v.x * scaleFactor;
		double y = v.y * scaleFactor;
		double z = v.z * scaleFactor;
		Vector3D n = new Vector3D(x,y,z);
		return n;
	}
}
