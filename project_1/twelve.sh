#!/bin/bash

COUNT=0

for i in $(cat file.txt)
do
	COUNT=$(( COUNT+1 ))
	COMMAND="$(command -v ${i})"
	STATUS=$?
	CORRECT=0
	if [ $STATUS == 0 ] # if COMMAND is non empty
	then
		echo "$COUNT. $(${i} --version | head -1)"
	elif [ $STATUS == 1 ]
	then 
		echo "$COUNT. The utility \"$i\" is not installed"
	else 
		echo "Something went wrong"
	fi
done

