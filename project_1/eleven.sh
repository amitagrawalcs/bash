#!/bin/bash

DAYS="$(cal $(date +"%m %Y") | tail -2 | sed 2d | awk '{print $NF}')"

DAY="$(date +'%d')";
DAY=$((10#$DAY))
MONTH="$(date +'%b')"
YEAR="$(date +'%Y')"

for (( days=$DAY; days<=$DAYS; days++ ))
do
	if [ $days -le 9 ];then echo "0$days-$MONTH-$YEAR";else echo "$days-$MONTH-$YEAR"; fi
done
