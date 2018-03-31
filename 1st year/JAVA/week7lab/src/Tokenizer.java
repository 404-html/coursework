import java.util.ArrayList;

public class Tokenizer {

	private ArrayList<String> token = new ArrayList<String>();
	
	public Tokenizer(){}
	
	public Tokenizer(String fname){
		tokensFromFile(fname);
	}
	
	public void tokensFromFile(String fname){
		In file = new In(fname);
		String s = file.readAll();
		String[] words = s.split("\\W+");
		for (int i=0;i<words.length;i++){
			token.add(words[i]);
		}
	}
	
	public void tokenize(String str){
		token.clear();
		String[] words = str.split("\\W+");
		for (int i=0;i<words.length;i++){
			token.add(words[i]);
		}
	}
	
	public String[] getTokens(){
		String[] s = new String[token.size()];
		for (int i=0;i<token.size();i++){
			s[i] = token.get(i);
		}
		return s;
	}
	
	public int getNumberTokens(){
		return token.size();
	}
	
	public static void main( String[] args ){
		Tokenizer t0 = new Tokenizer();
		String sent0 = "this is some text\n and--here\tis more; And 'more' text";
		t0.tokenize(sent0);
		String[] tokens0 = t0.getTokens();
		for (int i =0;i<tokens0.length;i++){
			System.out.print(tokens0[i]+" ");
		}
		System.out.println();

		Tokenizer t1 = new Tokenizer();
		String sent1 = "Together we can change the world.";
		t1.tokenize(sent1);
		String[] tokens1 = t1.getTokens();
		for (int i =0;i<tokens1.length;i++){
			System.out.print(tokens1[i]+" ");
		}
		System.out.println();
	}
}
