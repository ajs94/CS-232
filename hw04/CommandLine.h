/*
 * CommandLine.h
 *
 *  Created on: Feb 23, 2018
 *      Author: ajs94
 */

#ifndef COMMANDLINE_H_
#define COMMANDLINE_H_

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>
#include <cstring>		// strtok()
#include <string>

using namespace std;

class CommandLine {
public:
	CommandLine(istream &in);
	char* getCommand() const;
	int getArgCount() const;
	char** getArgVector() const;
	char* getArgVector(int i) const;
	bool noAmpersand() const;
	virtual ~CommandLine();

	char* command_line;
	char** argv;
	int argc;
};

#endif /* COMMANDLINE_H_ */
