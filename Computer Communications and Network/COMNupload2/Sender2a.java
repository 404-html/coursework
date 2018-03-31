import java.io.File;
import java.io.FileInputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketTimeoutException;
import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeoutException;

/* Jianmeng Yu 1413557 */

public class Sender2a {

    private static String destinationName;
    private static int destinationPort;
    private static String filePath;
    private static int timeout;
    private static DatagramSocket socket;
    private static InetAddress destinationAddress;

    private static int sequence;
    private static boolean isLast;
    private static int windowStart;
    private static int windowSize;
    private static ArrayList<byte[]> pktList;

    private static Timer timer;
    private static boolean startTimer = true;
    private static boolean bTimeout = false;
    static TimeoutResend timeoutResend;

    private static class Timeout extends TimerTask {
        public void run() {
            bTimeout = true;//Start Resend
            //System.out.println ("Timeout");
        }
    }

    private static class TimeoutResend implements Runnable{
        @Override
        public void run() {
                while (true) {//System.out.println("Caught in a landslide");
                    if (bTimeout) {
                        //System.out.println("Resent packet " + windowStart + " to " + (Math.min(windowStart + windowSize, pktList.size()) - 1));
                        for (int i = windowStart; i < windowStart + windowSize && i < pktList.size(); i++) {
                            try {
                                byte[] sendByte = pktList.get(i);
                                DatagramPacket packet = new DatagramPacket(sendByte, sendByte.length, destinationAddress, destinationPort);
                                socket.send(packet);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                        startTimer = true;//Restart timer
                        bTimeout = false;//Stop resend;
                    }

                    if (windowStart == pktList.size()) {
                        break;
                    }
                }
        }
    }

    private static class SendPkt implements Runnable {
        @Override
        public void run() {
                try {
                    while (true) {//System.out.println("No escape from reality");

                        if (sequence < windowStart + windowSize && sequence < pktList.size()) {
                            byte[] sendByte = pktList.get(sequence);
                            DatagramPacket packet = new DatagramPacket(sendByte, sendByte.length, destinationAddress, destinationPort);
                            socket.send(packet);
                            if (windowStart == sequence) {
                                if (startTimer) {
                                    timer.schedule(new Timeout(), timeout, timeout);
                                    startTimer = false;
                                }
                            }
                            sequence++;
                            //System.out.println("Sequence changed to:" + sequence);
                        }

                        if (sequence == pktList.size()) {
                            break;
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
        }
    }

    public static void main(String[] args) {

        destinationName = args[0];
        destinationPort = Integer.parseInt(args[1]);
        filePath = args[2];
        timeout = Integer.parseInt(args[3]);
        windowSize = Integer.parseInt(args[4]);

        try {
            socket = new DatagramSocket();
            socket.setSoTimeout(timeout);
            destinationAddress = InetAddress.getByName(destinationName);

            File file = new File(filePath);
            byte[] bytes = new byte[(int) file.length()];
            FileInputStream fileInputStream = new FileInputStream(file);
            fileInputStream.read(bytes);
            fileInputStream.close();

            pktList = new ArrayList<byte[]>();
            pktList.add(new byte[0]);//Placeholder
            sequence = 1;

            //put stuff in pktList
            for (int i = 0 ; i < bytes.length; i = i +1024){
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
                    pktList.add(shortByte);
                }else{
                    //Case 2: not last byte
                    sendByte[2] = 0;
                    for (int j=0; j<1024; j++) {
                        sendByte[j+3] = bytes[i+j];
                    }
                    pktList.add(sendByte);
                }
                sequence++;
            }

            //Get ready to send packs
            sequence = 1;
            windowStart = 1;
            boolean ack;
            int lastCount = 0;
            long time = System.currentTimeMillis();

            timer = new Timer();
            //Start the send thread
            SendPkt send = new SendPkt();
            Thread sendThd = new Thread(send);
            sendThd.start();

            //Start the resend thread;
            timeoutResend = new TimeoutResend();
            Thread resendThd = new Thread(timeoutResend);
            resendThd.start();


            while (true){//System.out.println("Open your eyes, Look up to the skies and see");

                //Receive thread/Main Thread
                byte[] respondByte = new byte[2];
                DatagramPacket respondPkt = new DatagramPacket(respondByte, respondByte.length);
                try {
                    socket.setSoTimeout(timeout);
                    socket.receive(respondPkt);
                    ack = true;
                    lastCount =0;
                } catch (SocketTimeoutException e) {
                    ack = false;
                    lastCount++;
                }
                int respondSeq = (((respondByte[0] & 0xFF) << 8) + (respondByte[1] & 0xFF));

                if (ack) windowStart = respondSeq + 1;
                //System.out.println("Current Progress: " + windowStart + "/" + pktList.size());

                if (startTimer) {
                        timer.schedule (new Timeout(), timeout, timeout);
                        startTimer = false;
                    }

                if (windowStart == pktList.size()){
                    break;
                }

                if (lastCount > 10){
                    //Kill it with fire
                    //System.out.println("Last ACK not received");
                    sequence = pktList.size();
                    windowStart = pktList.size();
                    break;
                }
            }

            try {
                //ITS TIME TO STOP
                timer.cancel();
            } catch (Exception e) {}

            time = System.currentTimeMillis() - time;
            System.out.println("File size of: " + bytes.length + " byte transmitted. \n" +
                               "Spent       : " + time         + " mills to send. \n" +
                               "Having speed: " + (((double) bytes.length/1024)/((double) time/1000)) + "KBps \n");


        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}