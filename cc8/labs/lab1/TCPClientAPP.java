/**
 * Library import
 */

import java.io.*;
import java.net.*;

//Librerias para fecha
import java.text.SimpleDateFormat;
import java.util.Date;

public class TCPClientAPP {
    public static void main(String args[]) {
        try {
            Socket socket = new Socket("127.0.0.1", 8090);
            //Para leer de consola
            BufferedReader input_console = new BufferedReader(new InputStreamReader(System.in));

            //leer del servidor
            DataInputStream server_input = new DataInputStream(socket.getInputStream());
            DataOutputStream server_output = new DataOutputStream(socket.getOutputStream());

            String linea_consola = "";

            SimpleDateFormat date_format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

            while (!linea_consola.equals("exit") && !linea_consola.equals("EXIT")){
                System.out.print("Ingrese cadena: ");
                linea_consola = input_console.readLine();
                
                System.out.println("\n> " + socket.getInetAddress().toString().split("/")[1] + " client " + "[" + date_format.format(new Date()) + "]");
                System.out.println("TCP: "+ linea_consola + "\n");
                server_output.writeUTF(linea_consola);
                
                //Lo que el cliente va recibir
                System.out.println("\n< " + socket.getLocalAddress().toString().split("/")[1] + " server " + "[" + date_format.format(new Date()) + "]");
                System.out.println("TCP: "+ server_input.readUTF() + "\n");
            }

            System.out.println("\n[" + date_format.format(new Date()) + "] Client Stop \n");

            input_console.close();
            server_output.close();
            socket.close();
        } catch (Exception e) {
            //TODO: handle exception
            System.out.println("Dio error");
            System.out.println(e);
        }
    }
}