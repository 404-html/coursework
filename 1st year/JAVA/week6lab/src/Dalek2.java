public class Dalek2 {
	
	private String[] say = {};
	
	public void setSayings(String[] s) {
		say = s;
	}
	
	public void speak() {
		if (say.length == 0) {
			System.out.println("No utterances installed!");
		}else{
			System.out.println(say[(int) (Math.random() * say.length)]);
		}
		
	}
	
	public static void main(String[] args) {
		Dalek2 d1 = new Dalek2();
		String[] u1 = { "Exterminate, Exterminate!", "I obey!",
				"Exterminate, annihilate, DESTROY!", "You cannot escape.",
				"Daleks do not feel fear.", "The Daleks must survive!" };
		d1.setSayings(u1);

		System.out.println("\nDalek d1 says: ");
		for (int i = 0; i < 10; i++) {
			d1.speak();
		}

		System.out.println("\nDalek d2 says: ");
		Dalek2 d2 = new Dalek2();
		String[] u2 = { "I obey!" };
		d2.setSayings(u2);

		for (int i = 0; i < 10; i++) {
			d2.speak();
		}
		
		System.out.println("\nDalek d3 says: ");
		Dalek2 d3 = new Dalek2();
		String[] u3 = { "Java sucks! SUCKS!" };
		d3.setSayings(u3);
		d3.speak();
	}
}
