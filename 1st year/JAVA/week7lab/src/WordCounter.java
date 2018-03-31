import java.util.Collections;
import java.util.HashMap;
import java.util.ArrayList;

public class WordCounter {
	
	private ArrayList<Integer> length = new ArrayList<Integer>();
	
	public WordCounter(String[] tokens){
		for (int i=0;i<tokens.length;i++){
			length.add(tokens[i].length());
		}
	}
	
	public void wordLengthFreq(String[] tokens){
		length.clear();
		for (int i=0;i<tokens.length;i++){
			length.add(tokens[i].length());
		}
	}
    
	public int Frequency(int i){
		int a = 0;
		for (int c=0;c<length.size();c++){
			if (length.get(c)==i){a++;}
		}
		return a;
	}
	
	public HashMap<Integer, Integer> getFreqDist(){
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
        for (int i = 0; i < maxLength(); i++) {
            if(Frequency(i)>0){map.put(i, Frequency(i));}
        }
        return map;
	}
    
	public int maxLength(){
		int a=0;
		for (int i=0;i<length.size();i++){
			if(length.get(i)>a){a=length.get(i)+1;}
		}
		return a;
		//return Collections.max(length);
	}
	
	public int maxVal(){
		int a = 0;
		for (int i = 0; i < maxLength(); i++){
			if(Frequency(i)>a){
				a=Frequency(i);
			}
		}
		return a;
	}

	public double[] map2array(){
		double[] a = new double[maxLength()];
		for (int i =0;i<maxLength();i++){
			a[i]=(double)(Frequency(i)*100)/maxVal();
		}
		return a;
	}
	
	public static void main(String[] args){
		String INPUT_TEXT = 
	            "Sixteen years had Miss Taylor been in Mr. Woodhouse's family, less as a "
	            + "governess than a friend, very fond of both daughters, but particularly "
	            + "of Emma. Between _them_ it was more the intimacy of sisters. Even before "
	            + "Miss Taylor had ceased to hold the nominal office of governess, the";

	    String[] TOKENS;

	    Tokenizer tokenizer = new Tokenizer();
        tokenizer.tokenize(INPUT_TEXT);
        TOKENS = tokenizer.getTokens();
        
        WordCounter WC = new WordCounter(TOKENS);
        double[] a = WC.map2array();
        for (int i = 0;i<a.length;i++){
        	System.out.print(a[i]+" ");
        }
        System.out.println();
        WC.wordLengthFreq(new String[] {"other"});
        a = WC.map2array();
        System.out.println(WC.Frequency(5));
        System.out.println(WC.maxVal());
        for (int i = 0;i<a.length;i++){
        	System.out.print(a[i]+" ");
        }
	}
}
