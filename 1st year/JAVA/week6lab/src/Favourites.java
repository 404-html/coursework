public class Favourites {
	
	private MusicTrack[] fav = new MusicTrack[5];
	
	public void addTrack(String s1 , String s2) {
		if (fav[0] == null) {fav[0] = new MusicTrack(s1,s2);}else{
			if (fav[1] == null) {fav[1] = new MusicTrack(s1,s2);}else{
				if (fav[2] == null) {fav[2] = new MusicTrack(s1,s2);}else{
					if (fav[3] == null) {fav[3] = new MusicTrack(s1,s2);}else{
						if (fav[4] == null) {fav[4] = new MusicTrack(s1,s2);}else{
							System.out.println("Sorry, can't add: " + s2 + " | " +s1);
							System.out.println();
						}
					}
				}
			}
		}
	}

	public void showFavourites() {
		for (int i = 0; i < 5; i++){
			if (fav[i]==null) {i=5;}else{
				System.out.println(fav[i].toString());
			}
		}
	}
	
	public static void main(String[] args){
		Favourites favourites = new Favourites();
		favourites.addTrack("Fun", "Some Nights");
		favourites.addTrack("Oliver Tank", "Help You Breathe");
		favourites.addTrack("Horse Feathers", "Fit Against the Country");
		favourites.addTrack("Emile Sande", "Country House");
		favourites.addTrack("Fun", "Walking the Dog");
		favourites.addTrack("Porcelain Raft", "Put Me To Sleep");
		favourites.showFavourites();
	}
}
