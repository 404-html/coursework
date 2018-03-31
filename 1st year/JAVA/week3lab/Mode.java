//import java.util.Arrays;

public class Mode {
	public static void main(String[] args) {

		int[] count = new int[10];

		for (int a = 0; a < args.length; a++) {
			count[Integer.parseInt(args[a])]++;
			}
		
		for (int i = 0; i < count.length; i++) {
			System.out.print("[" + i + "s: " + count[i] + "] ");
			for (int a = 0; a < count[i]; a++) {
				System.out.print(".");
			}
			System.out.println("");
		}

		int mode = Integer.MIN_VALUE;
		for (int i = 0; i < 10; i++) {
			if (count[i] > mode) {
				mode = i;
			}
		}
		System.out.println("Mode: " + mode);
	}
}
