import java.io.File;
import java.io.FileInputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketTimeoutException;

/* Jianmeng Yu 1413557 */

public class Sender1b {

    public static void main(String[] args) {

        String destinationName = args[0];
        int destinationPort = Integer.parseInt(args[1]);
        String filePath = args[2];
        int timeout = Integer.parseInt(args[3]);

        try {
            DatagramSocket socket = new DatagramSocket();
            InetAddress destinationAddress = InetAddress.getByName(destinationName);

            File file = new File(filePath);
            byte[] bytes = new byte[(int) file.length()];
            FileInputStream fileInputStream = new FileInputStream(file);
            fileInputStream.read(bytes);
            fileInputStream.close();

            int sequence = 0;
            boolean isLast = false;
            int retrCount = 0;
            int lastRetrCount = 0;

            long time = System.currentTimeMillis();

            for (int i = 0 ; i < bytes.length ; i = i + 1024) {
                byte[] sendByte = new byte[1027];
                sendByte[0] = (byte) (sequence >> 8);
                sendByte[1] = (byte) (sequence);
                isLast = (i+1024 >= bytes.length);
                if (isLast) {
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

                boolean respond = false;
                boolean ackRespond = false;

                while (!ackRespond){
                    byte[] respondByte = new byte[3];
                    DatagramPacket respondPkt = new DatagramPacket(respondByte,respondByte.length);
                    try {
                        socket.setSoTimeout(timeout);
                        socket.receive(respondPkt);
                        respond = true;
                    } catch (SocketTimeoutException e) {
                        respond = false;
                    }
                    ackRespond = (((respondByte[0] & 0xFF) << 8) + (respondByte[1] & 0xFF)) == sequence && //Check sequence
                                 ((respondByte[2] & 0xFF) == 1) &&                                         //Check ACK
                                  respond;                                                                 //Check respond
                    if (!ackRespond) {
                        //Resend pkt if no correct respond received
                        retrCount++;
                        socket.send(packet);
                        if (isLast) {
                            lastRetrCount++;
                            if (lastRetrCount > 50) {
                                ackRespond = true;//Close enough.
                            }
                        }
                    }
                }
                if (sequence == 0) {sequence = 1;} else {sequence = 0;}//Flip sequence
            }
            socket.close();
            time = System.currentTimeMillis() - time;
            System.out.println("File size of: " + bytes.length + " byte transmitted. \n" +
                               "Spent       : " + time         + " mills to send. \n" +
                               "Having speed: " + ((double) (bytes.length/1024)/(time/1000)) + "KBps \n" +
                               "Retransmit  : " + retrCount    + " times. \n" +
                               "Last pkt Ret: " + lastRetrCount + " times.");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
