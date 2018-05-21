/* CaesarCypherServer.java
 * Server takes connections and encrypts plaintext from user
 * By: Aaron Santucci
 * For: CS 232
 * Threadpools: http://www.baeldung.com/thread-pool-java-and-guava
 * Callable:	https://www.geeksforgeeks.org/callable-future-java/
 				https://stackoverflow.com/questions/9992992/is-there-a-way-to-take-an-argument-in-a-callable-method?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
 */

import java.util.Scanner;
import java.io.*;
import java.net.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.*;
import java.util.Date;

public class CaesarCipherServer
{
	public static void main(String[] args)
	{
		// thread pool for new connections; currently capped at 10
		ExecutorService threadPool = Executors.newFixedThreadPool(10);
		
		int port = Integer.parseInt(args[0]);
		try {
			ServerSocket serverSocket = new ServerSocket(port);
			
			while (true) {
				Socket clientSocket = serverSocket.accept();
				CallableConnection connection = new CallableConnection(clientSocket);
				threadPool.submit(connection);
			}
		}
		catch (IOException e) {
			System.out.println("Error creating server on port " + port);
		}
	}
	
    public static String CaesarCipher(String plainText, int offset)
    {
        String cipherText = "";
		char cipherChar;
        for (int i = 0; i < plainText.length(); i++)
        {
			if (Character.isUpperCase(plainText.charAt(i))) {
				cipherChar = (char)(((int)plainText.charAt(i) + offset - 65) % 26 + 65);
			}
			else if (Character.isLowerCase(plainText.charAt(i))) {
				cipherChar = (char)(((int)plainText.charAt(i) + offset - 97) % 26 + 97);
			}
			else {
				cipherChar = plainText.charAt(i);
			}
			cipherText += cipherChar;
        } 
        return cipherText;
    }

	private static class CallableConnection implements Callable
	{
		private Socket clientSocket;
		
		public CallableConnection(Socket clientSocket)
		{
			this.clientSocket = clientSocket;
		}
		
		public Integer call()
		{
			Date date = new Date();
			String clientIP = clientSocket.getInetAddress().getHostAddress();
			System.out.println("Connecting socket\n" + date + "\nWith IP " + clientIP + "\n");
			
			try {
				BufferedReader inputStream = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
				OutputStream outputStream = clientSocket.getOutputStream();
				PrintWriter outputPrint = new PrintWriter(outputStream);
				
				// get the offset value
				String offset;
				offset = inputStream.readLine();
				outputPrint.append(offset + "\n");
				outputPrint.flush();
				
				// get the plaintext and encrypt it
				String plainText;
				while ( (plainText = inputStream.readLine()) != null ) {

					System.out.print("Encrypting a cipher");
					outputPrint.append(CaesarCipher(plainText, Integer.parseInt(offset)) + "\n");
					
					// needs to flush twice for some reason?
					outputPrint.flush();
					outputPrint.flush();
				}
				
				// close streams and socket
				System.out.println("Closing connection");
				inputStream.close();
				outputStream.close();
				clientSocket.close();
			}
			catch (IOException e) {
				System.out.println("Error on client connecting to port");
			}			
			return 0;
		}
	}
}