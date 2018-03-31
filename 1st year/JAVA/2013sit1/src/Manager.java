import java.util.ArrayList;

public class Manager extends Engineer{

	private ArrayList<Engineer> team = new ArrayList<Engineer>();
	
	public Manager(String name, int salary){
		super(name,salary);
	}
	
	public ArrayList<Engineer> getTeam(){
		return team;
	}
	
	public void setTeam(ArrayList<Engineer> team){
		this.team = team;
	}
	
	public String toString(){
		String s = getName()+ " (" +getSalary() + ")" 
	      + "\n" + "Manages:";
		for (int i = 0; i < team.size();i++){
			s += "\n" + team.get(i).getName()+ " (" + team.get(i).getSalary() + ")";
		}
		return s;
	}
}
