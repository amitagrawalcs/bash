#!/bin/bash

mount | column -t | awk '{print $1,$2,$3,$4,$5}'

