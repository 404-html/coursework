import java.util.Arrays;

public class TempMedian {
 public static void main( String[] args ) {
  int[] temp = new int[args.length];
  temp[0] = Integer.parseInt(args[0]);
  for (int count = 1 ; count < args.length ; count++ ) {
   if (args[count].equals(".")) {temp[count] = temp[count-1];} else {
    if (args[count].equals("+")) {temp[count] = temp[count-1] + 1 ;} else {
     if (args[count].equals("-")) {temp[count] = temp[count-1] - 1 ;} else {
      temp[count] = 0;
      System.out.println("Error in input!");}}}}
  for (int count = 0 ; count < args.length ; count++ ) {
   System.out.print(temp[count] + " ");}
  System.out.println(""); 
  Arrays.sort(temp);
  for (int count = 0 ; count < args.length ; count++ ) {
   System.out.print(temp[count] + " ");}
  System.out.println(""); 
  double median;
  if ((args.length & 1) == 0) {
   median = (double) ( temp[args.length / 2] + temp[args.length / 2 - 1] ) / 2 ;} else {
   median = temp[(args.length - 1) / 2];}
  System.out.println(median);
 }
}
