
#!/bin/bash

df -T| sed -n '1!p'|awk '{print $1}'
