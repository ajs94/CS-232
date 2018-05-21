#!/bin/bash
LANG=C

removespaces() {
echo "$1" | sed -e "s/ //g"
}

inputfile="$@"
cd "$inputfile"
ls

for file in *_assignsubmission_onlinetext_;
do
	#thinks name is a function...
	name = $file | sed "s/^.*_assignsubmission_onlinetext_/_assignsubmission_onlinetext_/"
	echo $name
	mkdir $(removespaces "$name")
done