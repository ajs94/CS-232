/*
 * CommandLineTester.cpp
 *
 *  Created on: Feb 24, 2018
 *      Author: ajs94
 */

#include "CommandLineTester.h"

void CommandLineTester::runTests() const {
	testConstuctor();
	testGetCommand();
	testArgCount();
	testArgVector();
	testArgIndex();
	testAmpersand();
}

void CommandLineTester::testConstuctor() const {
	cout << "Testing constructor..." << flush;
	istringstream is("test -t testing");
	CommandLine test(is);

	assert( !(strcmp( test.command_line, "test -t testing")) );
	cout << " 1 " << flush;

	assert( test.argc == 3);
	cout << " 2 " << flush;

	assert( !( strcmp( test.argv[0], "test")) );
	cout << " 3 " << flush;

}

void CommandLineTester::testGetCommand() const {

}

void CommandLineTester::testArgCount() const {

}

void CommandLineTester::testArgVector() const {

}

void CommandLineTester::testArgIndex() const {

}

void CommandLineTester::testAmpersand() const {

}
