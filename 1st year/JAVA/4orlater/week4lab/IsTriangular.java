public class IsTriangular {
    public static boolean isTri(double a, double b, double c) {
	boolean k = false;
	if (a * a + b * b == c * c){k=true;}
	if (a * a + c * c == b * b){k=true;}
	if (b * b + c * c == a * a){k=true;}
	return k;	 
    }

    public static void main(String[] args) {
     double a = StdIn.readDouble();
     double b = StdIn.readDouble();
     double c = StdIn.readDouble();    
     if (isTri(a, b, c)) {
        System.out.printf("%s, %s and %s could be the lengths of a triangle\n", a, b, c);
     } else {
        System.out.println("Not a triangle.");
     }
    }
}
