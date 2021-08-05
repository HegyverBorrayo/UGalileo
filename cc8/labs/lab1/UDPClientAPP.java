/**
 * Library import
 */
import java.io.*;
import java.net.*;


//Librerias para fecha
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * UDPClientAPP
 */
public class UDPClientAPP {
    public static void main(String args[]) {
        try {
            DatagramSocket dt_socket = new DatagramSocket();
            
            SimpleDateFormat date_format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

            BufferedReader input_console = new BufferedReader(new InputStreamReader(System.in));

            String linea_consola = "";

            while (!linea_consola.equals("exit") && !linea_consola.equals("EXIT")){
                System.out.print("Ingrese cadena: ");
                linea_consola = input_console.readLine();
                
                //preparamos todo para enviar al server
                byte[] cadena_cliente_bytes = new byte[256];
                cadena_cliente_bytes = linea_consola.getBytes();
                DatagramPacket dt_package = new DatagramPacket(cadena_cliente_bytes, linea_consola.length(), InetAddress.getByName("127.0.0.1"), 8010);
                dt_socket.send(dt_package);

                System.out.println("\n> " +  " client " + dt_package.getAddress().toString().split("/")[1] +"[" + date_format.format(new Date()) + "]");
                System.out.println("UDP: "+ linea_consola + "\n");

                //Lo que el cliente va recibir del server
                byte[] cadena_server_bytes = new byte[256];
                DatagramPacket dt_package_server = new DatagramPacket(cadena_server_bytes, 256);
                dt_socket.receive(dt_package_server);
                
                String server_msg = new String(cadena_server_bytes).trim();
                System.out.println("\n< " + dt_package_server.getAddress().toString().split("/")[1] + " server " + "[" + date_format.format(new Date()) + "]");
                System.out.println("UDP: "+ server_msg + "\n");
            }

            System.out.println("\n[" + date_format.format(new Date()) + "] Client Stop \n");
            
            //cerramos todo
            dt_socket.close();
        } catch (Exception e) {
            //TODO: handle exception
            System.out.println("Dio error");
            System.out.println(e);
        }
    }
    
}