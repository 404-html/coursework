public class Sieve {
 public static void main( String[] args ) {
  int length = Integer.parseInt(args[0]) + 1 ;
  int[] num = new int[length];
  for (int count = 0 ; count < length ; count++ ) {
   num[count] = count ;}
  for (int i = 2 ; i < length ; i++ ) {
   if (num[i] != 0 ) {
    System.out.print(i + " ");
    for (int a = 0 ; a < length ; a++ ) {
     if ((num[a] % i) == 0) {num[a] = 0;}
    }
   }
  }
  System.out.println("");
 }
}
