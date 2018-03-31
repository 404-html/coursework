public class InvestigateLens {
	
	public static boolean checkGetPut(String[] oldSource, Pair[] newView){
		Pair[] a = Lens.get(Lens.put(oldSource, newView));
		boolean out = true;
		for (int i = 0; i<oldSource.length;i++){
			out = out && (a[i].getChar()==newView[i].getChar())
					  && (a[i].getInt() ==newView[i].getInt ());
		}
		return out;
	}
	
	public static void main(String[] args){
		String[] s1 = {"foo"};
		String[] s2 = {"foo", "bar", "froboz"};
		String[] s3 = {"foo", "bar", "froboz"};
		Pair[] v1 = {new Pair('f',7)};
		Pair[] v2 = {new Pair('f',7),new Pair('b',3),new Pair('f',6)};
		Pair[] v3 = {new Pair('f',2),new Pair('b',5),new Pair('f',3)};
		boolean t1 = checkGetPut(s1,v1);
		boolean t2 = checkGetPut(s2,v2);
		boolean t3 = checkGetPut(s3,v3);
		System.out.println(t1);
		System.out.println(t2);
		System.out.println(t3);
		System.out.println(t1&&t2&&t3);
	}
}
