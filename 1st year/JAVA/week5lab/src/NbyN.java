
public class NbyN {
	public static int[][] nbyn(int N){
		int[][] matrix = new int[N][N];
		for (int i=0;i<N;i++) {
			for (int a=0;a<N;a++) {
				if (a==i) {matrix[i][a] = a;} else {matrix[i][a] = 0;}			
			}
		}  
		return matrix;
	}
	
	public static void main( String[] args ) {
		int num = 10;
		for (int i=0;i<num;i++) {
			for (int a=0;a<num;a++) {
				System.out.print(nbyn(num)[i][a] + " ");
			}
			System.out.println("");
		}
	}
	
}