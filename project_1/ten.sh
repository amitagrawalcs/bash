#!/bin/bash


start_ts=$(date -d $1 '+%s')
end_ts=$(date -d $2 '+%s')
echo $(( ( end_ts - start_ts )/(60*60*24) ))

