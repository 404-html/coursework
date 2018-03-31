import java.util.Calendar;

public class CreditCard {

	private int expiryMonth;
	private int expiryYear;
    private String firstName;
    private String lastName;
    private String ccNumber;
    
	public CreditCard(int eM, int eY, String firstName, String lastName, String cNo){
		this.expiryMonth = eM;
		this.expiryYear = eY;
		this.firstName = firstName;
		this.lastName = lastName;
		this.ccNumber = cNo;
	}
	
	public String formatExpiryDate(){
		String s = expiryMonth + "/" + (expiryYear % 100);
		return s;
	}
	
	public String formatFullName(){
		String s = firstName + " " + lastName;
		return s;
	}
	
	public String formatCCNumber(){
		String s1 = ccNumber.substring(0,4);
		String s2 = ccNumber.substring(4,8);
		String s3 = ccNumber.substring(8,12);
		String s4 = ccNumber.substring(12,16);
		String s = s1 + " " + s2 + " " + s3 + " " + s4;
		return s;
	}
	
	public boolean isValid(){
		Calendar now = Calendar.getInstance();
		Boolean s = false;
		if (now.get(Calendar.YEAR)>expiryYear){}else{
			if(now.get(Calendar.YEAR)==expiryYear){
				if(now.get(Calendar.MONTH)+1<expiryMonth){s = true;}
			}else{
				s = true;
			}
		}
		return s;
	}
	
	public String toString(){
		String s = "Number: " + formatCCNumber() + "\n"
				 + "Expiration date: " + formatExpiryDate() + "\n"
				 + "Account holder: " + formatFullName() + "\n"
				 + "Is valid: " + isValid();
		return s;
	}
}
