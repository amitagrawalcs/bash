#!/bin/bash
   
value=$1
index=10
while [ $index -ge 1 ]
do
	echo $(( value*index ))
    	index=$(( index-1 ))
done
