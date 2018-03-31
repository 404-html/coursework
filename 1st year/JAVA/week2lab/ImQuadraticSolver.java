public class ImQuadraticSolver {
 public static void main( String[] args ){
  double num1 = Double.parseDouble(args[0]);
  double num2 = Double.parseDouble(args[1]);
  double num3 = Double.parseDouble(args[2]);
  double delta = (num2 * num2 - 4 * num1 * num3);
  double sqrtd = Math.sqrt(Math.abs(delta));
  boolean test = delta<0;
  if (num1 != 0) {
   if (test) {
              System.out.println((0 - num2)/(2 * num1) + " + " + (sqrtd/(2 * num1)) + "i");
              System.out.println((0 - num2)/(2 * num1) + " - " + (sqrtd/(2 * num1)) + "i");
   } else {
              System.out.println((0 - num2 + sqrtd)/ (2 * num1));
              System.out.println((0 - num2 - sqrtd)/ (2 * num1)); }
  } else {
  System.out.println((0 - num3)/num2); }
 }
}
