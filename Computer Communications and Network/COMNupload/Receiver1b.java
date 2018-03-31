import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

/* Jianmeng Yu 1413557 */

public class Receiver1b {

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
                    if (expectedSequence == 0) {expectedSequence = 1;} else {expectedSequence = 0;}//Flip sequence
                }
                byte[] sendByte = new byte[3];
                sendByte[0] = (byte) (sequence >> 8);
                sendByte[1] = (byte) (sequence);
                sendByte[2] = 1;
                InetAddress startIP = packet.getAddress();
                int startPort = packet.getPort();
                DatagramPacket ack = new DatagramPacket(sendByte, sendByte.length, startIP, startPort);
                socket.send(ack);
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
