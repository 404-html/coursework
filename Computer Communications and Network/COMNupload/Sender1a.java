import java.io.File;
import java.io.FileInputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

/* Jianmeng Yu 1413557 */

public class Sender1a {
	
	public static void main(String[] args) {

        String destinationName = args[0];
        int destinationPort = Integer.parseInt(args[1]);
        String filePath = args[2];

		try {
			DatagramSocket socket = new DatagramSocket();
            InetAddress destinationAddress = InetAddress.getByName(destinationName);

            File file = new File(filePath);
            byte[] bytes = new byte[(int) file.length()];
            FileInputStream fileInputStream = new FileInputStream(file);
            fileInputStream.read(bytes);
            fileInputStream.close();

            int sequence = 0;

            for (int i = 0 ; i < bytes.length ; i = i + 1024) {
                byte[] sendByte = new byte[1027];//1027 is weird
                sendByte[0] = (byte) (sequence >> 8);
                sendByte[1] = (byte) (sequence);
                if (i+1024 >= bytes.length) {
                    //Case 1: last byte
                    sendByte[2] = 1;
                    for (int j = 0 ; j < bytes.length-i ; j++) {
                        sendByte[j+3] = bytes[i+j];
                    }
                    byte[] shortByte = new byte[bytes.length-i+3];
                    for (int j = 0 ; j < bytes.length-i+3; j++) {
                        shortByte[j] = sendByte[j];
                    }
                    sendByte = shortByte;
                }else{
                    //Case 2: not last byte
                    sendByte[2] = 0;
                    for (int j=0; j<1024; j++) {
                        sendByte[j+3] = bytes[i+j];
                    }
                }

                DatagramPacket packet = new DatagramPacket(sendByte, sendByte.length, destinationAddress, destinationPort);
                socket.send(packet);
                sequence++;
                Thread.sleep(10);//---------------Sleep!--------------
            }
            socket.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
}
