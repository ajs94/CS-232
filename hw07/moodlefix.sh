#!/bin/bash
LANG=C
# moodlefix bash script for CS 232
# by Aaron Santucci
# usage: -v(optional) "Archive Name"


iszipfile() {
	echo "$1" | sed -e "s/ //g"
}

removespaces() {
	echo "$1" | sed -e "s/ //g"
}

# returns the new moodle directory's name
getdirname() {
	echo "$1" | sed -e "s/\-[0-9][0-9][0-9][0-9][0-9][0-9]*.*//g"
}

# returns the student's name
getname() {
	echo "$1" | sed "s/\_.*$//"
}

# returns the onlinetext folder in the moodle directory
getonlinetext() {
	echo "$1" | sed -e "s/file/onlinetext/"
}

# parse arguments
if [ $# -eq 1 ]
then
	inputfile="$@"
else
	OPTS=`getopt -o v:: --long verbose:: -- "$@"`
	for arg in $@; do
		case $1 in
			-v | --verbose ) verbose_flag=true ;;
		esac
	done
	inputfile="$2"
fi

#make sure file exists
if [ ! -f "$inputfile" ]
	then
	echo "File $inputfile doesn't exist"
	exit
fi

# create the new directory or exit if it exists
directory=$(getdirname "$inputfile")
if [ ! -d "$directory" ]
then
	if [ $verbose_flag ]
	then
		echo "Making directory $directory"
	fi
	mkdir "$directory"
else
	echo "Directory $directory already exists"
	exit
fi

# unzip the inputfile
if [ $verbose_flag ]
then
	echo "Unzipping file $inputfile"
	unzip "$inputfile" -d "$directory"
else 
	unzip -q "$inputfile" -d "$directory"
fi
cd "$directory"

# create each student's new folder and move their stuff
for assignsub in *_assignsubmission_file_;
do
	name=$(getname "$assignsub")
	nospacesname=$(removespaces "$name")
	if [ "$name" == "" ]
	then
		echo "Could not get name from folder $assignsub"
		exit
	fi
	
	otherfile=$(getonlinetext "$assignsub")
	if [ "$otherfile" == "" ]
	then
		echo "Could not find onlinetext for $name"
		exit
	fi
	
	if [ $verbose_flag ]
	then
		echo "Combining directories for $name | $assignsub $otherfile"
	fi
	
	mv "$assignsub" "$nospacesname"
	rsync -a "$otherfile/" "$nospacesname/"
	rm -rf "$otherfile"
	
	cd "$nospacesname";
	for file in *;
	do
		# Check if .zip file
		if [[ $file == *.zip ]];
		then
			if [ $verbose_flag ]
			then
				unzip -n "$file"
			else
				unzip -q -n "$file"
			fi
		fi
		
		# Remove spaces if needed
		if [ "$file" != "$(removespaces "$file")" ] || [ $verbose_flag ]
		then
			mv -f "$file" "$(removespaces "$file")"
		fi
	done
	cd ..
done