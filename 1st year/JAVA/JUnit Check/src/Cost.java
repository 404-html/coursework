public class Cost {

	private int cost;
	private String currency;
	
	public Cost(){
		
	}
	
	public int getAmount(){
		return cost;
	}
	
	public void setAmount(int cost){
		this.cost=cost;
	}
	
	public String getCurrency(){
		return currency;
	}
	
	public void setCurrency(String currency){
		this.currency=currency;
	} 
	
	public void convert(String newCurrency, double rate){
		this.currency=newCurrency;
		double a =(double) cost/rate;
		System.out.println(a);
		this.cost =(int)Math.round(a); 
	}
	
	public String toString(){
		return cost+" "+currency;
	}
	
	public String secret(){
		return "s1413557";
	}
	
}
