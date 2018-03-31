public class FixedDivider {
 public static void main( String[] args ){
  double num1 = Double.parseDouble(args[0]);
  double num2 = Double.parseDouble(args[1]);
  if (num2 == 0) {
  System.out.println( "Why are you so DIAO?" );
  } else { 
  System.out.println( Math.max(num1, num2) );
  }
 }
}
