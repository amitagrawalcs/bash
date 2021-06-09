#!/bin/bash

COUNT=0

for i in $(cat file.txt)
do
	COUNT=$(( COUNT+1 ))
	#hash ${i} 2>/dev/null;
	COMMAND="$(command -v ${i})"
	STATUS=$?
	CORRECT=0
	#if [ $CORRECT == $STATUS ]
	if [ $COMMAND ] # if COMMAND is non empty
	then
		echo "$COUNT. $(${i} --version | head -1)"
	else 
		echo "$COUNT. The utility \"$i\" is not installed"
	fi
	
#	VAR="$(${i} --version)"
#	echo $VAR
done

