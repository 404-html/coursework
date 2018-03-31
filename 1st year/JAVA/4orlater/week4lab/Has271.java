public class Has271 {
    public static boolean trip(int[] nums) {
	boolean a = false;
	int l = nums.length - 2;
        for (int i = 0 ; i < l ; i++) {
         a = a || ((nums[i] == nums[i+1]-5) && (nums[i+1] == nums[i+2]+6));}
	return a;	 
    }

    public static void main(String[] args) {
        int N = args.length;
        int[] nums = new int[N];
        for (int i = 0; i < N; i++) {
            nums[i] = Integer.parseInt(args[i]);
        }
        System.out.println(trip(nums));
    }
}
