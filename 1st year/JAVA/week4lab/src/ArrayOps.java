
public class ArrayOps {

    public static double findMax(double[] data) {
    	double a = 0;
    	for (int i = 0 ; i < data.length ; i++){
    		boolean test = true;
    		for (int g = 0 ; g < data.length ; g++){
    			test = test && (data[i]>=data[g]);}
    		if (test) {a = data[i];}}
    	return a;
    }

    public static double[] normalise(double data[]) {
    	double[] newA = new double[data.length];
        double sum = 0;
        for (int i = 0 ; i < data.length ; i++) {
        	sum = sum + data[i];
        }
        for (int i = 0 ; i < data.length ; i++) {
        	newA[i] = data[i] / sum;
        }
        return newA;
    }

    public static void normaliseInPlace(double data[]) {
        double sum = 0;
        for (int i = 0 ; i < data.length ; i++) {
        	sum = sum + data[i];
        }
        for (int i = 0 ; i < data.length ; i++) {
        	data[i] = data[i] / sum;
        }
    }

    public static double[] reverse(double[] data) {
    	double[] newA = new double[data.length];
        for (int i = 0 ; i < data.length ; i++) {
        	newA[data.length-1-i] = data[i];
        }
        return newA;
    }

    public static void reverseInPlace(double[] data) {
    	double[] newA = new double[data.length];
        for (int i = 0 ; i < data.length ; i++) {
        	newA[data.length-1-i] = data[i];
        }
        for (int i = 0 ; i < data.length ; i++) {
        	data[i] = newA[i];
        }
    }

    public static void swap(double[] data1, double[] data2) {
    	double[] newA = new double[data1.length];
    	for (int i = 0 ; i < data1.length ; i++) {
        	newA[i] = data1[i];}
    	for (int i = 0 ; i < data1.length ; i++) {
        	data1[i] = data2[i];}
    	for (int i = 0 ; i < data1.length ; i++) {
        	data2[i] = newA[i];}
    }

}
