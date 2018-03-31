import java.util.ArrayList;

public class Dalek3 {

	private ArrayList<String> say = new ArrayList<String>();

	public void setSayings(String[] s) {
		for (int i=0;i<s.length;i++){
			say.add(s[i]);
		}
	}

	public void speak() {
		if (say.size() == 0) {
			System.out.println("No utterances installed!");
		} else {
			System.out.println(say.get((int) (Math.random() * say.size())));
		}
	}

	public void addSaying(String s){
		say.add(s);
	}
	
	public static void main(String[] args) {
		Dalek3 d1 = new Dalek3();
		String[] u1 = { "Exterminate, Exterminate!", "I obey!",
				"Exterminate, annihilate, DESTROY!", "You cannot escape.",
				"Daleks do not feel fear.", "The Daleks must survive!" };
		d1.setSayings(u1);

		System.out.println("\nDalek d1 says: ");
		for (int i = 0; i < 10; i++) {
			d1.speak();
		}

		System.out.println("\nDalek d2 says: ");
		Dalek3 d2 = new Dalek3();
		String[] u2 = { "I obey!" };
		d2.setSayings(u2);

		for (int i = 0; i < 10; i++) {
			d2.speak();
		}
	}
}
