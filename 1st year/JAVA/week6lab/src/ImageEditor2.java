import java.awt.Color;

public class ImageEditor2 {
	
	public static Picture threshold(Picture p, int thresh){
		Picture pic = new Picture(p.width(), p.height());
		for (int i=0;i<pic.width();i++){
			for (int a=0;a<pic.height();a++){
				if(ImageEditor1.luminance(p.get(i,a))>=thresh){
					pic.set(i,a,ImageEditor1.toGrey(p.get(i, a)));
				}else{
					pic.set(i,a,Color.black);
				}
			}
		}
		return pic;
	}
	
	public static void main( String[] args ){
		Picture p = new Picture("lion1.jpg");
		Picture t = threshold(p, 120);
		t.show();
	}
	
}
