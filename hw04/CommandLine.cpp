/*
 * CommandLine.cpp
 *
 *  Created on: Feb 23, 2018
 *      Author: ajs94
 */

#include "CommandLine.h"

CommandLine::CommandLine(istream &in) {
	char c;
	while (in.get(c)) {
		if (c == ' ')
			argc++;
		command_line += c;
	}
	//strcat(command_line, '\0');

	argv = getArgVector();
}

char* CommandLine::getCommand() const {
	return argv[0];
}

int CommandLine::getArgCount() const {
	return argc;
}

char** CommandLine::getArgVector() const {
	char* argument = strtok(command_line, " ");

	int count = 0;
	while (argument != NULL) {
		cout << argument << flush;
		argv[count] = (char*) malloc((sizeof(argument)));
		argv[count] = argument;
		count++;
	}

	return argv;
}

char* CommandLine::getArgVector(int i) const {
	return argv[i];
}

bool CommandLine::noAmpersand() const {
	return strstr(command_line, "&");
}

CommandLine::~CommandLine() {
	free(argv);
}

