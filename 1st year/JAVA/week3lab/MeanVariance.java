public class MeanVariance {
 public static void main( String[] args ) {
  double num = 0;
  for (int count = 0 ; count < args.length ; count++ ) {
   num = num + Double.parseDouble(args[count]); 
  }
  double mean = num / args.length ;
  double num2 = 0;
  for (int count = 0 ; count < args.length ; count++ ) {
   num2 = num2 + Math.pow((Double.parseDouble(args[count]) - mean), 2);
  }
  double var = num2 / args.length;
  System.out.println(mean);
  System.out.println(var);
 }
}
