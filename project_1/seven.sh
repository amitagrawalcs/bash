
#!/bin/bash

df | sed 1d|awk '{print $1}'
