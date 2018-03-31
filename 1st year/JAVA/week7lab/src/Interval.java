public class Interval {

	private double left;
	private double right;
	
	public Interval(double left, double right){
		 this.left=left;
		 this.right=right;
	}
	 
	public boolean doesContain(double x){
		return (x>=left) && (x<=right);
	}
	
	public boolean isEmpty(){
		return (left>right);
	}
	
	public boolean intersects(Interval b){
		boolean i1 = (left <= b.left)&&(right >= b.left);
		boolean i2 = (right >= b.right)&&(left <= b.right);
		return (!isEmpty()) && (!b.isEmpty()) && (i1||i2);
	}
	
	public String toString(){
		String s = "";
		if (isEmpty()) {
			s = "Interval: (EMPTY)";
		}else{
			s = "Interval: [" + left + ", " + right + "]";
		}
		return s;
	}
}
