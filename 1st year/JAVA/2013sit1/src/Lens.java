public class Lens {
	
	public static Pair[] get(String[] source) {
		Pair[] s = new Pair[source.length];
		for (int i = 0; i<source.length ; i++){
			s[i] = new Pair(source[i].charAt(0),source[i].length());
		}
		return s;
	}
	
	public static String[] create(Pair[] view) {
		String[] s = new String[view.length];
		for (int i = 0; i<view.length ; i++){
			s[i] = view[i].getChar() +"";
			for (int a = 1; a < view[i].getInt();a++){
				s[i] += "X";
			}
		}
		return s;
	}
	
	public static String[] put(String[] oldSource, Pair[] newView) {
		if (!(oldSource.length == newView.length)) {
			throw new RuntimeException("Length of view and source didn't match");
		}
		for (int i = 0 ; i < oldSource.length;i++){
			if (!(oldSource[i].charAt(0) == newView[i].getChar())) {
				throw new RuntimeException("First characters don't match");
			}
		}
		String[] o = new String[oldSource.length];
		for (int i = 0 ; i < o.length ; i++){
			if(newView[i].getInt()>=oldSource[i].length()){
				o[i] = oldSource[i];
				for(int a = 0;a<newView[i].getInt()-oldSource[i].length();a++){
					o[i] += "X";
				}
			}else{
				o[i] = oldSource[i].substring(0,newView[i].getInt());
			}
		}
		return o;
	}
}
