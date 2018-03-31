public class OneTimePadEncipher {

    public static int charToInt(char l) {
      int i = (int)(Character.toLowerCase(l)) - 97; 
      return i;
    }

    public static char intToChar(int i) {
      char c = ' ';
      if (i == 0) {c = 'a';}
      if (i == 1) {c = 'b';}
      if (i == 2) {c = 'c';}
      if (i == 3) {c = 'd';}
      if (i == 4) {c = 'e';}
      if (i == 5) {c = 'f';}
      if (i == 6) {c = 'g';}
      if (i == 7) {c = 'h';}
      if (i == 8) {c = 'i';}
      if (i == 9) {c = 'j';}
      if (i == 10) {c = 'k';}
      if (i == 11) {c = 'l';}
      if (i == 12) {c = 'm';}
      if (i == 13) {c = 'n';}
      if (i == 14) {c = 'o';}
      if (i == 15) {c = 'p';}
      if (i == 16) {c = 'q';}
      if (i == 17) {c = 'r';}
      if (i == 18) {c = 's';}
      if (i == 19) {c = 't';}
      if (i == 20) {c = 'u';}
      if (i == 21) {c = 'v';}
      if (i == 22) {c = 'w';}
      if (i == 23) {c = 'x';}
      if (i == 24) {c = 'y';}
      if (i == 25) {c = 'z';}
      return c;
    }

    public static boolean isAlpha(char c) {
    	boolean a = Character.isLetter(c);
    	return a;
    }

    public static String encipher(String original, String onetimepad) {
    	char[] a = new char[original.length()];
    	for (int i = 0 ; i < original.length(); i++){
    		a[i] = intToChar((charToInt(original.charAt(i))+
    				          charToInt(onetimepad.charAt(i)))%26);}
        String b = new String(a);
        return b;
    }


    public static void main(String[] args) {
      String ciphertext = encipher("HELLO", "XMCKL");
      System.out.print(ciphertext);
    }

}