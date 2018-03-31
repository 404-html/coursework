import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

/* Jianmeng Yu 1413557 */

public class Receiver1a {

    public static void main(String[] args){

        int port = Integer.parseInt(args[0]);
        String outputPath = args[1];

        try {
            File file = new File(outputPath);
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            DatagramSocket socket = new DatagramSocket(port);

            byte[] packetByte = new byte[1027];//1027 is weird
            byte[] fileByte = new byte[1024];

            int sequence;
            int expectedSequence = 0;
            boolean last = false;
            while (!last){
                DatagramPacket packet = new DatagramPacket(packetByte,packetByte.length);
                socket.receive(packet);
                sequence = ((packetByte[0] & 0xFF) << 8) + (packetByte[1] & 0xFF);
                last = (packetByte[2]& 0xFF) == 1;
                for (int i=0; i<fileByte.length; i++) {
                    fileByte[i] = packetByte[i+3];
                }
                if (last) {
                    byte[] lastByte = new byte[packet.getLength()];
                    for (int i = 0; i < packet.getLength() ; i ++ ){
                        lastByte[i] = fileByte[i];
                    }
                    fileByte = lastByte;
                }
                if (sequence == expectedSequence){
                    byteArrayOutputStream.write(fileByte);
                    expectedSequence ++;
                }
            }
            fileOutputStream.write(byteArrayOutputStream.toByteArray());

            fileOutputStream.close();
            byteArrayOutputStream.close();
            socket.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
