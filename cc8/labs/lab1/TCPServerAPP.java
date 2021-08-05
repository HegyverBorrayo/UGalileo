/**
 * Library import connection
 */

import java.io.*;
import java.net.*;

//Librerias para fecha
import java.text.SimpleDateFormat;
import java.util.Date;

public class TCPServerAPP {
    public static void main(String args[]) {
        try {
            ServerSocket server_socket = new ServerSocket(8090);

            //Listening
            Socket client_socket = server_socket.accept();

            DataInputStream client_input = new DataInputStream(client_socket.getInputStream());
            DataOutputStream client_output = new DataOutputStream(client_socket.getOutputStream());

            String linea_cliente = "";

            //formato para log consol
            SimpleDateFormat date_format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

            //Ejecutar hasta que sea exit
            while (!linea_cliente.equals("exit") && !linea_cliente.equals("EXIT")){
                linea_cliente = client_input.readUTF();
                System.out.println("\n> " + client_socket.getInetAddress().toString().split("/")[1] + " client " + "[" + date_format.format(new Date()) + "]");
                System.out.println("TCP: "+ linea_cliente + "\n");

                //Lo que el cliente va recibir
                System.out.println("\n< " + client_socket.getLocalAddress().toString().split("/")[1] + " server " + "[" + date_format.format(new Date()) + "]");
                System.out.println("TCP: "+ linea_cliente.toUpperCase() + "\n");
                client_output.writeUTF(linea_cliente.toUpperCase());
            }

            //Para cuando termine la ejecucion
            System.out.println("\n[" + date_format.format(new Date()) + "] Server Stop \n");

            //Terminamos el socket u.u
            server_socket.close();
        } catch (Exception e) {
            //TODO: handle exception
            System.out.println("Dio error");
            System.out.println(e);
        }
    }
}