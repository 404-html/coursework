import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.*;

/* Jianmeng Yu 1413557 */

public class Receiver2b {

    public static void main(String[] args){

        int port = Integer.parseInt(args[0]);
        String outputPath = args[1];
        int windowSize = Integer.parseInt(args[2]);

        try {
            DatagramSocket socket = new DatagramSocket(port);

            byte[] packetByte = new byte[1027];
            byte[] fileByte = new byte[1024];

            int sequence;
            int windowStart = 1;
            int lastSequence = -1;
            HashMap<Integer, byte[]> received = new HashMap<Integer, byte[]>();

            while (true){
                DatagramPacket packet = new DatagramPacket(packetByte,packetByte.length);
                socket.receive(packet);
                sequence = ((packetByte[0] & 0xFF) << 8) + (packetByte[1] & 0xFF);
                //System.out.println("PKT of sequence " + sequence + " received.");

                //Send ACK
                byte[] sendByte = new byte[2];
                sendByte[0] = (byte) (sequence >> 8);
                sendByte[1] = (byte) (sequence);
                InetAddress startIP = packet.getAddress();
                int startPort = packet.getPort();
                DatagramPacket ack = new DatagramPacket(sendByte, sendByte.length, startIP, startPort);
                socket.send(ack);
                //System.out.println("ACK of sequence " + sequence + " sent.");

                //if in window
                if (sequence >= windowStart && sequence < (windowStart + windowSize)){

                    boolean last = (packetByte[2]& 0xFF) == 1;

                    //Write/Overwrite pkt
                    for (int i=0; i<fileByte.length; i++) {
                        fileByte[i] = packetByte[i+3];
                    }
                    if (last) {//Remove blanks
                        byte[] lastByte = new byte[packet.getLength()-3];
                        for (int i = 0; i < packet.getLength()-3 ; i ++ ){
                            lastByte[i] = fileByte[i];
                        }
                        fileByte = lastByte;
                    }
                    //DAMN HASHMAPS
                    //received.put(sequence, fileByte);
                    received.put(sequence, Arrays.copyOf(fileByte, fileByte.length));

                    //Move Window when available
                    if (sequence == windowStart) {
                        while (true) {
                            if (received.containsKey(windowStart)) {
                                windowStart++;
                                //System.out.println("Window Changed to: " + windowStart);
                            } else {
                                break;
                            }
                        }
                    }

                    //Update last sequence
                    if (last) {
                        lastSequence = sequence;
                    }

                    //Stop if received everything
                    if (lastSequence != -1 && lastSequence == received.size()){
                        break;
                    }
                }
            }

            //Write the actual file
            File file = new File(outputPath);
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            ArrayList<Integer> keys = new ArrayList<Integer>(received.keySet());
            Collections.sort(keys);
            for (int i = 0 ; i < lastSequence ; i++){
                if (i+1 != keys.get(i)) System.out.println(i+1 + " " + keys.get((i)));
            }
            for (Integer i : keys){
                //System.out.println(i);
                try { byteArrayOutputStream.write(received.get(i)); } catch (Exception e) {}
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
