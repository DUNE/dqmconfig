#!/bin/bash

export A=''
if [ -z "$1" ]
  then
    echo "No extra arguments supplied"
    exit
else
    export A=$1
fi


source /afs/cern.ch/user/m/mxp/vp3s/bin/activate
/afs/cern.ch/user/m/mxp/projects/p3s/clients/pilot.py $A

