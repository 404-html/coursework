public class SquareLoopRange {
 public static void main( String[] args ){
  boolean test = (args.length == 2);
  if (test) {
   int num1 = Integer.parseInt(args[0]);
   int num2 = Integer.parseInt(args[1]);
   if (num2 < num1) {
    System.out.println("REALLY!?");
   } else {
    for (int count = num1; count <= num2; count++) {
        System.out.print((count * count) + " ");
    }
    System.out.println("");
   }
  } else {
  System.out.println("1 4 9 16 25 36 49 64 81 100");
  }
 }
}
