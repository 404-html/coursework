
public class testCC {
	public static void main(String[] args){
		CreditCard cc1 = new CreditCard(10, 2014, "Bob", "Jones", "1234567890123456");
		System.out.println(cc1.formatExpiryDate());
		System.out.println(cc1.formatFullName());
		System.out.println(cc1.formatCCNumber());
		System.out.println(cc1.isValid());
		System.out.println(cc1.toString());
	}

}
