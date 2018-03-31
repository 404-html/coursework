public class DNAStrand {
    
	private String DNA;
	
	public DNAStrand(String dna){
    	this.DNA = dna;
	}

    public boolean isValidDNA(){
    	return DNA.matches("[ATCG]+");
    }
    
	public String complementWC(){
		String s = DNA;
		for (int i = 0;i<DNA.length();i++){
			if (DNA.charAt(i)=='A'){s = s.substring(0,i)+'T'+s.substring(i+1);}else{
				if (DNA.charAt(i)=='T') {s = s.substring(0,i)+'A'+s.substring(i+1);}else{
					if (DNA.charAt(i)=='C'){s = s.substring(0,i)+'G'+s.substring(i+1);}else{
						if (DNA.charAt(i)=='G') {s = s.substring(0,i)+'C'+s.substring(i+1);}}}}
		}
		return s;
	}
	
	public String palindromeWC(){
		String s = new StringBuffer(DNA).reverse().toString();
		for (int i = 0;i<DNA.length();i++){
			if (s.charAt(i)=='A'){s = s.substring(0,i)+'T'+s.substring(i+1);}else{
				if (s.charAt(i)=='T') {s = s.substring(0,i)+'A'+s.substring(i+1);}else{
					if (s.charAt(i)=='C'){s = s.substring(0,i)+'G'+s.substring(i+1);}else{
						if (s.charAt(i)=='G') {s = s.substring(0,i)+'C'+s.substring(i+1);}}}}
		}
		return s;
	}
	
    public boolean containsSequence(String seq){
    	return DNA.matches("(.*)" + seq + "(.*)");
    }
    
    public String toString(){
    	return DNA;
    }
}
