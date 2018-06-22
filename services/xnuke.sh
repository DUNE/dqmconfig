#!/bin/bash

for f in `ls`; do
    echo removing $f
    eos root://eospublic.cern.ch rm -r $1/$f
done 
