import java.awt.Color;

public class ImageEditor1 {
	
	public static double luminance(Color color){
		double l =  color.getRed() * 0.299
				  + color.getBlue() * 0.114
			      + color.getGreen() * 0.587;
		return l;
	}
	
	public static Color toGrey(Color color){
		int l = (int) Math.round(luminance(color));
		Color c = new Color(l,l,l);
		return c;
	}
	
	public static Picture makeGreyscale(Picture pic){
		Picture p = new Picture(pic.width(), pic.height());
		for (int i=0;i<p.width();i++){
			for (int a=0;a<p.height();a++){
				p.set(i,a,toGrey(pic.get(i, a)));
			}
		}
		return p;
	}
	
	public static void main(String[] args){
		Picture p = new Picture("lion1.jpg");
		Picture greyscale = makeGreyscale(p);
		greyscale.show();
	}
}
