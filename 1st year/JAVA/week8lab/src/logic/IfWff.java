package logic;
public class IfWff extends BinaryWff {

    public IfWff(Wff left, Wff right) {
        super(left, right);
        setOp(Operator.IF);
    }

    public boolean eval(Valuation val){
        return (!(getLeft().eval(val)) || getRight().eval(val));
    }
}