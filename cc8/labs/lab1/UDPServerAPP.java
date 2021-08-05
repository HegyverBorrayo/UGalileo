/**
 * Library import
 */
import java.io.*;
import java.net.*;


//Librerias para fecha
import java.text.SimpleDateFormat;
import java.util.Date;

public class UDPServerAPP {
    public static void main(String[] agrs) {
        try {
            DatagramSocket dt_socket_server = new DatagramSocket(8010);

            SimpleDateFormat date_format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

            String linea_cliente = "";

            while (!linea_cliente.equals("exit") && !linea_cliente.equals("EXIT")){
                //Lo que el server envia
                byte[] cadena_cliente_bytes = new byte[256];
                DatagramPacket dt_package_client = new DatagramPacket(cadena_cliente_bytes, 256);
                dt_socket_server.receive(dt_package_client);

                linea_cliente = new String(cadena_cliente_bytes).trim();
                System.out.println("\n< " + dt_package_client.getAddress().toString().split("/")[1] + " server " + "[" + date_format.format(new Date()) + "]");
                System.out.println("UDP: "+ linea_cliente + "\n");

                //obtener a quien le vamos a regresar
                InetAddress ip = dt_package_client.getAddress();
                int port = dt_package_client.getPort();

                String msg_cliente = linea_cliente.toUpperCase();

                byte[] cadena_server_bytes = new byte[256];
                cadena_server_bytes = msg_cliente.getBytes();
                DatagramPacket dt_package_server = new DatagramPacket(cadena_server_bytes, msg_cliente.length(), ip, port);

                //Enviar paquetescuetes
                dt_socket_server.send(dt_package_server);
                System.out.println("\n< " + dt_package_server.getAddress().toString().split("/")[1] + " server " + "[" + date_format.format(new Date()) + "]");
                System.out.println("UDP: "+ msg_cliente + "\n");
            }

            System.out.println("\n[" + date_format.format(new Date()) + "] Server Stop \n");
            
        } catch (Exception e) {
            //TODO: handle exception
            System.out.println("Dio error");
            System.out.println(e);
        }
    }
}
