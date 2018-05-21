/* CaesarCypherClient.java
 * Client connects to a server to encrypt input from user.
 * By: Aaron Santucci
 * For: CS 232
 */

import java.util.Scanner;
import java.io.*;
import java.net.*;

public class CaesarCipherClient
{
	public static void main(String[] args) throws IOException
	{
		// test to make sure these are valid
		String server = args[0];
		int port = Integer.parseInt(args[1]);
		
		System.out.printf("----\tCaesar Cipher Client\t----\n" + "Server: " + server + "\nPort: " + port + "\nPlease enter offset integer: ");
		
		// get offset from user and check if valid
		Integer offset;
		while (true) {
			Scanner temp = new Scanner(System.in);
			try {
				offset = temp.nextInt();
				if (offset > 0 && offset < 26) {	
					break;	
				} else {
					System.out.printf("\nPlease enter a valid integer: \n");
				}
			} catch(Exception i) {
				System.out.printf("\nPlease enter a valid integer: \n");
			}
		}
		
		Socket clientSocket = new Socket(server, port);

		DataOutputStream outputStream = new DataOutputStream(clientSocket.getOutputStream());
		PrintWriter outputPrint = new PrintWriter(outputStream);
		outputPrint.append(offset.toString() + "\n");
		outputPrint.flush();

		BufferedReader inputStream = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
		String ciphertext = inputStream.readLine();

		Scanner plainInput = new Scanner(System.in);

		while(true) {
			System.out.println("Enter the string to encrypt (type quit to exit): ");
			String plaintext = plainInput.nextLine();

			if (plaintext.equals("quit")) 
			{
				System.out.println("----\tQuitting Caesar Cipher\t----");
				System.exit(0);
			}

			outputPrint.append(plaintext + "\n");
			outputPrint.flush();

			ciphertext = inputStream.readLine();
			if (ciphertext != null)
				System.out.println("Encryption: " + ciphertext);
		}

		
	}
}