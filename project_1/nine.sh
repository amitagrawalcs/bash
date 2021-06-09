#!/bin/bash

df | awk '{print $1 "              " $6}'

