public class QuadraticSolver {
 public static void main( String[] args ){
  double num1 = Double.parseDouble(args[0]);
  double num2 = Double.parseDouble(args[1]);
  double num3 = Double.parseDouble(args[2]);
  double delta = (num2 * num2 - 4 * num1 * num3);
  boolean test = delta<0;
  if (test) {
             System.out.println("You got an ERROR, dude!");
            }
  else {
             System.out.println((0 - num2 + Math.sqrt(delta))/ (2 * num1));
       };
  if (test) {
             System.out.println("Why are you so STOOPID, dude!");
            }
  else {
             System.out.println((0 - num2 - Math.sqrt(delta))/ (2 * num1));
       };
 }
}
