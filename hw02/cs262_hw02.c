/* CS 232 Homework 2: The purpose of this homework is to give the 
 * 		student experience writing a low-level tool in C, using 
 * 		multiple POSIX systems calls, and handling all possible failure conditions
 * 
 * by Aaron Santucci
 * February 13, 2018
 */


#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

int main (int argc, char * argv[]) {
	
	FILE * file_buffer, * copy_buffer;
	char * src = argv[1];
	char * dest = argv[2];
	char character;
	
	/* code for checking if file is regular suggested from 
	https://stackoverflow.com/questions/4553012/checking-if-a-file-is-a-directory-or-just-a-file */
	struct stat path_stat;
	stat(src, &path_stat);
	if (S_ISREG(path_stat.st_mode))
	{
		// check for access permission
		if (access(dest, W_OK) != -1) {
			fprintf(stderr, "File already exists: %s\n", dest);
			return -1;
		}
		if(access(src, R_OK) != 0 ) {
			fprintf(stderr, "Permission denied: %s\n", src);
			return -1;
		}

		// open files and check the connections
		file_buffer = fopen(src, "r");
		if (file_buffer == NULL) {
			fprintf(stderr, "Can't open input file %s\n", src);
			return -1;
		}
		copy_buffer = fopen(dest, "w");
		if (copy_buffer == NULL) {
			fprintf(stderr, "Can't open output file %s\n", dest);
			return -1;
		}

		// copy the file
		printf("Copying %s to %s . . .\n", src, dest);
		character = fgetc(file_buffer);
		while ( character != EOF) {
			fputc(character, copy_buffer);
			character = fgetc(file_buffer);		
		}

		fclose(file_buffer);
		fclose(copy_buffer);
		return 0;
	}
	else { fprintf(stderr, "File is not regular: %s\n", src); }
	return -1;
}