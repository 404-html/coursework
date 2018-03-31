public class Distance {
 public static void main( String[] args ){
  int num1 = Integer.parseInt(args[0]);
  int num2 = Integer.parseInt(args[1]);
  System.out.println(Math.max( num1, num2) - Math.min( num1, num2 ));
 }
}
