
public class SplitPathName {
	public static String[] splitPath(String s){
		int a = s.lastIndexOf("/");
		int b = s.lastIndexOf(".");
		String[] components = new String[4];
		components[0] = s.substring(0,a+1);
		components[1] = s.substring(a+1);
		if (b!=-1) {
			components[2] = s.substring(a+1,b);
		    components[3] = s.substring(b);
		}else{
			components[2]=components[1];
			components[3]="";}
		return components;
	}
	
	public static void main( String[] args ){
		for (int i=0;i<args.length;i++) {
				System.out.println("File: " + splitPath(args[i])[1] 
					             + " Type: " + splitPath(args[i])[3]
					             + " [" + splitPath(args[i])[0] + "]");
		}
	}
}
