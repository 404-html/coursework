public class MutiplesLoopRange {
 public static void main( String[] args ){
  boolean test = (args.length == 3);
  if (test) {
   int num1 = Integer.parseInt(args[0]);
   int num2 = Integer.parseInt(args[1]);
   int num3 = Integer.parseInt(args[2]);
   int newnum1 = num1 - (num1 % num3) + num3;
   int newnum2 = num2 - (num2 % num3) + num3;
   if (num2 < num1) {
    for (int count = newnum2; (count >= num1); count = count - num3) {
        System.out.print(count + " "); }
    System.out.println("");
   } else {
    for (int count = newnum1; (count <= num2); count = count + num3) {
        System.out.print(count + " "); }
    System.out.println("");
   }
  } else { System.out.println("Oh gosh. U R missing something."); }
 }
}
