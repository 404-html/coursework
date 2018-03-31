public class DateFashion {
    public static int seat(int you, int date) {
     int a;
	 if (you <= 2) {a = 0;}else{
         if (date <= 2) {a = 0;}else{
        	 if (you >= 8) {a = 2;}else{
        		 if (date >= 8) {a = 2;}else{a = 1;}}}}
	return a;
    }

    public static void main(String[] args) {
        int you = Integer.parseInt(args[0]);
        int date = Integer.parseInt(args[1]);
        System.out.println(seat(you,date));
    }
}
