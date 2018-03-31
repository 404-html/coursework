import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

/* Jianmeng Yu 1413557 */

public class Receiver2a {

    public static void main(String[] args){

        int port = Integer.parseInt(args[0]);
        String outputPath = args[1];

        try {
            File file = new File(outputPath);
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            DatagramSocket socket = new DatagramSocket(port);

            byte[] packetByte = new byte[1027];
            byte[] fileByte = new byte[1024];

            int sequence;
            int expectedSequence = 1;
            boolean last = false;
            while (!last){
                DatagramPacket packet = new DatagramPacket(packetByte,packetByte.length);
                socket.receive(packet);
                sequence = ((packetByte[0] & 0xFF) << 8) + (packetByte[1] & 0xFF);
                //System.out.println("PKT of sequence " + sequence + " received.");

                if (sequence == expectedSequence){
                    last = (packetByte[2]& 0xFF) == 1;
                    for (int i=0; i<fileByte.length; i++) {
                        fileByte[i] = packetByte[i+3];
                    }
                    if (last) {
                        byte[] lastByte = new byte[packet.getLength()-3];
                        for (int i = 0; i < packet.getLength()-3 ; i ++ ){
                            lastByte[i] = fileByte[i];
                        }
                        fileByte = lastByte;
                    }
                    byteArrayOutputStream.write(fileByte);
                    expectedSequence++;
                }
                byte[] sendByte = new byte[2];
                sendByte[0] = (byte) ((expectedSequence-1) >> 8);
                sendByte[1] = (byte) ((expectedSequence-1));
                InetAddress startIP = packet.getAddress();
                int startPort = packet.getPort();
                DatagramPacket ack = new DatagramPacket(sendByte, sendByte.length, startIP, startPort);
                socket.send(ack);
                //System.out.println("ACK of sequence " + (expectedSequence-1) + " sent.");
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
