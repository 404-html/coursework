package music;

import java.util.ArrayList;

public class Favourites {
	
	private ArrayList<MusicTrack> fav = new ArrayList<MusicTrack>();
	
	public void addTrack(String s1 , String s2) {
		fav.add(new MusicTrack(s1,s2));
	}

	public void showFavourites() {
		for (int i = 0; i < fav.size(); i++){
			System.out.println(fav.get(i).toString());
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
