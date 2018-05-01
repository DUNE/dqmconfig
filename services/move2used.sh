#!/bin/sh

find . -maxdepth 1 -mindepth 1 -mmin $1 -size +1c -name "$2*" -exec mv {} $3 \;
