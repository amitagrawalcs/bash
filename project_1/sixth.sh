#!/bin/bash

echo '<==========IP address=============>'
cat access.log| awk '{print $1}'|sort | uniq -c|sort -n -r

echo -e '\n'
echo '<==========Responses=============>'

cat access.log| awk '{print $9}'| grep -v 200|sort | uniq -c| sort -n -r

