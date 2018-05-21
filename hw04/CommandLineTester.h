/*
 * CommandLineTester.h
 *
 *  Created on: Feb 24, 2018
 *      Author: ajs94
 */

#ifndef COMMANDLINETESTER_H_
#define COMMANDLINETESTER_H_

#include "CommandLine.h"
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <cassert>
#include <sstream>
#include <cstring>

using namespace std;

class CommandLineTester {
public:
	void runTests() const;
	void testConstuctor() const;
	void testGetCommand() const;
	void testArgCount() const;
	void testArgVector() const;
	void testArgIndex() const;
	void testAmpersand() const;
};

#endif /* COMMANDLINETESTER_H_ */
