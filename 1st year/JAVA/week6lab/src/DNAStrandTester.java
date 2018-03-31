
public class DNAStrandTester {
	public static void main(String[] args) {
	    System.out.println("Original DNA Sequence: " + "AGTC");
	    DNAStrand dna = new DNAStrand("AGTC");
	    if (dna.isValidDNA()) {
	        System.out.println("Is valid");
	        System.out.println("Complement: " + dna.complementWC());
	        System.out.println("WC Palindrome: " + dna.palindromeWC());
	    } 
	    else {
	        System.out.println("Not Valid DNA");
	    }
	}
}
