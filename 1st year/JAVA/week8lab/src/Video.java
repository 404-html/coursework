public class Video {
	
	private String title;
	private boolean avail;
	private double avera;
	private double ranum;
	
	public Video(String title){
		this.title=title;
		this.avail=true;
		this.avera=0;
		this.ranum=0;
	}
	
	public String getTitle(){
		return title;
	}
	
	public boolean addRating(int rating){
		if(rating>=1 &&rating<=5){
			avera=(double)((double)avera*ranum+rating)/(ranum+1);
			ranum++;
			return true;
		}else{
			System.out.println(rating+" should be between 1 and 5.");
			return false;
		}
	}
	
	public double getAverageRating(){
		return avera;
	}
		
	public boolean checkOut(){
		if(avail==true){
			avail=false;
			return true;
		}else{
			System.out.println(toString() + " is already checked out.");
			return false;
		}
	}
	
	public boolean returnToStore(){
		if(avail==false){
			avail=true;
			return true;
		}else{
			System.out.println(toString() + " is not checked out.");
			return false;
		}
	}
	
	public boolean isCheckedOut(){
		return !avail;
	}
	
	public String toString(){
		return ("Video[title=\"" + title + "\", checkedOut=" +!avail+"]");
	}
}
