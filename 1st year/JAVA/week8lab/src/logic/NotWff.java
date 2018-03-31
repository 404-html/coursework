package logic;

public class NotWff extends Wff {

	private Wff pl;
	private Operator op=null;
	
    public NotWff(Wff pl) {
        this.pl=pl;
        this.op=Operator.NEG;
    }

    public boolean eval(Valuation val){
        return !pl.eval(val);
    }
    
    public String toString() {
        String s = String.format("%s%s", op, pl);
        return s;
    }
}