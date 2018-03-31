import java.util.ArrayList;

public class VideoStore {
	
	private ArrayList<Video> video = new ArrayList<Video>();
	
	public boolean addVideo(String title){
		boolean a=false;
		for (int i=0;i<video.size();i++){
			if ((video.get(i)).getTitle()==title){a=true;}
		}
		if (a) {
			System.out.println(title+" is already in stock.");
			return false;
		}else{
			video.add(new Video(title));
			return true;
		}
	}
	
	public Video getVideo(String title){
		int a=0;
		boolean b=true;
		for (int i=0;i<video.size();i++){
			if ((video.get(i)).getTitle()==title){a=i;b=false;}
		}
		if(b){
			System.out.println("Sorry, cannot find the requested video in the catalogue");
			return null;
		}else{			
			return video.get(a);
		}
	}
	
	public boolean checkOutVideo(String title){
		int a=0;
		boolean b=false;
		for (int i=0;i<video.size();i++){
			if ((video.get(i)).getTitle()==title){a=i;b=true;}
		}
		if(b){
			return (video.get(a)).checkOut();
		}else{
			System.out.println("Sorry, cannot find the requested video in the catalogue");
			return false;
		}
	}
	
	public boolean returnVideo(Video vid){
		int a=0;
		boolean b=false;
		for (int i=0;i<video.size();i++){
			if (video.get(i)==vid){a=i;b=true;}
		}
		if(b){
			return (video.get(a)).returnToStore();
		}else{
			System.out.println("Sorry, this video did not come from this store");
			return false;
		}
	}

	public void rateVideo(Video vid, int rating){
		int a=0;
		boolean b=true;
		for (int i=0;i<video.size();i++){
			if ((video.get(i)).getTitle()==vid.getTitle()){a=i;b=false;}
		}
		if(b){
			System.out.println("Sorry, cannot find the requested video in the catalogue");
		}else{	
			(video.get(a)).addRating(rating);
		}
	}

	public double getAverageRatingForVideo(Video vid){
		int a=0;
		boolean b=true;
		for (int i=0;i<video.size();i++){
			if ((video.get(i)).getTitle()==vid.getTitle()){a=i;b=false;}
		}
		if(b){
			System.out.println("Sorry, cannot find the requested video in the catalogue");
			return 0;
		}else{	
			return (video.get(a)).getAverageRating();
		}
	}

	public Video[] getCheckedOut(){
		int a = 0;
		for (int i=0;i<video.size();i++){
			if (video.get(i).isCheckedOut()){a++;}
		}
		Video[] b = new Video[a];
		int c = 0;
		for (int i=0;i<video.size();i++){
			if (video.get(i).isCheckedOut()){b[c]=video.get(i);c++;}
		}
		return b;
	}
	
	public Video mostPopular(){
		double[] a = new double[video.size()];
		for (int i=0;i<video.size();i++){
			a[i] = video.get(i).getAverageRating();
		}
		double b = -1;
		int c = -1;
		for (int i=0;i<video.size();i++){
			if (video.get(i).getAverageRating()>b){
				b=video.get(i).getAverageRating();
				c=i;}
		}
		return video.get(c);
	} 
	
	public static void main(String[] args){
		VideoStore videoStore = new VideoStore();
        videoStore.addVideo("Tron");
        System.out.println(videoStore.getVideo("Tron").getTitle());
        Video unknownVideo = new Video("Tron");
        System.out.println(videoStore.returnVideo(unknownVideo));
	}
}
