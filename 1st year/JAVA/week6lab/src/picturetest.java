import java.awt.Color;

public class picturetest {

    private static Picture createPicture(Color colour, int width, int height) {
        Picture picture = new Picture(width, height);
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                picture.set(i, j, colour);
            }
        }
        return picture;
    }
    
    public static void main( String[] args){
    	int width = 20, height = 30;
        Picture original = createPicture(new Color(200, 0, 0), width, height);
        original.show();
    }
}
