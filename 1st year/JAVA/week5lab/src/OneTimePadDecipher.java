
public class OneTimePadDecipher {
	public static String decipher(String encipheredText, String onetimepad){
		char[] a = new char[encipheredText.length()];
    	for (int i = 0 ; i < encipheredText.length(); i++){
    		a[i] = OneTimePadEncipher.intToChar((26 +
    				                             OneTimePadEncipher.charToInt(encipheredText.charAt(i))
    				                             -
    				                             OneTimePadEncipher.charToInt(onetimepad.charAt(i))
    				                             )%26);}
        String b = new String(a);
        b = b.toUpperCase();
        return b;
	}
	
	public static void main(String[] args) {
	      String ciphertext = decipher("uvufsghktdal", "WHATSTHEPASSWORD");
	      String ciphertext2 = decipher("wconlahzgzgleuai", "YOULLNEVERREADMYONETIMEPAD");
	      System.out.println(ciphertext);
	      System.out.println(ciphertext2);
	    }
}
