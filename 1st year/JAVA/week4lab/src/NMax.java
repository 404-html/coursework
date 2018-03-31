
public class NMax {
    public static int max(int a, int b, int c) {
     int i = 0;
	 if ((a >= b)&&(a >= c)) {i = a;} else {
      if (b >= c) {i = b;} else {i = c;}}
	 return i;
    }
    public static double max(double a, double b, double c) {
     double i = 0;
     if ((a >= b)&&(a >= c)) {i = a;} else {
      if (b >= c) {i = b;} else {i = c;}}
     return i;
       }
}
