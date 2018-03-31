public class Rectangle {

	private Point2DDouble TL;
	private Point2DDouble BR;
	
	public Rectangle(Point2DDouble topLeft, Point2DDouble bottomRight){
		this.TL= topLeft;
		this.BR= bottomRight;
	}
	
	public Rectangle(){
		this.TL=new Point2DDouble(0,0);
		this.BR=new Point2DDouble(1,1);
	}
	
	public boolean isPointInside(Point2DDouble pt){
		boolean xin = ((pt.getX() < BR.getX()) && (pt.getX() > TL.getX()))
				   || ((pt.getX() > BR.getX()) && (pt.getX() < TL.getX()));
		boolean yin = ((pt.getY() < BR.getY()) && (pt.getY() > TL.getY()))
				   || ((pt.getY() > BR.getY()) && (pt.getY() < TL.getY()));
		return xin&&yin;
	}
}
