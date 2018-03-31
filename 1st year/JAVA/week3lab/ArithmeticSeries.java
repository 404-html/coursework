public class ArithmeticSeries {
 public static void main( String[] args ) {
  int num = 0;
  for (int count = 1 ; count <= Integer.parseInt(args[0])  ; count++) {
   num = num + count;
  }
  System.out.println(num);
 }
}

