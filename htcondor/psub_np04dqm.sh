#!/bin/bash

export A=''
if [ -z "$1" ]
  then
    echo "No extra arguments supplied"
    exit
else
    export A=$1
fi


source /afs/cern.ch/user/n/np04dqm/public/vp3s/bin/activate
/afs/cern.ch/user/n/np04dqm/projects/p3s/clients/pilot.py $A

